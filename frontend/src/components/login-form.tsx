"use client"

import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"
import {
    Card,
    CardContent,
    CardDescription,
    CardHeader,
    CardTitle,
} from "@/components/ui/card"
import {
    Field,
    FieldDescription,
    FieldGroup,
    FieldLabel,
} from "@/components/ui/field"
import { Input } from "@/components/ui/input"
import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import { toast } from "sonner"
import { authService, authUtils, AuthMethod, AuthMethodsResponse } from "@/lib/auth"
import { Loader2, MessageCircle, Globe } from "lucide-react"

export function LoginForm({
    className,
    ...props
}: React.ComponentProps<"div">) {
    const [username, setUsername] = useState("")
    const [password, setPassword] = useState("")
    const [loading, setLoading] = useState(false)
    const [authMethods, setAuthMethods] = useState<AuthMethodsResponse | null>(null)
    const [loadingMethods, setLoadingMethods] = useState(true)
    const router = useRouter()

    // Загружаем доступные методы авторизации
    useEffect(() => {
        const loadAuthMethods = async () => {
            try {
                const methods = await authService.getAuthMethods()
                setAuthMethods(methods)
            } catch (error) {
                console.error('Ошибка загрузки методов авторизации:', error)
                toast.error('Не удалось загрузить методы авторизации')
            } finally {
                setLoadingMethods(false)
            }
        }

        loadAuthMethods()
    }, [])

    // Проверяем, доступен ли локальный вход
    const isLocalAuthEnabled = authMethods?.methods.some(
        m => m.type === 'local' && m.enabled
    ) ?? true // По умолчанию показываем локальный вход

    // Проверяем, доступен ли Discord
    const isDiscordEnabled = authMethods?.methods.some(
        m => m.type === 'discord' && m.enabled
    ) ?? false

    // Проверяем, доступен ли IPS
    const isIPSEnabled = authMethods?.methods.some(
        m => m.type === 'ips' && m.enabled
    ) ?? false

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault()
        setLoading(true)

        try {
            const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
            const authUrl = apiUrl.endsWith('/api') ? `${apiUrl}/auth/login` : `${apiUrl}/api/auth/login`;
            
            const response = await fetch(authUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    username,
                    password,
                }),
                credentials: 'include',
            })

            const data = await response.json()

            if (!response.ok) {
                throw new Error(data.error || 'Ошибка при входе')
            }

            // Сохраняем токен и данные пользователя
            authUtils.saveAuth(data.data)
            
            // Устанавливаем cookie для middleware (httpOnly не установить с клиента, 
            // но для проверки в middleware достаточно обычного cookie)
            document.cookie = `auth-token=${data.data.token}; path=/; max-age=604800; SameSite=Lax`;

            toast.success('Успешный вход в систему')
            
            // Принудительно обновляем страницу чтобы middleware сработал
            window.location.href = '/pages/citizen'
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Ошибка при входе')
        } finally {
            setLoading(false)
        }
    }

    const handleDiscordLogin = () => {
        if (authMethods?.urls?.discord) {
            window.location.href = authMethods.urls.discord
        } else {
            toast.error('Discord авторизация недоступна')
        }
    }

    const handleIPSLogin = () => {
        if (authMethods?.urls?.ips) {
            window.location.href = authMethods.urls.ips
        } else {
            toast.error('IPS авторизация недоступна')
        }
    }

    if (loadingMethods) {
        return (
            <div className={cn("flex flex-col gap-6 items-center justify-center p-8", className)} {...props}>
                <Loader2 className="h-8 w-8 animate-spin" />
                <p className="text-muted-foreground">Загрузка...</p>
            </div>
        )
    }

    return (
        <div className={cn("flex flex-col gap-6", className)} {...props}>
            <Card>
                <CardHeader>
                    <CardTitle>Вход в аккаунт</CardTitle>
                    <CardDescription>
                        Выберите способ входа в систему
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                    {/* Локальная авторизация */}
                    {isLocalAuthEnabled && (
                        <form onSubmit={handleSubmit} className="space-y-4">
                            <FieldGroup>
                                <Field>
                                    <FieldLabel htmlFor="username">Имя пользователя</FieldLabel>
                                    <Input
                                        id="username"
                                        type="text"
                                        placeholder="Введите имя пользователя"
                                        required
                                        value={username}
                                        onChange={(e) => setUsername(e.target.value)}
                                        disabled={loading}
                                        minLength={3}
                                        maxLength={20}
                                    />
                                </Field>
                                <Field>
                                    <FieldLabel htmlFor="password">Пароль</FieldLabel>
                                    <Input
                                        id="password"
                                        type="password"
                                        placeholder="Введите пароль"
                                        required
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        disabled={loading}
                                        minLength={6}
                                    />
                                </Field>
                                <Button type="submit" className="w-full" disabled={loading}>
                                    {loading ? (
                                        <>
                                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                            Вход...
                                        </>
                                    ) : (
                                        "Войти"
                                    )}
                                </Button>
                            </FieldGroup>
                        </form>
                    )}

                    {/* Разделитель если есть OAuth методы */}
                    {(isDiscordEnabled || isIPSEnabled) && isLocalAuthEnabled && (
                        <div className="relative">
                            <div className="absolute inset-0 flex items-center">
                                <span className="w-full border-t" />
                            </div>
                            <div className="relative flex justify-center text-xs uppercase">
                                <span className="bg-background px-2 text-muted-foreground">
                                    Или войдите через
                                </span>
                            </div>
                        </div>
                    )}

                    {/* OAuth кнопки */}
                    <div className="space-y-2">
                        {isDiscordEnabled && (
                            <Button
                                type="button"
                                variant="outline"
                                className="w-full"
                                onClick={handleDiscordLogin}
                            >
                                <MessageCircle className="mr-2 h-4 w-4 text-[#5865F2]" />
                                Войти через Discord
                            </Button>
                        )}

                        {isIPSEnabled && (
                            <Button
                                type="button"
                                variant="outline"
                                className="w-full"
                                onClick={handleIPSLogin}
                            >
                                <Globe className="mr-2 h-4 w-4" />
                                Войти через форум
                            </Button>
                        )}
                    </div>

                    {/* Ссылка на регистрацию (только если включена локальная авторизация) */}
                    {isLocalAuthEnabled && (
                        <FieldDescription className="text-center">
                            Нет аккаунта?{" "}
                            <a href="/signup" className="hover:underline font-medium">
                                Зарегистрироваться
                            </a>
                        </FieldDescription>
                    )}
                </CardContent>
            </Card>
        </div>
    )
}
