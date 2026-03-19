// 'use client';

// import { useAuth } from '@/hooks/useAuth';
// import { useRouter } from 'next/navigation';
// import { useEffect } from 'react';

// interface ProtectedRouteProps {
//   children: React.ReactNode;
//   requiredRole?: 'USER' | 'ADMIN' | 'MODERATOR';
//   redirectTo?: string;
// }

// export function ProtectedRoute({
//   children,
//   requiredRole = 'USER',
//   redirectTo = '/login'
// }: ProtectedRouteProps) {
//   const { user, loading } = useAuth();
//   const router = useRouter();

//   useEffect(() => {
//     if (!loading) {
//       if (!user) {
//         // Пользователь не аутентифицирован
//         router.push(redirectTo);
//         return;
//       }

//       // Проверяем роль пользователя
//       const roleHierarchy = { USER: 0, MODERATOR: 1, ADMIN: 2 };
//       const requiredLevel = roleHierarchy[requiredRole];
      
//       const hasRequiredRole = Array.isArray(user.roles) 
//         ? user.roles.some(role => (roleHierarchy[role as keyof typeof roleHierarchy] || 0) >= requiredLevel)
//         : (roleHierarchy[user.roles as keyof typeof roleHierarchy] || 0) >= requiredLevel;

//       if (!hasRequiredRole) {
//         // Недостаточно прав
//         router.push('/unauthorized');
//         return;
//       }
//     }
//   }, [user, loading, router, requiredRole, redirectTo]);

//   // Показываем загрузку пока проверяем аутентификацию
//   if (loading) {
//     return (
//       <div className="flex items-center justify-center min-h-screen">
//         <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
//       </div>
//     );
//   }

//   // Если пользователь не аутентифицирован или недостаточно прав, не показываем контент
//   if (!user) {
//     return null;
//   }

//   const roleHierarchy = { USER: 0, MODERATOR: 1, ADMIN: 2 };
//   const requiredLevel = roleHierarchy[requiredRole];
  
//   const hasRequiredRole = Array.isArray(user.roles) 
//     ? user.roles.some(role => (roleHierarchy[role as keyof typeof roleHierarchy] || 0) >= requiredLevel)
//     : (roleHierarchy[user.roles as keyof typeof roleHierarchy] || 0) >= requiredLevel;

//   if (!hasRequiredRole) {
//     return null;
//   }

//   return <>{children}</>;
// }
