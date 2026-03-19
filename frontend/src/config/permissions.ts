/**
 * Конфигурация прав доступа (RBAC) для фронтенда.
 * Определяет доступность путей (URL) в зависимости от роли пользователя.
 */

export type UserRole = 'USER' | 'MODERATOR' | 'ADMIN';

export type DepartmentType = 'LEO' | 'CIVIL' | 'FD' | 'EMS' | 'DISPATCH' | 'OTHER';

export interface RoutePermission {
    path: string;
    allowedRoles: UserRole[];
    allowedDepartments?: DepartmentType[];
    exact?: boolean;
}

export const ROLE_HIERARCHY: Record<UserRole, number> = {
    USER: 0,
    MODERATOR: 1,
    ADMIN: 2,
};

/**
 * Список защищенных маршрутов и ролей, имеющих к ним доступ.
 */
export const ROUTE_PERMISSIONS: RoutePermission[] = [
    // --- Публичные маршруты (доступны всем) ---
    { path: '/', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/login', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/signup', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/unauthorized', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },

    // --- Общие маршруты (Доступны всем авторизованным) ---
    { path: '/dashboard', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/profile', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/characters', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/pages/citizen', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/citizen', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['CIVIL'] },

    // --- Маршруты Персонажей ---
    { path: '/characters/create', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },
    { path: '/characters/edit', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },

    // --- Маршруты Департаментов (для всех авторизованных) ---
    { path: '/departments', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'] },

    // --- Маршруты Полиции (LEO) ---
    { path: '/police', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['LEO'] },

    // --- Маршруты Гражданских (CIVIL) ---
    { path: '/civilian', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['CIVIL'] },

    // --- Маршруты Пожарных (FD) ---
    { path: '/fire', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['FD'] },

    // --- Маршруты Скорой помощи (EMS) ---
    { path: '/ems', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['EMS'] },

    // --- Маршруты Диспетчера (отдельная роль) ---
    { path: '/dispatch', allowedRoles: ['USER', 'MODERATOR', 'ADMIN'], allowedDepartments: ['DISPATCH'] },

    // --- Админские маршруты (ADMIN ONLY) ---
    { path: '/admin', allowedRoles: ['ADMIN'] },
    { path: '/admin/settings', allowedRoles: ['ADMIN'] },
    { path: '/admin/logs', allowedRoles: ['ADMIN'] },
    { path: '/admin/departments', allowedRoles: ['ADMIN'] },
    { path: '/admin/bans', allowedRoles: ['ADMIN'] },
    { path: '/admin/users', allowedRoles: ['ADMIN'] },

    // --- Модераторские маршруты (MODERATOR+) ---
    { path: '/moderator', allowedRoles: ['MODERATOR', 'ADMIN'] },
    { path: '/moderator/reports', allowedRoles: ['MODERATOR', 'ADMIN'] },
    { path: '/moderator/logs', allowedRoles: ['MODERATOR', 'ADMIN'] },
];


/**
 * Утилита для проверки доступа к пути
 */
export const canAccessPath = (role: string | string[], path: string, departmentType?: string): boolean => {
    // Если путь не определен, запрещаем доступ
    if (!path) return false;

    // Обрабатываем массив ролей или одну роль
    const userRoles = Array.isArray(role) ? role : [role];
    
    // Если у пользователя нет ролей, запрещаем доступ к защищенным маршрутам
    if (!userRoles.length || !userRoles[0]) {
        // ADMIN всегда имеет доступ
        const publicPaths = ['/login', '/signup', '/unauthorized', '/'];
        return publicPaths.includes(path) || publicPaths.some(p => path.startsWith(p + '/'));
    }
    
    // Преобразуем роли пользователя в верхний регистр для совместимости
    const normalizedUserRoles = userRoles.map(r => r.trim().toUpperCase() as UserRole);
    
    // ADMIN имеет доступ ко всему - проверяем сразу
    if (normalizedUserRoles.includes('ADMIN')) {
        console.log('✅ ADMIN has full access to everything');
        return true;
    }
    
    console.log('🛡️ canAccessPath check:', { 
        normalizedUserRoles, 
        path,
        departmentType,
        originalRoles: userRoles 
    });
    
    // Сначала проверяем точное совпадение
    let permission = ROUTE_PERMISSIONS.find(p => p.path === path);
    console.log('🔍 Exact match:', permission?.path);
    
    // Если нет точного совпадения, ищем по началу пути
    if (!permission) {
        permission = ROUTE_PERMISSIONS.find(p => 
            path.startsWith(p.path) && 
            (path === p.path || path.startsWith(p.path + '/'))
        );
        console.log('🔍 Prefix match:', permission?.path);
    }

    console.log('📋 Found permission:', { 
        permission, 
        path,
        permissionPath: permission?.path,
        allowedRoles: permission?.allowedRoles,
        allowedDepartments: permission?.allowedDepartments
    });

    // Если нет правила для этого пути, проверяем публичные пути
    if (!permission) {
        const publicPaths = ['/login', '/signup', '/unauthorized', '/'];
        const isPublic = publicPaths.some(p => 
            path === p || path.startsWith(p + '/')
        );
        console.log(`${isPublic ? '✅' : '🚫'} No permission rule - ${isPublic ? 'public path' : 'access denied'}`);
        return isPublic;
    }

    // Проверяем доступность по ролям
    const hasRoleAccess = normalizedUserRoles.some(userRole => {
        // ADMIN уже проверен выше

        // Проверяем, что роль валидна и не пустая
        if (!userRole || userRole.trim() === '' || !ROLE_HIERARCHY.hasOwnProperty(userRole)) {
            return false;
        }

        // Проверяем прямое вхождение роли в allowedRoles
        const hasDirectAccess = permission!.allowedRoles.includes(userRole as any);
        
        // Если есть прямое вхождение, доступ разрешен
        if (hasDirectAccess) {
            console.log(`✅ Direct access granted for role: ${userRole}`);
            return true;
        }

        // Если нет прямого вхождения, проверяем иерархию
        const userLevel = ROLE_HIERARCHY[userRole as UserRole] ?? 0;
        const hasHierarchyAccess = permission!.allowedRoles.some(allowedRole => {
            const requiredLevel = ROLE_HIERARCHY[allowedRole as UserRole] ?? 0;
            return userLevel >= requiredLevel;
        });

        console.log(`🔑 Hierarchy check for ${userRole}:`, {
            userLevel,
            allowedRoles: permission!.allowedRoles,
            hasHierarchyAccess
        });

        return hasHierarchyAccess;
    });

    // Если есть доступ по роли, проверяем департамент (если требуется)
    if (hasRoleAccess && permission.allowedDepartments && permission.allowedDepartments.length > 0) {
        console.log('✅ Has role access, checking department...');
        
        if (!departmentType) {
            console.log(`🚫 Department required but not provided`);
            return false;
        }
        
        const normalizedDeptType = String(departmentType).toUpperCase().trim();
        const allowedNormalized = permission.allowedDepartments.map(d => d.toUpperCase());
        
        const hasDeptAccess = allowedNormalized.includes(normalizedDeptType);
        
        console.log(`🏢 Department check: "${normalizedDeptType}" in [${allowedNormalized.join(', ')}] = ${hasDeptAccess}`);
        
        return hasDeptAccess;
    }

    console.log('🏁 Final access result:', { 
        path, 
        userRoles: normalizedUserRoles, 
        hasAccess: hasRoleAccess,
        allowedRoles: permission.allowedRoles 
    });
    
    return hasRoleAccess;
};
