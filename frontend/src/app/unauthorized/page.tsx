'use client';

import Link from 'next/link';
import { ShieldAlert } from 'lucide-react';
import { Button } from '@/components/ui/button';

export default function UnauthorizedPage() {
    return (
        <div className="flex flex-col items-center justify-center min-h-screen text-center px-4">
            <div className="p-4 bg-destructive/10 rounded-full mb-6">
                <ShieldAlert className="w-16 h-16 text-destructive" />
            </div>
            <h1 className="text-4xl font-bold mb-2">Доступ запрещен</h1>
            <p className="text-muted-foreground mb-8 max-w-md">
                У вас недостаточно прав для просмотра этой страницы. Если вы считаете, что это ошибка, обратитесь к администратору.
            </p>
            <div className="flex gap-4">
                <Button asChild variant="default">
                    <Link href="/dashboard">Вернуться в кабинет</Link>
                </Button>
                <Button asChild variant="outline">
                    <Link href="/">На главную</Link>
                </Button>
            </div>
        </div>
    );
}
