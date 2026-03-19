'use client'

import { Inter } from 'next/font/google'
import './globals.css'
import { SocketProvider } from '@/components/SocketProvider'
import { AuthProvider } from '@/hooks/useAuth'
import { Toaster } from 'sonner'
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useState } from "react";
import { Header } from "./../components/Header"
import { LanguageProvider } from "@/hooks/useLanguage"

const inter = Inter({ subsets: ['latin'] })

import { PermissionGuard } from '@/components/PermissionGuard'

export default function RootLayout({
    children,
}: {
    children: React.ReactNode
}) {
    // Создаем QueryClient внутри компонента
    const [queryClient] = useState(() => new QueryClient({
        defaultOptions: {
            queries: {
                staleTime: 60 * 1000, // 1 минута
                retry: 1,
            },
        },
    }))

    return (
        <html lang="ru" className={'dark'}>
            <head>
                <title>CAD System</title>
                <link rel="icon" href="/logowhite.svg" type="image/svg+xml" />
                <meta name="description" content="Computer-Aided Dispatch System" />
            </head>
            <body className={inter.className}>
                <QueryClientProvider client={queryClient}>
                    <AuthProvider>
                        <LanguageProvider>
                        {/* PermissionGuard должен оборачивать все, что требует проверки прав */}
                        <PermissionGuard>
                            <SocketProvider>
                                <Header/>
                                <main className="min-h-screen"> {/* Добавил отступ для фиксированного хедера */}
                                    {children}
                                </main>
                                <Toaster position="top-right" />
                            </SocketProvider>
                        </PermissionGuard>
                        </LanguageProvider>
                    </AuthProvider>
                </QueryClientProvider>
            </body>
        </html>
    )
}