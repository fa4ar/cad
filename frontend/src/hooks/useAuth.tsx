'use client';

import { useState, useEffect, useContext, createContext, ReactNode } from 'react';
import { authService, authUtils, User, LoginData, RegisterData, AuthResponse } from '@/lib/auth';
import { toast } from 'sonner';
import { useRouter } from 'next/navigation';
import api from '@/lib/api/axios';

interface AuthContextType {
  user: User | null;
  loading: boolean;
  login: (data: LoginData) => Promise<boolean>;
  register: (data: RegisterData) => Promise<boolean>;
  logout: () => Promise<void>;
  refreshUser: () => Promise<void>;
  isAuthenticated: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const safeParseUser = (raw: string | null): User | null => {
    if (!raw || raw === 'undefined' || raw === 'null') return null;
    try {
      return JSON.parse(raw);
    } catch {
      return null;
    }
  };

  useEffect(() => {
    const initAuth = async () => {
      console.log('🔄 Auth init start');
      
      try {
        const token = authUtils.getToken();
        console.log('🔑 Token exists:', !!token);
        
        if (token) {
          // Сначала из localStorage для скорости
          const storedUser = localStorage.getItem('user_data');
          const parsedUser = safeParseUser(storedUser);
          if (parsedUser) {
            console.log('?? User from localStorage:', parsedUser);
            setUser(parsedUser);
          } else if (storedUser) {
            localStorage.removeItem('user_data');
          }
// Затем обновляем с сервера
          try {
            console.log('🌐 Fetching user from API...');
            const userData = await authService.me();
            console.log('✅ User from API:', userData);
            setUser(userData);
            localStorage.setItem('user_data', JSON.stringify(userData));
          } catch (apiError) {
            console.error('⚠️ API error (not critical):', apiError);
            // Если API падает, оставляем пользователя из localStorage
            // НЕ очищаем auth!
          }
        }
      } catch (error) {
        console.error('🔥 Auth init error (not clearing):', error);
        // НЕ очищаем auth при ошибке!
      } finally {
        console.log('🏁 Auth init complete');
        setLoading(false);
      }
    };

    initAuth();
  }, []);

const checkApplicationAndRedirect = async () => {
        try {
            const settingsRes = await api.get('/system-settings/enableApplicationSystem');
            const isEnabled = settingsRes.data.value === 'true';

            if (isEnabled) {
                const appRes = await api.get('/applications/my');
                const app = appRes.data.application;

                if (!app) {
                    router.push('/application');
                    return true;
                }

                if (app.status === 'pending') {
                    router.push('/application');
                    return true;
                }

                if (app.status === 'rejected') {
                    router.push('/application');
                    return true;
                }
            }
        } catch (error) {
            console.error('Error checking application system:', error);
        }
        return false;
    };

    const login = async (data: LoginData): Promise<boolean> => {
        try {
            setLoading(true);
            console.log('🔐 Login attempt:', data.username);
            
            const authData: AuthResponse = await authService.login(data);
            console.log('✅ Login success:', authData.user);
            
            authUtils.saveAuth(authData);
            setUser(authData.user);
            
            toast.success('Успешный вход в систему');
            
            const needsApp = await checkApplicationAndRedirect();
            if (!needsApp) {
                router.push('/');
            }
            
            return true;
        } catch (error: any) {
            const errorMessage = error.response?.data?.error || 'Ошибка входа';
            toast.error(errorMessage);
            console.error('❌ Login error:', error);
            return false;
        } finally {
            setLoading(false);
        }
    };

    const register = async (data: RegisterData): Promise<boolean> => {
        try {
            setLoading(true);
            const authData: AuthResponse = await authService.register(data);
            
            authUtils.saveAuth(authData);
            setUser(authData.user);
            
            toast.success('Регистрация успешна');
            
            const needsApp = await checkApplicationAndRedirect();
            if (!needsApp) {
                router.push('/');
            }
            
            return true;
        } catch (error: any) {
            const errorMessage = error.response?.data?.error || 'Ошибка регистрации';
            toast.error(errorMessage);
            console.error('Registration error:', error);
            return false;
        } finally {
            setLoading(false);
        }
    };

  const logout = async (): Promise<void> => {
    try {
      await authService.logout();
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      authUtils.clearAuth();
      setUser(null);
      toast.success('Вы вышли из системы');
      router.push('/login');
    }
  };

  const refreshUser = async (): Promise<void> => {
    try {
      if (authUtils.isAuthenticated()) {
        const userData = await authService.me();
        setUser(userData);
        localStorage.setItem('user_data', JSON.stringify(userData));
      }
    } catch (error) {
      console.error('Refresh error:', error);
      await logout();
    }
  };

  const value: AuthContextType = {
    user,
    loading,
    login,
    register,
    logout,
    refreshUser,
    isAuthenticated: !!user,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): AuthContextType {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
