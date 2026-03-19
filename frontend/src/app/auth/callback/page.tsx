'use client'

import { useEffect, useState } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { toast } from 'sonner'
import { authUtils } from '@/lib/auth'
import { Loader2, CheckCircle, XCircle } from 'lucide-react'
import { Button } from '@/components/ui/button'

export default function AuthCallbackPage() {
    const router = useRouter()
    const searchParams = useSearchParams()
    const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading')
    const [message, setMessage] = useState('Обработка авторизации...')

    useEffect(() => {
        const handleCallback = async () => {
            const token = searchParams.get('token')
            const provider = searchParams.get('provider')
            const error = searchParams.get('error')

            if (error) {
                setStatus('error')
                setMessage(`Ошибка авторизации: ${error}`)
                toast.error('Ошибка авторизации')
                return
            }

            if (!token) {
                setStatus('error')
                setMessage('Токен авторизации не получен')
                toast.error('Ошибка авторизации')
                return
            }

            try {
                // Получаем данные пользователя с помощью токена
                const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
                const authUrl = apiUrl.endsWith('/api') ? `${apiUrl}/auth/me` : `${apiUrl}/api/auth/me`;
                
                const response = await fetch(authUrl, {
                    headers: {
                        'Authorization': `Bearer ${token}`,
                    },
                })

                if (!response.ok) {
                    throw new Error('Не удалось получить данные пользователя')
                }

                const data = await response.json()

                if (data.success && data.data) {
                    // Сохраняем токен и данные пользователя
                    authUtils.saveAuth({
                        token,
                        user: data.data,
                    })
                    
                    // Устанавливаем cookie для middleware
                    document.cookie = `auth-token=${token}; path=/; max-age=604800; SameSite=Lax`;

                    setStatus('success')
                    setMessage(`Успешная авторизация через ${provider === 'discord' ? 'Discord' : provider === 'ips' ? 'форум' : 'внешний сервис'}!`)
                    toast.success('Успешный вход в систему')

                    // Редирект на главную страницу через 2 секунды
                    setTimeout(() => {
                        window.location.href = '/pages/citizen'
                    }, 2000)
                } else {
                    throw new Error('Некорректный ответ от сервера')
                }
            } catch (error) {
                console.error('Auth callback error:', error)
                setStatus('error')
                setMessage('Ошибка при обработке авторизации')
                toast.error('Ошибка авторизации')
            }
        }

        handleCallback()
    }, [searchParams, router])

    return (
        <div className="flex min-h-screen items-center justify-center bg-background">
            <div className="w-full max-w-md space-y-8 p-8">
                <div className="flex flex-col items-center justify-center space-y-6">
                    {status === 'loading' && (
                        <>
                            <Loader2 className="h-16 w-16 animate-spin text-primary" />
                            <h2 className="text-2xl font-bold text-center">{message}</h2>
                            <p className="text-muted-foreground text-center">
                                Пожалуйста, подождите...
                            </p>
                        </>
                    )}

                    {status === 'success' && (
                        <>
                            <CheckCircle className="h-16 w-16 text-green-500" />
                            <h2 className="text-2xl font-bold text-center text-green-600">
                                {message}
                            </h2>
                            <p className="text-muted-foreground text-center">
                                Перенаправление на главную страницу...
                            </p>
                        </>
                    )}

                    {status === 'error' && (
                        <>
                            <XCircle className="h-16 w-16 text-red-500" />
                            <h2 className="text-2xl font-bold text-center text-red-600">
                                Ошибка авторизации
                            </h2>
                            <p className="text-muted-foreground text-center">
                                {message}
                            </p>
                            <Button
                                onClick={() => router.push('/login')}
                                variant="outline"
                                className="mt-4"
                            >
                                Вернуться на страницу входа
                            </Button>
                        </>
                    )}
                </div>
            </div>
        </div>
    )
}
