"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { Copy, Check, RefreshCw, User, Shield, Building2, Calendar } from "lucide-react";
import { authApi } from "@/lib/auth";
import axios from "axios";

interface UserProfile {
    id: string;
    username: string;
    email?: string;
    uuid?: string;
    roles: string[];
    department?: {
        id: string;
        name: string;
        shortCode: string;
        color?: string;
        icon?: string;
        type: string;
    };
    createdAt: string;
    lastSeen?: string;
    isVerified?: boolean;
    isWhitelisted?: boolean;
}

export default function ProfilePage() {
    const router = useRouter();
    const [user, setUser] = useState<UserProfile | null>(null);
    const [loading, setLoading] = useState(true);
    const [uuid, setUuid] = useState<string | null>(null);
    const [uuidLoading, setUuidLoading] = useState(false);
    const [copied, setCopied] = useState(false);

    useEffect(() => {
        const fetchProfile = async () => {
            try {
                const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
                const baseUrl = API_URL.endsWith('/api') ? API_URL : `${API_URL}/api`;
                const response = await axios.get(`${baseUrl}/user/me`, { withCredentials: true });
                console.log('Profile response:', response.data);
                
                let userData = null;
                
                if (response.data?.data?.user) {
                    userData = response.data.data.user;
                } else if (response.data?.user) {
                    userData = response.data.user;
                } else if (response.data?.data) {
                    userData = response.data.data;
                }
                
                console.log('Found userData:', userData);
                
                if (userData) {
                    setUser(userData);
                    setUuid(userData.uuid || null);
                }
            } catch (error: any) {
                console.error('Error fetching profile:', error);
                if (error?.response?.status === 401) {
                    router.push('/login');
                } else {
                    toast.error('Не удалось загрузить профиль');
                }
            } finally {
                setLoading(false);
            }
        };

        fetchProfile();
    }, [router]);

    const generateUuid = async () => {
        setUuidLoading(true);
        try {
            const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
            const baseUrl = API_URL.endsWith('/api') ? API_URL : `${API_URL}/api`;
            const response = await axios.get(`${baseUrl}/user/me/uuid`, { withCredentials: true });
            
            if (response.data?.uuid) {
                setUuid(response.data.uuid);
                toast.success('UUID создан! Скопируйте его и введите в игре: /uuid ' + response.data.uuid);
            }
        } catch (error: any) {
            console.error('Error generating UUID:', error?.response?.data || error);
            toast.error('Не удалось создать UUID');
        } finally {
            setUuidLoading(false);
        }
    };

    const copyUuid = async () => {
        if (!uuid) return;
        
        try {
            await navigator.clipboard.writeText(uuid);
            setCopied(true);
            toast.success('UUID скопирован в буфер обмена!');
            setTimeout(() => setCopied(false), 2000);
        } catch (error) {
            toast.error('Не удалось скопировать');
        }
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center min-h-screen">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
            </div>
        );
    }

    if (!user) {
        return (
            <div className="flex items-center justify-center min-h-screen">
                <p className="text-gray-500">Профиль не найден</p>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">
                <h1 className="text-2xl font-bold mb-6">Профиль</h1>
                
                <div className="bg-gray-900 rounded-lg p-6 mb-6">
                    <div className="flex items-center gap-4 mb-6">
                        <div className="w-16 h-16 bg-blue-600 rounded-full flex items-center justify-center text-2xl font-bold">
                            {user.username.charAt(0).toUpperCase()}
                        </div>
                        <div>
                            <h2 className="text-xl font-semibold">{user.username}</h2>
                            {user.email && <p className="text-gray-400 text-sm">{user.email}</p>}
                        </div>
                    </div>

                    <div className="grid gap-4">
                        <div className="flex items-center gap-3 text-gray-300">
                            <Shield className="w-5 h-5 text-blue-400" />
                            <span className="text-sm">Роли: {user.roles.join(', ') || 'USER'}</span>
                        </div>

                        {user.department && (
                            <div className="flex items-center gap-3 text-gray-300">
                                <Building2 className="w-5 h-5 text-green-400" />
                                <span className="text-sm">Департамент: {user.department.name} ({user.department.shortCode})</span>
                            </div>
                        )}

                        <div className="flex items-center gap-3 text-gray-300">
                            <Calendar className="w-5 h-5 text-purple-400" />
                            <span className="text-sm">Дата регистрации: {new Date(user.createdAt).toLocaleDateString('ru-RU')}</span>
                        </div>
                    </div>
                </div>

                <div className="bg-gray-900 rounded-lg p-6">
                    <h3 className="text-lg font-semibold mb-4">Синхронизация с игрой (FiveM)</h3>
                    <p className="text-gray-400 text-sm mb-4">
                        Привяжите свой профиль к игре, чтобы видеть вызовы 911 в реальном времени.
                    </p>

                    {!uuid ? (
                        <button
                            onClick={generateUuid}
                            disabled={uuidLoading}
                            className="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 disabled:bg-blue-800 rounded-lg transition-colors"
                        >
                            {uuidLoading ? (
                                <>
                                    <RefreshCw className="w-4 h-4 animate-spin" />
                                    <span>Создание UUID...</span>
                                </>
                            ) : (
                                <>
                                    <RefreshCw className="w-4 h-4" />
                                    <span>Создать UUID</span>
                                </>
                            )}
                        </button>
                    ) : (
                        <div className="space-y-3">
                            <div className="flex items-center gap-2">
                                <code className="flex-1 bg-gray-800 px-4 py-3 rounded-lg font-mono text-sm break-all">
                                    {uuid}
                                </code>
                                <button
                                    onClick={copyUuid}
                                    className="p-3 bg-gray-800 hover:bg-gray-700 rounded-lg transition-colors"
                                >
                                    {copied ? <Check className="w-5 h-5 text-green-400" /> : <Copy className="w-5 h-5" />}
                                </button>
                            </div>
                            <p className="text-gray-400 text-sm">
                                В игре введите команду: <code className="bg-gray-800 px-2 py-1 rounded">/uuid {uuid}</code>
                            </p>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}
