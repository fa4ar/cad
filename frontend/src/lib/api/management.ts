import api from './axios';
import { User, Character, Department } from '@/hooks/getUseMangr';

// ========== USER MANAGEMENT ==========

export const userManagementService = {
    assignRoles: async (userId: string, roles: string[]) => {
        const response = await api.put(`/admin/users/${userId}/roles`, { roles });
        return response.data;
    },

    assignDepartment: async (userId: string, departmentId: string | null) => {
        const response = await api.put(`/admin/users/${userId}/department`, { departmentId });
        return response.data;
    },

    issueWarning: async (userId: string, reason: string) => {
        const response = await api.post(`/admin/users/${userId}/warning`, { reason });
        return response.data;
    },

    banUser: async (userId: string, reason: string) => {
        const response = await api.post(`/admin/users/${userId}/ban`, { reason });
        return response.data;
    },

    unbanUser: async (userId: string) => {
        const response = await api.post(`/admin/users/${userId}/unban`, {});
        return response.data;
    },

    getAllUsers: async () => {
        const response = await api.get('/admin/users');
        return response.data;
    },

    getUserById: async (id: string) => {
        const response = await api.get(`/admin/users/${id}`);
        return response.data;
    }
};

// ========== CHARACTER MANAGEMENT ==========

export const characterService = {
    create: async (data: Partial<Character>) => {
        const response = await api.post('/character/characters', data);
        return response.data;
    },

    update: async (id: string, data: Partial<Character>) => {
        const response = await api.put(`/character/characters/${id}`, data);
        return response.data;
    },

    delete: async (id: string) => {
        const response = await api.delete(`/character/characters/${id}`);
        return response.data;
    },

    getAll: async () => {
        const response = await api.get('/character/characters');
        return response.data;
    },

    getById: async (id: string) => {
        const response = await api.get(`/character/characters/${id}`);
        return response.data;
    }
};

// ========== DEPARTMENT MANAGEMENT ==========

export const departmentService = {
    create: async (data: Partial<Department>) => {
        const response = await api.post('/departments', data);
        return response.data;
    },

    update: async (id: string, data: Partial<Department>) => {
        const response = await api.put(`/departments/${id}`, data);
        return response.data;
    },

    delete: async (id: string) => {
        const response = await api.delete(`/departments/${id}`);
        return response.data;
    },

    getAll: async () => {
        const response = await api.get('/departments');
        return response.data;
    },

    getById: async (id: string) => {
        const response = await api.get(`/departments/${id}`);
        return response.data;
    }
};
