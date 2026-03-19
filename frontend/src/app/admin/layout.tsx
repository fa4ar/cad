'use client';

import React from 'react';
import { AdminGuard } from '@/components/admin/AdminGuard';

/**
 * Layout для админ-панели.
 * Защищает все admin страницы с помощью AdminGuard.
 */
export default function AdminLayout({ children }: { children: React.ReactNode }) {
    return (
        <AdminGuard>
            <div className="min-h-screen bg-background">
                {/* Здесь можно добавить Sidebar или AdminHeader */}
                <main>{children}</main>
            </div>
        </AdminGuard>
    );
}
