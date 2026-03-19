'use client';

import { usePathname, useRouter } from 'next/navigation';
import { useAuth } from '@/hooks/useAuth';
import { useEffect } from 'react';
import { canAccessPath, DepartmentType } from '@/config/permissions';

export function PermissionGuard({ children }: { children: React.ReactNode }) {
    const pathname = usePathname();
    const router = useRouter();
    const { user, loading } = useAuth();

    useEffect(() => {
        if (loading) return;

        console.log('🛡️ Guard check:', {
            path: pathname,
            user: user ? 'exists' : 'null',
            roles: user?.roles,
            department: user?.department,
            departmentType: user?.department?.type
        });

        // Публичные пути
        if (pathname === '/login' || pathname === '/signup' || pathname === '/unauthorized' || pathname === '/') {
            console.log('✅ Public path');
            
            // Если пользователь авторизован и имеет департамент - редиректим на соответствующую страницу
            if (user && pathname === '/') {
                const deptType = user.department?.type;
                if (deptType === 'LEO') {
                    console.log('🔄 Redirecting LEO user to /police');
                    router.push('/police');
                    return;
                } else if (deptType === 'FD') {
                    console.log('🔄 Redirecting FD user to /fire');
                    router.push('/fire');
                    return;
                } else if (deptType === 'EMS') {
                    console.log('🔄 Redirecting EMS user to /fire');
                    router.push('/fire');
                    return;
                } else if (deptType === 'CIVIL') {
                    console.log('🔄 Redirecting CIVIL user to /civilian');
                    router.push('/civilian');
                    return;
                } else if (deptType === 'DISPATCH') {
                    console.log('🔄 Redirecting DISPATCH user to /dispatch');
                    router.push('/dispatch');
                    return;
                }
            }
            
            return;
        }

        // Нет пользователя
        if (!user) {
            console.log('🚫 No user -> login');
            router.push('/login');
            return;
        }

        // Есть пользователь - проверяем доступ через canAccessPath
        const roles = Array.isArray(user.roles) ? user.roles : [user.roles];
        const normalizedRoles = roles.map(r => String(r).toUpperCase());
        
        // Получаем тип департамента
        const departmentType = user.department?.type as DepartmentType | undefined;

        console.log('👥 User roles:', normalizedRoles, 'Department type:', departmentType);

        // Используем canAccessPath для проверки доступа
        const hasAccess = canAccessPath(normalizedRoles, pathname, departmentType);
        
        console.log('🔐 Access check result:', hasAccess);
        
        if (!hasAccess) {
            console.log('🚫 Access denied -> unauthorized');
            router.push('/unauthorized');
            return;
        }

        console.log('✅ Access granted');
        
    }, [pathname, user, loading, router]);

    // Показываем лоадер
    if (loading) {
        return (
            <div className="flex items-center justify-center min-h-screen">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
            </div>
        );
    }

    return <>{children}</>;
}