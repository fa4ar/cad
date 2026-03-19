import { useState, useCallback } from 'react';
import { userManagementService } from '@/lib/api/management';
import { User } from '@/hooks/getUseMangr';
import { toast } from 'sonner';

export function useUserManagement() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const assignRoles = useCallback(async (userId: string, roles: string[]) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.assignRoles(userId, roles);
            if (result.success) {
                toast.success('Роли успешно обновлены');
                return result.user;
            } else {
                throw new Error(result.error || 'Ошибка при обновлении ролей');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const assignDepartment = useCallback(async (userId: string, departmentId: string | null) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.assignDepartment(userId, departmentId);
            if (result.success) {
                toast.success('Департамент успешно назначен');
                return result.user;
            } else {
                throw new Error(result.error || 'Ошибка при назначении департамента');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const issueWarning = useCallback(async (userId: string, reason: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.issueWarning(userId, reason);
            if (result.success) {
                toast.success('Предупреждение успешно выдано');
                return result.warning;
            } else {
                throw new Error(result.error || 'Ошибка при выдаче предупреждения');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const banUser = useCallback(async (userId: string, reason: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.banUser(userId, reason);
            if (result.success) {
                toast.success('Пользователь заблокирован');
                return result.user;
            } else {
                throw new Error(result.error || 'Ошибка при блокировке');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const unbanUser = useCallback(async (userId: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.unbanUser(userId);
            if (result.success) {
                toast.success('Пользователь разблокирован');
                return result.user;
            } else {
                throw new Error(result.error || 'Ошибка при разблокировке');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const getUsers = useCallback(async () => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.getAllUsers();
            if (result.success) {
                return result.data.users;
            } else {
                throw new Error(result.error || 'Ошибка при получении списка пользователей');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            toast.error(finalMessage);
            return [];
        } finally {
            setLoading(false);
        }
    }, []);

    const getUser = useCallback(async (id: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await userManagementService.getUserById(id);
            if (result.success) {
                return result.data.user;
            } else {
                throw new Error(result.error || 'Ошибка при получении данных пользователя');
            }
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Ошибка сервера';
            const axiosError = err as any;
            const finalMessage = axiosError.response?.data?.error || message;
            setError(finalMessage);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    return {
        assignRoles,
        assignDepartment,
        issueWarning,
        banUser,
        unbanUser,
        getUsers,
        getUser,
        loading,
        error
    };
}
