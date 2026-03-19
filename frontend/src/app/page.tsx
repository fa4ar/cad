"use client";
import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/hooks/useAuth";
import api from "@/lib/api/axios";

export default function Home() {
    const router = useRouter();
    const { user, loading: authLoading } = useAuth();

    useEffect(() => {
        if (authLoading) return;
        
        const checkAndRedirect = async () => {
            try {
                const settingsRes = await api.get('/system-settings/enableApplicationSystem');
                const isEnabled = settingsRes.data.value === 'true';

                if (isEnabled && user) {
                    const appRes = await api.get('/applications/my');
                    const app = appRes.data.application;

                    if (!app || app.status === 'pending' || app.status === 'rejected') {
                        router.push('/application');
                        return;
                    }
                }
                
                if (!user) {
                    router.push('/login');
                } else {
                    router.push('/police');
                }
            } catch (error) {
                if (!user) {
                    router.push('/login');
                } else {
                    router.push('/police');
                }
            }
        };

        checkAndRedirect();
    }, [router, user, authLoading]);

    return (
        <div className="flex justify-center items-center min-h-screen">
            <div className="text-center">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto"></div>
                <p className="mt-4 text-gray-600">Перенаправление...</p>
            </div>
        </div>
    );
}