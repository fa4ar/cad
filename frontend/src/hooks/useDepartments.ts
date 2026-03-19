import { useState, useCallback } from 'react';
import { departmentService } from '@/lib/api/management';
import { Department } from '@/hooks/getUseMangr';
import { toast } from 'sonner';

export function useDepartments() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const createDepartment = useCallback(async (data: Partial<Department>) => {
        setLoading(true);
        setError(null);
        try {
            const result = await departmentService.create(data);
            if (result.success) {
                toast.success('Департамент успешно создан');
                return result.department;
            } else {
                throw new Error(result.error || 'Ошибка при создании департамента');
            }
        } catch (err: any) {
            const message = err.response?.data?.error || err.message || 'Ошибка сервера';
            setError(message);
            toast.error(message);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const updateDepartment = useCallback(async (id: string, data: Partial<Department>) => {
        setLoading(true);
        setError(null);
        try {
            const result = await departmentService.update(id, data);
            if (result.success) {
                toast.success('Департамент успешно обновлен');
                return result.department;
            } else {
                throw new Error(result.error || 'Ошибка при обновлении департамента');
            }
        } catch (err: any) {
            const message = err.response?.data?.error || err.message || 'Ошибка сервера';
            setError(message);
            toast.error(message);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    const deleteDepartment = useCallback(async (id: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await departmentService.delete(id);
            if (result.success) {
                toast.success('Департамент успешно удален');
                return true;
            } else {
                throw new Error(result.error || 'Ошибка при удалении департамента');
            }
        } catch (err: any) {
            const message = err.response?.data?.error || err.message || 'Ошибка сервера';
            setError(message);
            toast.error(message);
            return false;
        } finally {
            setLoading(false);
        }
    }, []);

    const getDepartments = useCallback(async () => {
        setLoading(true);
        setError(null);
        try {
            const result = await departmentService.getAll();
            if (result.success) {
                return result.departments;
            } else {
                throw new Error(result.error || 'Ошибка при получении списка департаментов');
            }
        } catch (err: any) {
            const message = err.response?.data?.error || err.message || 'Ошибка сервера';
            setError(message);
            return [];
        } finally {
            setLoading(false);
        }
    }, []);

    const getDepartment = useCallback(async (id: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await departmentService.getById(id);
            if (result.success) {
                return result.department;
            } else {
                throw new Error(result.error || 'Ошибка при получении данных департамента');
            }
        } catch (err: any) {
            const message = err.response?.data?.error || err.message || 'Ошибка сервера';
            setError(message);
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    return {
        createDepartment,
        updateDepartment,
        deleteDepartment,
        getDepartments,
        getDepartment,
        loading,
        error
    };
}

