'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { ChevronDown, LogOut, Settings, User, Siren, Shield, Car, Flame } from 'lucide-react';
import { useAuth } from '@/lib/auth';
import { useUser } from '../hooks/getUseMangr';
import  {UserDepartmentSelect} from '../components/Navbar'
import { useLanguage } from '@/hooks/useLanguage';
 
export function Header() {
    const router = useRouter();
    const { loading, logout } = useAuth();
    const { user } = useUser();
    const { language, setLanguage, t } = useLanguage();
    const [langLabel, setLangLabel] = useState('EN');

    useEffect(() => {
        setLangLabel(language === 'en' ? 'EN' : 'RU');
    }, [language]);

    const usDept = user?.department;

    const handleLogout = async () => {
        try {
            await logout();
            router.push('/login');
        } catch (error) {
            console.error('Logout error:', error);
        }
    };

    // Получаем первую букву никнейма для аватарки
    const getFirstLetter = (username: string): string => {
        return username?.charAt(0)?.toUpperCase() || 'U';
    };

    // Генератор цвета на основе никнейма
    const getAvatarColor = (username: string): string => {
        if (!username) return 'bg-primary';

        // Простая хеш-функция для генерации цвета
        let hash = 0;
        for (let i = 0; i < username.length; i++) {
            hash = username.charCodeAt(i) + ((hash << 5) - hash);
        }

        const colors = [
            'bg-red-500', 'bg-blue-500', 'bg-green-500', 'bg-yellow-500',
            'bg-purple-500', 'bg-pink-500', 'bg-indigo-500', 'bg-teal-500'
        ];

        return colors[Math.abs(hash) % colors.length];
    };

    if (loading) {
        return (
            <header className="sticky top-0 z-50 w-full border-b bg-background">
                <div className="container flex h-16 items-center justify-end px-4">
                    <Skeleton className="h-8 w-24 rounded-md" />
                </div>
            </header>
        );
    }

    if (!user) {
        return (
            <header className="sticky top-0 z-50 w-full border-b bg-background">
                <div className="container flex h-16 items-center justify-end px-4">
                    <Button variant="outline" size="sm" asChild>
                        <Link href="/login">Войти</Link>
                    </Button>
                </div>
            </header>
        );
    }

    const userroles = user?.roles || 'USER';
    const firstLetter = getFirstLetter(user.username);
    const avatarColor = getAvatarColor(user.username);

    return (
        <header className="sticky top-0 z-50 w-full border-b bg-background ">
            <div className="container flex h-16 items-center px-4 gap-4">
                <img src="/logowhite.svg" alt="CAD" className="h-8" />
                <span className="font-bold text-lg">Compass</span>
                <div className="flex-1" />
                <UserDepartmentSelect/>
                <Button
                    variant="outline"
                    size="sm"
                    onClick={() => setLanguage(language === 'en' ? 'ru' : 'en')}
                >
                    {langLabel}
                </Button>
                <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" className="gap-2 hover:bg-accent">
                            <Avatar className="h-8 w-8">
                                <AvatarFallback className={`${avatarColor} text-white font-bold`}>
                                    {firstLetter}
                                </AvatarFallback>
                            </Avatar>
                            <span className="font-medium">{user.username}</span>
                            <ChevronDown className="h-4 w-4 opacity-50" />
                        </Button>
                    </DropdownMenuTrigger>

                    <DropdownMenuContent align="end" className="w-48">
                        <DropdownMenuItem asChild>
                            <Link href="/profile" className="cursor-pointer">
                                <User className="mr-2 h-4 w-4" />
                                Профиль
                            </Link>
                        </DropdownMenuItem>

                        {Array.isArray(user.roles) && user.roles.includes('ADMIN') && (
                            <>
                                <DropdownMenuSeparator />
                                <DropdownMenuItem asChild>
                                    <Link href="/admin" className="cursor-pointer">
                                        <Settings className="mr-2 h-4 w-4" />
                                        Админ панель
                                    </Link>
                                </DropdownMenuItem>
                            </>
                        )}


                        <DropdownMenuItem asChild>
                            <Link href="/settings" className="cursor-pointer">
                                <Settings className="mr-2 h-4 w-4" />
                                Настройки
                            </Link>
                        </DropdownMenuItem>

                        <DropdownMenuSeparator />

                        <DropdownMenuItem
                            className="cursor-pointer text-destructive focus:text-destructive"
                            onClick={handleLogout}
                        >
                            <LogOut className="mr-2 h-4 w-4" />
                            Выйти
                        </DropdownMenuItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            </div>
        </header>
    );
}