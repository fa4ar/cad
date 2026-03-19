import { useCallback, useMemo } from 'react';
import { useAuth } from './useAuth';

export type Permission = 
  | '*' // Полный доступ
  | 'admin:access' // Доступ к админке
  | 'admin:users' // Управление пользователями
  | 'admin:departments' // Управление департаментами
  | 'admin:settings' // Настройки системы
  | 'user:view' // Просмотр пользователей
  | 'user:edit' // Редактирование пользователей
  | 'user:delete' // Удаление пользователей
  | string; // Любые другие permissions

export type Role = 'USER' | 'MODERATOR' | 'ADMIN';

const roleHierarchy: Record<Role, number> = {
  USER: 0,
  MODERATOR: 1,
  ADMIN: 2
};

export function usePermissions() {
  const { user } = useAuth();

  const roles = useMemo(() => {
    return user?.roles || [];
  }, [user]);

  const permissions = useMemo(() => {
    return user?.permissions || [];
  }, [user]);

  // Проверяет есть ли полный доступ
  const hasFullAccess = useMemo(() => {
    return permissions.includes('*');
  }, [permissions]);

  // Проверяет наличие роли
  const hasRole = useCallback((role: Role): boolean => {
    if (hasFullAccess) return true;
    const requiredLevel = roleHierarchy[role];
    return roles.some((r: string) => {
      const userLevel = roleHierarchy[r as Role] ?? -1;
      return userLevel >= requiredLevel;
    });
  }, [roles, hasFullAccess]);

  // Проверяет является ли пользователь админом
  const isAdmin = useCallback((): boolean => {
    return hasRole('ADMIN');
  }, [hasRole]);

  // Проверяет является ли пользователь модератором или выше
  const isModerator = useCallback((): boolean => {
    return hasRole('MODERATOR');
  }, [hasRole]);

  // Проверяет наличие конкретного разрешения
  const hasPermission = useCallback((permission: Permission): boolean => {
    if (hasFullAccess) return true;
    return permissions.includes(permission);
  }, [permissions, hasFullAccess]);

  // Проверяет наличие всех перечисленных разрешений
  const hasAllPermissions = useCallback((...perms: Permission[]): boolean => {
    if (hasFullAccess) return true;
    return perms.every(perm => permissions.includes(perm));
  }, [permissions, hasFullAccess]);

  // Проверяет наличие хотя бы одного разрешения
  const hasAnyPermission = useCallback((...perms: Permission[]): boolean => {
    if (hasFullAccess) return true;
    return perms.some(perm => permissions.includes(perm));
  }, [permissions, hasFullAccess]);

  // Проверяет доступ к админке
  const canAccessAdmin = useCallback((): boolean => {
    return hasFullAccess || isAdmin() || hasPermission('admin:access');
  }, [hasFullAccess, isAdmin, hasPermission]);

  return {
    roles,
    permissions,
    hasFullAccess,
    hasRole,
    isAdmin,
    isModerator,
    hasPermission,
    hasAllPermissions,
    hasAnyPermission,
    canAccessAdmin
  };
}
