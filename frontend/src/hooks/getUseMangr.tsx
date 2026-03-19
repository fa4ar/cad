import { useState, useCallback, useEffect, useMemo } from 'react';
import axios from 'axios';
import api from '@/lib/api/axios';

// Типы данных на основе Prisma схемы
export interface User {
    id: string;
    username: string;
    email?: string;
    steamId?: string;
    discordId?: string;
    license?: string;
    avatar?: string;
    avatarUrl?: string;
    dateOfBirth?: Date | string;
    roles: string[];
    permissions: string[];
    isBanned: boolean;
    banReason?: string;
    isVerified: boolean;
    isWhitelisted: boolean;
    lastLogin?: Date | string;
    lastSeen: Date | string;
    settings: any;
    theme: string;
    language: string;
    notifications: any;

    // Департамент из схемы Prisma
    department?: Department | null;
    departmentId?: string;
    
    // Для детективных отделов
    isDetective?: boolean;
    divisionId?: string;

    // Персонажи пользователя
    characters?: Character[];

    createdAt: Date | string;
    updatedAt: Date | string;
}

export interface Department {
    id: string;
    name: string;
    shortCode: string;
    type: string;
    description?: string;
    color?: string;
    icon?: string;
    isActive: boolean;
    maxMembers?: number;
    minroles: string;
    permissions: string[];
    settings?: any;
    discordRoleId?: string;
    
    // Специальные типы
    isDetective?: boolean;

    // Родительский департамент
    parent?: Department | null;
    parentId?: string;

    // Дочерние департаменты
    children?: Department[];

    // Руководитель
    leader?: User | null;
    leaderId?: string;

    createdAt: Date | string;
    updatedAt: Date | string;
}

export interface Character {
    id: string;
    userId: string;

    // Основная информация
    firstName: string;
    lastName: string;
    dateOfBirth: Date | string;
    gender: string;
    nationality?: string;
    ethnicity?: string;

    // Профессиональная информация
    department?: Department | null;
    departmentId?: string;

    // Дополнительные поля
    ssn?: string;
    licenseNumber?: string;
    isDead: boolean;
    isWanted: boolean;

    createdAt: Date | string;
    updatedAt: Date | string;
}

export interface UseUserReturn {
    user: User | null;
    loading: boolean;
    error: Error | null;
    refreshUser: () => Promise<void>;
    hasRole: (role: string) => boolean;
    hasPermission: (permission: string) => boolean;
    department: Department | null;
    characters: Character[];
    activeCharacter: Character | null;
    avatarUrl: string | null;
    isAuthenticated: boolean;
    userRoles: string[];
    userPermissions: string[];
}

// Конфигурация
const API_CONFIG = {
    BASE_URL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030',
    AVATAR_STORAGE_URL: process.env.NEXT_PUBLIC_AVATAR_STORAGE_URL || 'http://localhost:3030/uploads/avatars',
    DEFAULT_AVATAR: '/default-avatar.png',
    STORAGE_KEYS: {
        TOKEN: 'auth_token',
        USER_DATA: 'user_data',
    },
    ROLE_HIERARCHY: {
        USER: 0,
        MODERATOR: 1,
        ADMIN: 2,
    } as const,
} as const;

// Утилита для безопасного доступа к localStorage
const storage = {
    isClient(): boolean {
        return typeof window !== 'undefined';
    },

    getItem(key: string): string | null {
        if (!this.isClient()) {
            return null;
        }
        try {
            return localStorage.getItem(key);
        } catch (error) {
            console.error('Error accessing localStorage:', error);
            return null;
        }
    },

    setItem(key: string, value: string): void {
        if (!this.isClient()) {
            return;
        }
        try {
            localStorage.setItem(key, value);
        } catch (error) {
            console.error('Error setting localStorage:', error);
        }
    },

    removeItem(key: string): void {
        if (!this.isClient()) {
            return;
        }
        try {
            localStorage.removeItem(key);
        } catch (error) {
            console.error('Error removing from localStorage:', error);
        }
    },

    clear(): void {
        if (!this.isClient()) {
            return;
        }
        try {
            localStorage.clear();
        } catch (error) {
            console.error('Error clearing localStorage:', error);
        }
    }
};

type RoleType = keyof typeof API_CONFIG.ROLE_HIERARCHY;

// Утилиты для работы с аутентификацией и пользователем
const authUtils = {
    getToken(): string | null {
        return storage.getItem(API_CONFIG.STORAGE_KEYS.TOKEN);
    },

    getUser(): User | null {
        const userData = storage.getItem(API_CONFIG.STORAGE_KEYS.USER_DATA);
        if (!userData || userData === 'undefined' || userData === 'null') return null;
        try {
            return JSON.parse(userData);
        } catch (error) {
            console.error('Error parsing user data:', error);
            storage.removeItem(API_CONFIG.STORAGE_KEYS.USER_DATA);
            return null;
        }
    },

    setUser(user: User): void {
        storage.setItem(API_CONFIG.STORAGE_KEYS.USER_DATA, JSON.stringify(user));
    },

    isAuthenticated(): boolean {
        return !!this.getToken();
    },

    clearAuth(): void {
        storage.removeItem(API_CONFIG.STORAGE_KEYS.TOKEN);
        storage.removeItem(API_CONFIG.STORAGE_KEYS.USER_DATA);
    },

    getAvatarUrl(user?: User | null): string | null {
        const targetUser = user || this.getUser();

        if (!targetUser?.avatar) {
            return null;
        }

        // Если avatar уже содержит полный URL
        if (targetUser.avatar.startsWith('http')) {
            return targetUser.avatar;
        }

        // Если avatar - это путь к файлу
        return `${API_CONFIG.AVATAR_STORAGE_URL}/${targetUser.avatar}`;
    },

    // Получение URL аватара с fallback
    getAvatarUrlWithFallback(user?: User | null): string {
        const avatarUrl = this.getAvatarUrl(user);
        return avatarUrl || API_CONFIG.DEFAULT_AVATAR;
    },

    // Проверка иерархии ролей
    hasRoleHierarchy(user: User | null, requiredRole: RoleType | string): boolean {
        if (!user) return false;

        const requiredLevel = API_CONFIG.ROLE_HIERARCHY[requiredRole as RoleType] ?? 0;
        
        // Проверяем каждую роль пользователя
        const userRoles = Array.isArray(user.roles) ? user.roles : [user.roles];
        const userLevel = Math.max(...userRoles.map(role => API_CONFIG.ROLE_HIERARCHY[role as RoleType] ?? 0));

        return userLevel >= requiredLevel;
    },

    // Проверка конкретной роли в массиве roles
    hasSpecificRole(user: User | null, roleName: string): boolean {
        if (!user || !user.roles) return false;
        return user.roles.includes(roleName);
    },

    // Проверка разрешения
    hasPermission(user: User | null, permission: string): boolean {
        if (!user) return false;

        const roles = user.roles || [];
        const userPermissions = user.permissions || [];

        // Проверяем в массиве permissions пользователя
        if (userPermissions.includes(permission)) {
            return true;
        }

        // Проверяем в разрешениях департамента
        if (user.department?.permissions?.includes(permission)) {
            return true;
        }

        return false;
    },

    // Получение информации о департаменте
    getDepartment(user: User | null): Department | null {
        return user?.department || null;
    },

    // Получение персонажей пользователя
    getCharacters(user: User | null): Character[] {
        return user?.characters || [];
    },

    // Получение активного персонажа (первый не мертвый)
    getActiveCharacter(user: User | null): Character | null {
        const characters = this.getCharacters(user);
        return characters.find(char => !char.isDead) || null;
    },

    // Получение всех ролей пользователя
    getUserRoles(user: User | null): string[] {
        if (!user) return [];
        return user.roles || [];
    },

    // Получение всех разрешений пользователя
    getUserPermissions(user: User | null): string[] {
        if (!user) return [];

        const userPermissions = user.permissions || [];
        const departmentPermissions = user.department?.permissions || [];

        return [...new Set([...userPermissions, ...departmentPermissions])];
    }
};

// API функции
const apiService = {
    async getUser(): Promise<User> {
        const token = authUtils.getToken();

        if (!token) {
            throw new Error('No authentication token found');
        }

        const response = await api.get(`/auth/me`, {
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json',
            },
            params: {
                include: 'department,characters,characters.department'
            },
            timeout: 10000, // 10 секунд таймаут
        });

        return response.data.data;
    },

    async refreshUserData(): Promise<User> {
        try {
            const user = await this.getUser();
            authUtils.setUser(user);
            return user;
        } catch (error) {
            if (axios.isAxiosError(error) && error.response?.status === 401) {
                authUtils.clearAuth();
            }
            throw error;
        }
    }
};

// Основной хук useUser
export function useUser(): UseUserReturn {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<Error | null>(null);

    // Функция загрузки пользователя
    const fetchUser = useCallback(async (): Promise<void> => {
        if (!authUtils.isAuthenticated()) {
            setUser(null);
            setLoading(false);
            return;
        }

        setLoading(true);
        setError(null);

        try {
            const freshUser = await apiService.refreshUserData();
            setUser(freshUser);
        } catch (err) {
            setError(err as Error);

            // Очищаем данные при 401 ошибке
            if (axios.isAxiosError(err) && err.response?.status === 401) {
                setUser(null);
            }
        } finally {
            setLoading(false);
        }
    }, []);

    // Инициализация - проверяем данные в localStorage
    useEffect(() => {
        const initUser = async () => {
            // На сервере сразу выходим
            if (typeof window === 'undefined') {
                setLoading(false);
                return;
            }

            const storedUser = authUtils.getUser();

            if (storedUser) {
                setUser(storedUser);

                // Обновляем данные с сервера в фоновом режиме
                if (authUtils.isAuthenticated()) {
                    try {
                        const freshUser = await apiService.refreshUserData();
                        setUser(freshUser);
                    } catch (error) {
                        if (axios.isAxiosError(error) && error.response?.status === 401) {
                            setUser(null);
                        }
                    }
                }
            }

            setLoading(false);
        };

        initUser();
    }, []);

    // Мемоизированные вычисляемые значения
    const department = useMemo(() => authUtils.getDepartment(user), [user]);
    const characters = useMemo(() => authUtils.getCharacters(user), [user]);
    const activeCharacter = useMemo(() => authUtils.getActiveCharacter(user), [user]);
    const avatarUrl = useMemo(() => authUtils.getAvatarUrl(user), [user]);
    const isAuthenticated = useMemo(() => authUtils.isAuthenticated() && !!user, [user]);
    const userRoles = useMemo(() => authUtils.getUserRoles(user), [user]);
    const userPermissions = useMemo(() => authUtils.getUserPermissions(user), [user]);

    // Мемоизированные функции проверки
    const hasRole = useCallback((role: string): boolean => {
        return authUtils.hasRoleHierarchy(user, role) || authUtils.hasSpecificRole(user, role);
    }, [user]);

    const hasPermission = useCallback((permission: string): boolean => {
        return authUtils.hasPermission(user, permission);
    }, [user]);

    return {
        user,
        loading,
        error,
        refreshUser: fetchUser,
        hasRole,
        hasPermission,
        department,
        characters,
        activeCharacter,
        avatarUrl,
        isAuthenticated,
        userRoles,
        userPermissions,
    };
}

// Дополнительные утилитные хуки

// Хук для проверки разрешений
export function usePermissions() {
    const { user } = useUser();

    const hasPermission = useCallback((permission: string): boolean => {
        return authUtils.hasPermission(user, permission);
    }, [user]);

    const hasAnyPermission = useCallback((permissions: string[]): boolean => {
        return permissions.some(permission => authUtils.hasPermission(user, permission));
    }, [user]);

    const hasAllPermissions = useCallback((permissions: string[]): boolean => {
        return permissions.every(permission => authUtils.hasPermission(user, permission));
    }, [user]);

    return {
        hasPermission,
        hasAnyPermission,
        hasAllPermissions,
    };
}

// Хук для работы с департаментом
export function useDepartment() {
    const { user, department } = useUser();

    const isInDepartment = !!department;
    const isDepartmentLeader = department?.leaderId === user?.id;

    const hasDepartmentPermission = useCallback((permission: string): boolean => {
        return department?.permissions?.includes(permission) || false;
    }, [department]);

    return {
        department,
        isInDepartment,
        isDepartmentLeader,
        hasDepartmentPermission,
        departmentPermissions: department?.permissions || [],
        departmentType: department?.type,
        departmentColor: department?.color,
        departmentIcon: department?.icon,
    };
}

// Хук для работы с аватаром
export function useAvatar() {
    const { user } = useUser();

    const avatarUrl = useMemo(() => authUtils.getAvatarUrl(user), [user]);
    const avatarUrlWithFallback = useMemo(() => authUtils.getAvatarUrlWithFallback(user), [user]);

    const updateAvatar = useCallback(async (file: File): Promise<void> => {
        // Здесь должна быть реализация загрузки аватара на сервер
        throw new Error('updateAvatar method not implemented');
    }, []);

    return {
        avatarUrl,
        avatarUrlWithFallback,
        updateAvatar,
        hasAvatar: !!avatarUrl,
    };
}

// Хук для проверки ролей
export function useRoles() {
    const { user, userRoles } = useUser();

    const hasRole = useCallback((role: string): boolean => {
        return authUtils.hasRoleHierarchy(user, role) || authUtils.hasSpecificRole(user, role);
    }, [user]);

    const hasAnyRole = useCallback((roles: string[]): boolean => {
        return roles.some(role => hasRole(role));
    }, [hasRole]);

    const hasAllRoles = useCallback((roles: string[]): boolean => {
        return roles.every(role => hasRole(role));
    }, [hasRole]);

    return {
        hasRole,
        hasAnyRole,
        hasAllRoles,
        userRoles,
        isAdmin: hasRole('ADMIN'),
        isModerator: hasRole('MODERATOR'),
        isUser: hasRole('USER'),
    };
}

// Экспорт утилит для использования вне хуков
export { authUtils, apiService, storage };

export default useUser;