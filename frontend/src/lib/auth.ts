import { useState, useEffect, useCallback } from 'react';
import axios from 'axios';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';

// Формируем базовый URL для API
// Если NEXT_PUBLIC_API_URL уже содержит /api, не добавляем его снова
const baseURL = API_BASE_URL.endsWith('/api') 
    ? `${API_BASE_URL}/auth/` 
    : `${API_BASE_URL}/api/auth/`;

// Создаем экземпляр axios с базовой конфигурацией
export const authApi = axios.create({
    baseURL,
    headers: {
        'Content-Type': 'application/json',
    },
    withCredentials: true,
});

// Интерцептор для добавления токена к запросам
authApi.interceptors.request.use((config) => {
    let token = localStorage.getItem('auth_token');
    if (!token && typeof document !== 'undefined') {
        // fallback: читаем токен из cookie auth-token для клиента
        const match = document.cookie.match(/auth-token=([^;]+)/);
        if (match) token = match[1];
    }
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

// Интерцептор для обработки ошибок аутентификации
authApi.interceptors.response.use(
    (response) => response,
    (error) => {
        // Только логируем ошибку, не делаем редирект
        if (error.response?.status === 401) {
            console.log('⚠️ 401 Unauthorized - token may be invalid');
        }
        return Promise.reject(error);
    }
);

// Типы данных
export type DepartmentType = 'LEO' | 'CIVIL' | 'FD' | 'EMS' | 'DISPATCH' | 'OTHER';

export const DEPARTMENT_PAGES: Record<DepartmentType, string> = {
    LEO: '/police',
    CIVIL: '/citizen',
    FD: '/fire',
    EMS: '/fire',
    DISPATCH: '/dispatch',
    OTHER: '/citizen',
};

export interface Department {
    id: string;
    name: string;
    type: DepartmentType;
    shortCode: string;
}

export interface User {
    id: string;
    username: string;
    roles: string[]; // Массив ролей: ['USER'], ['ADMIN'], ['MODERATOR'] и т.д.
    avatarUrl?: string;
    createdAt: string;
    lastSeen?: string;
    isDarkTheme?: boolean;
    statusViewMode?: string;
    tableActionsAlignment?: string;
    permissions?: string[];
    whitelistStatus?: string;
    developerMode?: boolean;
    department?: Department;
}

export interface AuthResponse {
    user: User;
    token: string;
}

export interface LoginData {
    username: string;
    password: string;
}

export interface RegisterData {
    username: string;
    password: string;
}

export interface UpdateProfileData {
    avatarUrl?: string;
    isDarkTheme?: boolean;
    statusViewMode?: string;
    tableActionsAlignment?: string;
}

// Типы методов авторизации
export type AuthMethodType = 'local' | 'discord' | 'ips';

export interface AuthMethod {
    type: AuthMethodType;
    name: string;
    enabled: boolean;
}

export interface AuthMethodsResponse {
    methods: AuthMethod[];
    urls: {
        discord?: string;
        ips?: string;
    };
}

// API функции
export const authService = {
    // Получение доступных методов авторизации
    async getAuthMethods(): Promise<AuthMethodsResponse> {
        const response = await authApi.get('methods');
        return response.data.data;
    },

    // Регистрация
    async register(data: RegisterData): Promise<AuthResponse> {
        const response = await authApi.post('register', data);
        return response.data.data;
    },

    // Вход
    async login(data: LoginData): Promise<AuthResponse> {
        const response = await authApi.post('login', data);
        return response.data.data;
    },

    // Получение текущего пользователя
    async me(): Promise<User> {
        const response = await authApi.get('me');
        return response.data.data;
    },

    // Выход
    async logout(): Promise<void> {
        await authApi.post('logout');
    },

    // Обновление профиля
    async updateProfile(data: UpdateProfileData): Promise<User> {
        const response = await authApi.put('profile', data);
        return response.data.data;
    },

    // Discord OAuth
    async getDiscordAuthUrl(): Promise<string> {
        const response = await authApi.get('discord');
        return response.data.data.authUrl;
    },

    // IPS OAuth
    async getIPSAuthUrl(): Promise<string> {
        const response = await authApi.get('ips');
        return response.data.data.authUrl;
    },
};

// Утилиты для работы с токеном и пользователем
export const authUtils = {
    // Сохранение данных аутентификации (и в localStorage, и в cookie)
    saveAuth(authData: AuthResponse) {
        localStorage.setItem('auth_token', authData.token);
        localStorage.setItem('user_data', JSON.stringify(authData.user));
        // Также устанавливаем cookie для middleware
        document.cookie = `auth-token=${authData.token}; path=/; max-age=604800; SameSite=Lax`;
    },

    // Получение токена (сначала localStorage, потом cookie)
    getToken(): string | null {
        const token = localStorage.getItem('auth_token');
        if (token) return token;
        
        // Fallback: читаем из cookie
        if (typeof document !== 'undefined') {
            const match = document.cookie.match(/auth-token=([^;]+)/);
            if (match) return match[1];
        }
        return null;
    },

    // Получение данных пользователя
    getUser(): User | null {
        const userData = localStorage.getItem('user_data');
        if (!userData || userData === 'undefined' || userData === 'null') return null;
        try {
            return JSON.parse(userData);
        } catch {
            localStorage.removeItem('user_data');
            return null;
        }
    },

    // Проверка аутентификации
    isAuthenticated(): boolean {
        return !!this.getToken();
    },

    // Очистка данных аутентификации
    clearAuth() {
        localStorage.removeItem('auth_token');
        localStorage.removeItem('user_data');
        // Удаляем cookie для middleware
        document.cookie = 'auth-token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT; SameSite=Lax';
    },

    // Проверка роли пользователя
    hasRole(requiredRole: 'USER' | 'MODERATOR' | 'ADMIN'): boolean {
        const user = this.getUser();
        if (!user || !Array.isArray(user.roles)) return false;

        const roleHierarchy = { USER: 0, MODERATOR: 1, ADMIN: 2 };
        const requiredLevel = roleHierarchy[requiredRole];

        return user.roles.some(role => {
            const userLevel = roleHierarchy[role as keyof typeof roleHierarchy];
            return userLevel >= requiredLevel;
        });
    },
};

// Хук для работы с аутентификацией
export interface UseAuthReturn {
    user: User | null;
    loading: boolean;
    isAuthenticated: boolean;
    login: (data: LoginData) => Promise<AuthResponse>;
    register: (data: RegisterData) => Promise<AuthResponse>;
    logout: () => Promise<void>;
    updateProfile: (data: UpdateProfileData) => Promise<User>;
    checkAuth: () => Promise<void>;
    hasRole: (role: 'USER' | 'MODERATOR' | 'ADMIN') => boolean;
}

export function useAuth(): UseAuthReturn {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState<boolean>(true);

    // Инициализация - проверяем данные в localStorage
    useEffect(() => {
        const initAuth = async () => {
            const token = authUtils.getToken();
            const storedUser = authUtils.getUser();

            if (token && storedUser) {
                setUser(storedUser);

                // Проверяем актуальность токена на сервере
                try {
                    const freshUser = await authService.me();
                    setUser(freshUser);
                    // Обновляем данные в localStorage
                    localStorage.setItem('user_data', JSON.stringify(freshUser));
                } catch (error) {
                    // Если токен невалидный, очищаем данные
                    if (axios.isAxiosError(error) && error.response?.status === 401) {
                        authUtils.clearAuth();
                        setUser(null);
                    }
                }
            }

            setLoading(false);
        };

        initAuth();
    }, []);

    const login = useCallback(async (data: LoginData): Promise<AuthResponse> => {
        setLoading(true);
        try {
            const authData = await authService.login(data);
            authUtils.saveAuth(authData);
            // Устанавливаем cookie для middleware
            if (typeof document !== 'undefined') {
                document.cookie = `auth-token=${authData.token}; path=/; max-age=604800; SameSite=Lax`;
            }
            setUser(authData.user);
            return authData;
        } finally {
            setLoading(false);
        }
    }, []);

    const register = useCallback(async (data: RegisterData): Promise<AuthResponse> => {
        setLoading(true);
        try {
            const authData = await authService.register(data);
            authUtils.saveAuth(authData);
            // Устанавливаем cookie для middleware
            if (typeof document !== 'undefined') {
                document.cookie = `auth-token=${authData.token}; path=/; max-age=604800; SameSite=Lax`;
            }
            setUser(authData.user);
            return authData;
        } finally {
            setLoading(false);
        }
    }, []);

    const logout = useCallback(async (): Promise<void> => {
        setLoading(true);
        try {
            await authService.logout();
        } catch (error) {
            console.error('Logout error:', error);
        } finally {
            authUtils.clearAuth();
            setUser(null);
            setLoading(false);
            // Принудительно обновляем для срабатывания middleware
            if (typeof window !== 'undefined') {
                window.location.href = '/login';
            }
        }
    }, []);

    const updateProfile = useCallback(async (data: UpdateProfileData): Promise<User> => {
        setLoading(true);
        try {
            const updatedUser = await authService.updateProfile(data);
            setUser(updatedUser);
            localStorage.setItem('user_data', JSON.stringify(updatedUser));
            return updatedUser;
        } finally {
            setLoading(false);
        }
    }, []);

    const checkAuth = useCallback(async (): Promise<void> => {
        if (!authUtils.isAuthenticated()) {
            setUser(null);
            return;
        }

        setLoading(true);
        try {
            const freshUser = await authService.me();
            setUser(freshUser);
            localStorage.setItem('user_data', JSON.stringify(freshUser));
        } catch (error) {
            if (axios.isAxiosError(error) && error.response?.status === 401) {
                authUtils.clearAuth();
                setUser(null);
            }
            throw error;
        } finally {
            setLoading(false);
        }
    }, []);

    const hasRole = useCallback((role: 'USER' | 'MODERATOR' | 'ADMIN'): boolean => {
        return authUtils.hasRole(role);
    }, []);

    return {
        user,
        loading,
        isAuthenticated: !!user,
        login,
        register,
        logout,
        updateProfile,
        checkAuth,
        hasRole,
    };
}

// Экспортируем хук по умолчанию для удобства
export default useAuth;

// Re-export usePermissions
export { usePermissions } from '@/hooks/usePermissions';
