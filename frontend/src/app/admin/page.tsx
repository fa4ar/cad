'use client';

import { useAuth } from '@/hooks/useAuth';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Shield, Users, Ban, ClipboardList, UserPlus } from 'lucide-react';
import Link from 'next/link';

/**
 * Главная страница админ-панели.
 */
export default function AdminPage() {
    const { user } = useAuth();
    
    // Функция проверки роли
    const hasRole = (role: string): boolean => {
        if (!user?.roles) return false;
        const userRoles = Array.isArray(user.roles) ? user.roles : [user.roles];
        return userRoles.includes(role);
    };

    const adminModules = [
        {
            title: "Заявки на доступ",
            description: "Рассмотрение заявок пользователей",
            icon: UserPlus,
            href: "/admin/applications",
            color: "text-green-500",
            bg: "bg-green-500/10"
        },
        {
            title: "Приоритеты",
            description: "Управление заявками и приоритетами",
            icon: ClipboardList,
            href: "/admin/priorities",
            color: "text-purple-500",
            bg: "bg-purple-500/10"
        },
        {
            title: "Пользователи",
            description: "Роли, департаменты, профили",
            icon: Users,
            href: "/admin/users",
            color: "text-blue-500",
            bg: "bg-blue-500/10"
        },
        {
            title: "Блокировки",
            description: "Управление черным списком",
            icon: Ban,
            href: "/admin/bans",
            color: "text-destructive",
            bg: "bg-destructive/10"
        },
        {
            title: "Система",
            description: "Конфигурация платформы",
            icon: Shield,
            href: "/admin/settings",
            color: "text-primary",
            bg: "bg-primary/10"
        }
    ];

    return (
        <div className="container mx-auto py-10 px-4">
            <div className="flex flex-col space-y-8">
                <div className="flex items-center justify-between">
                    <div>
                    <h1 className="text-4xl font-bold tracking-tight">Админ-панель</h1>
                        <div className="flex flex-col gap-2 mt-2">
                            <p className="text-muted-foreground">
                                Добро пожаловать, {user?.username}. Выберите модуль для управления.
                            </p>
                            <div className="text-sm">
                                <span className="text-muted-foreground">Ваши роли: </span>
                                <span className="font-mono bg-primary/10 text-primary px-2 py-1 rounded">
                                    {Array.isArray(user?.roles) ? user.roles.join(', ') : user?.roles || 'Нет ролей'}
                                </span>
                            </div>
                            <div className="text-sm">
                                <span className="text-muted-foreground">Доступ к админке: </span>
                                <span className={`font-bold ${hasRole('ADMIN') ? 'text-green-600' : 'text-red-600'}`}>
                                    {hasRole('ADMIN') ? '✅ Разрешен' : '❌ Запрещен'}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
                    {adminModules.map((module) => (
                        <Link key={module.href} href={module.href}>
                            <Card className="hover:shadow-md transition-shadow cursor-pointer h-full border-2 hover:border-primary/50 transition-colors">
                                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                                    <CardTitle className="text-sm font-medium">{module.title}</CardTitle>
                                    <div className={`p-2 rounded-md ${module.bg}`}>
                                        <module.icon className={`h-4 w-4 ${module.color}`} />
                                    </div>
                                </CardHeader>
                                <CardContent>
                                    <div className="text-2xl font-bold mt-1">Перейти</div>
                                    <p className="text-xs text-muted-foreground mt-1">{module.description}</p>
                                </CardContent>
                            </Card>
                        </Link>
                    ))}
                </div>

                <Card className="bg-muted/30 border-dashed">
                    <CardHeader>
                        <CardTitle>Быстрые действия</CardTitle>
                        <CardDescription>
                            Статистика и важные уведомления появятся здесь.
                        </CardDescription>
                    </CardHeader>
                    <CardContent className="h-[300px] flex items-center justify-center">
                        <div className="text-center text-muted-foreground italic">
                            
                        </div>
                    </CardContent>
                </Card>
            </div>
        </div>
    );
}
