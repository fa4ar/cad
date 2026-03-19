'use client'

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
import { useState, FormEvent, useEffect } from "react"
import { useRouter } from "next/navigation"
import { toast } from "sonner"
import { authService, authUtils, AuthMethodsResponse } from "@/lib/auth"
import { Loader2, MessageCircle, Globe } from "lucide-react"

interface SignupFormData {
    username: string
    password: string
    confirmPassword: string
}

interface SignupFormProps {
    className?: string
    onSuccess?: () => void
    onError?: (error: string) => void
}

export function SignupForm({ onSuccess, onError, className }: SignupFormProps) {
    const router = useRouter()
    const [isLoading, setIsLoading] = useState(false)
    const [authMethods, setAuthMethods] = useState<AuthMethodsResponse | null>(null)
    const [loadingMethods, setLoadingMethods] = useState(true)
    const [formData, setFormData] = useState<SignupFormData>({
        username: "",
        password: "",
        confirmPassword: ""
    })
    const [formErrors, setFormErrors] = useState<Record<string, string>>({})

    // Загружаем доступные методы авторизации
    useEffect(() => {
        const loadAuthMethods = async () => {
            try {
                const methods = await authService.getAuthMethods()
                setAuthMethods(methods)
            } catch (error) {
                console.error('Ошибка загрузки методов авторизации:', error)
            } finally {
                setLoadingMethods(false)
            }
        }

        loadAuthMethods()
    }, [])

    // Проверяем, доступна ли локальная регистрация
    const isLocalAuthEnabled = authMethods?.methods.some(
        m => m.type === 'local' && m.enabled
    ) ?? true

    // Проверяем, доступен ли Discord
    const isDiscordEnabled = authMethods?.methods.some(
        m => m.type === 'discord' && m.enabled
    ) ?? false

    // Проверяем, доступен ли IPS
    const isIPSEnabled = authMethods?.methods.some(
        m => m.type === 'ips' && m.enabled
    ) ?? false

    // Если локальная регистрация отключена и есть OAuth - показываем сообщение
    const showOAuthOnly = !isLocalAuthEnabled && (isDiscordEnabled || isIPSEnabled)

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { id, value } = e.target
        setFormData(prev => ({
            ...prev,
            [id]: value
        }))
        if (formErrors[id]) {
            setFormErrors(prev => {
                const newErrors = { ...prev }
                delete newErrors[id]
                return newErrors
            })
        }
    }

    const validateForm = (): boolean => {
        const errors: Record<string, string> = {}

        if (!formData.username.trim()) {
            errors.username = "Имя пользователя обязательно"
        } else if (formData.username.length < 3) {
            errors.username = "Имя пользователя должно содержать минимум 3 символа"
        } else if (formData.username.length > 20) {
            errors.username = "Имя пользователя не должно превышать 20 символов"
        } else if (!/^[a-zA-Z0-9_-]+$/.test(formData.username)) {
            errors.username = "Имя пользователя может содержать только буквы, цифры, дефисы и подчеркивания"
        }

        if (!formData.password) {
            errors.password = "Пароль обязателен"
        } else if (formData.password.length < 6) {
            errors.password = "Пароль должен содержать минимум 6 символов"
        } else if (!/[a-zA-Z]/.test(formData.password)) {
            errors.password = "Пароль должен содержать хотя бы одну букву"
        } else if (!/\d/.test(formData.password)) {
            errors.password = "Пароль должен содержать хотя бы одну цифру"
        }

        if (!formData.confirmPassword) {
            errors.confirmPassword = "Подтверждение пароля обязательно"
        } else if (formData.password !== formData.confirmPassword) {
            errors.confirmPassword = "Пароли не совпадают"
        }

        setFormErrors(errors)
        return Object.keys(errors).length === 0
    }

    const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault()

        if (!validateForm()) {
            return
        }

        setIsLoading(true)

        try {
            const requestData = {
                username: formData.username.trim(),
                password: formData.password
            };

            const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
            const authUrl = apiUrl.endsWith('/api') ? `${apiUrl}/auth/register` : `${apiUrl}/api/auth/register`;
            
            const response = await fetch(authUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData),
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || data.message || `Ошибка ${response.status}`);
            }

            // Сохраняем токен и данные пользователя
            if (data.data?.token) {
                authUtils.saveAuth(data.data)
                
                // Устанавливаем cookie для middleware
                document.cookie = `auth-token=${data.data.token}; path=/; max-age=604800; SameSite=Lax`;
            }

            // Очистка формы
            setFormData({
                username: "",
                password: "",
                confirmPassword: ""
            });
            setFormErrors({});

            toast.success('Аккаунт успешно создан!')
            onSuccess?.();
            
            // Принудительно обновляем страницу чтобы middleware сработал
            window.location.href = '/pages/citizen'

        } catch (error) {
            console.error('Ошибка регистрации:', error);
            const errorMessage = error instanceof Error ? error.message : 'Ошибка регистрации';
            onError?.(errorMessage);
            toast.error(errorMessage)
        } finally {
            setIsLoading(false)
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
            <Card className={className}>
                <CardContent className="flex flex-col items-center justify-center p-8">
                    <Loader2 className="h-8 w-8 animate-spin mb-4" />
                    <p className="text-muted-foreground">Загрузка...</p>
                </CardContent>
            </Card>
        )
    }

    // Если регистрация только через OAuth
    if (showOAuthOnly) {
        return (
            <Card className={className}>
                <CardHeader>
                    <CardTitle>Создать аккаунт</CardTitle>
                    <CardDescription>
                        Регистрация доступна только через внешние сервисы
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
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

                    <FieldDescription className="text-center">
                        Уже есть аккаунт?{" "}
                        <a href="/login" className="underline font-medium">
                            Войти
                        </a>
                    </FieldDescription>
                </CardContent>
            </Card>
        )
    }

    return (
        <Card className={className}>
            <CardHeader>
                <CardTitle>Создать аккаунт</CardTitle>
                <CardDescription>
                    Введите ваши данные для создания аккаунта
                </CardDescription>
            </CardHeader>
            <CardContent>
                <form onSubmit={handleSubmit}>
                    <FieldGroup>
                        <Field>
                            <FieldLabel htmlFor="username">Имя пользователя</FieldLabel>
                            <Input
                                id="username"
                                type="text"
                                placeholder="Введите имя пользователя"
                                value={formData.username}
                                onChange={handleInputChange}
                                required
                                disabled={isLoading}
                                minLength={3}
                                maxLength={20}
                                aria-invalid={!!formErrors.username}
                            />
                            <FieldDescription>
                                От 3 до 20 символов. Только буквы, цифры, дефисы и подчеркивания.
                            </FieldDescription>
                            {formErrors.username && (
                                <FieldDescription className="text-red-500">
                                    {formErrors.username}
                                </FieldDescription>
                            )}
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="password">Пароль</FieldLabel>
                            <Input
                                id="password"
                                type="password"
                                placeholder="Введите пароль"
                                value={formData.password}
                                onChange={handleInputChange}
                                required
                                disabled={isLoading}
                                minLength={6}
                                aria-invalid={!!formErrors.password}
                            />
                            <FieldDescription>
                                Минимум 6 символов, должен содержать буквы и цифры.
                            </FieldDescription>
                            {formErrors.password && (
                                <FieldDescription className="text-red-500">
                                    {formErrors.password}
                                </FieldDescription>
                            )}
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="confirmPassword">Подтвердите пароль</FieldLabel>
                            <Input
                                id="confirmPassword"
                                type="password"
                                placeholder="Повторите пароль"
                                value={formData.confirmPassword}
                                onChange={handleInputChange}
                                required
                                disabled={isLoading}
                                aria-invalid={!!formErrors.confirmPassword}
                            />
                            {formErrors.confirmPassword && (
                                <FieldDescription className="text-red-500">
                                    {formErrors.confirmPassword}
                                </FieldDescription>
                            )}
                        </Field>

                        {/* OAuth кнопки если доступны */}
                        {(isDiscordEnabled || isIPSEnabled) && (
                            <>
                                <div className="relative my-4">
                                    <div className="absolute inset-0 flex items-center">
                                        <span className="w-full border-t" />
                                    </div>
                                    <div className="relative flex justify-center text-xs uppercase">
                                        <span className="bg-background px-2 text-muted-foreground">
                                            Или зарегистрируйтесь через
                                        </span>
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    {isDiscordEnabled && (
                                        <Button
                                            type="button"
                                            variant="outline"
                                            className="w-full"
                                            onClick={handleDiscordLogin}
                                        >
                                            <MessageCircle className="mr-2 h-4 w-4 text-[#5865F2]" />
                                            Discord
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
                                            Форум
                                        </Button>
                                    )}
                                </div>
                            </>
                        )}

                        <FieldGroup>
                            <Field className="space-y-4 pt-4">
                                <Button
                                    type="submit"
                                    className="w-full"
                                    disabled={isLoading}
                                >
                                    {isLoading ? (
                                        <>
                                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                            Создание аккаунта...
                                        </>
                                    ) : (
                                        "Создать аккаунт"
                                    )}
                                </Button>
                                <FieldDescription className="px-6 text-center">
                                    Уже есть аккаунт? <a href="/login" className="underline">Войти</a>
                                </FieldDescription>
                            </Field>
                        </FieldGroup>
                    </FieldGroup>
                </form>
            </CardContent>
        </Card>
    )
}
