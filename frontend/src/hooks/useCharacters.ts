import { useState, useCallback } from 'react';
import { characterService } from '@/lib/api/management';
import { Character } from '@/hooks/getUseMangr';
import { toast } from 'sonner';

export function useCharacters() {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const createCharacter = useCallback(async (data: Partial<Character>) => {
        setLoading(true);
        setError(null);
        try {
            const result = await characterService.create(data);
            if (result.success) {
                toast.success('Персонаж успешно создан');
                return result.character;
            } else {
                throw new Error(result.error || 'Ошибка при создании персонажа');
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

    const updateCharacter = useCallback(async (id: string, data: Partial<Character>) => {
        setLoading(true);
        setError(null);
        try {
            const result = await characterService.update(id, data);
            if (result.success) {
                toast.success('Персонаж успешно обновлен');
                return result.character;
            } else {
                throw new Error(result.error || 'Ошибка при обновлении персонажа');
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

    const deleteCharacter = useCallback(async (id: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await characterService.delete(id);
            if (result.success) {
                toast.success('Персонаж успешно удален');
                return true;
            } else {
                throw new Error(result.error || 'Ошибка при удалении персонажа');
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

    const getCharacter = useCallback(async (id: string) => {
        setLoading(true);
        setError(null);
        try {
            const result = await characterService.getById(id);
            if (result.success) {
                return result.character;
            } else {
                throw new Error(result.error || 'Ошибка при получении персонажа');
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
        createCharacter,
        updateCharacter,
        deleteCharacter,
        getCharacter,
        loading,
        error
    };
}
