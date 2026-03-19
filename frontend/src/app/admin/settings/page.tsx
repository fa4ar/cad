'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { toast } from 'sonner';
import api from '@/lib/api/axios';
import { Settings as SettingsIcon, Shield, Save, Users, Building, Bell, Palette } from 'lucide-react';

interface Settings {
    enableApplicationSystem: string;
    applicationRequireApproval: string;
}

export default function SettingsPage() {
    const [settings, setSettings] = useState<Settings>({
        enableApplicationSystem: 'false',
        applicationRequireApproval: 'true'
    });
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);

    useEffect(() => {
        fetchSettings();
    }, []);

    const fetchSettings = async () => {
        try {
            const res = await api.get('/system-settings');
            if (res.data.settings) {
                setSettings(prev => ({
                    ...prev,
                    enableApplicationSystem: res.data.settings.enableApplicationSystem || 'false',
                    applicationRequireApproval: res.data.settings.applicationRequireApproval || 'true'
                }));
            }
        } catch (error) {
            console.error('Error fetching settings:', error);
        } finally {
            setLoading(false);
        }
    };

    const saveSettings = async () => {
        setSaving(true);
        try {
            await api.put(`/system-settings/enableApplicationSystem`, { value: String(settings.enableApplicationSystem) });
            await api.put(`/system-settings/applicationRequireApproval`, { value: String(settings.applicationRequireApproval) });
            toast.success('Настройки сохранены');
        } catch (error: any) {
            console.error('Error saving settings:', error);
            toast.error(error.response?.data?.error || 'Ошибка сохранения');
        } finally {
            setSaving(false);
        }
    };

    if (loading) {
        return <div className="p-6">Загрузка...</div>;
    }

    return (
        <div className="p-6 space-y-6">
            <div className="flex items-center gap-3">
                <SettingsIcon className="h-8 w-8" />
                <div>
                    <h1 className="text-2xl font-bold">Настройки системы</h1>
                    <p className="text-muted-foreground">Конфигурация проекта</p>
                </div>
            </div>

            <Tabs defaultValue="general" className="w-full">
                <div className="flex gap-6">
                    <div className="w-64 shrink-0">
                        <TabsList className="flex flex-col w-full h-auto bg-transparent gap-1">
                            <TabsTrigger value="general" className="justify-start gap-2 w-full">
                                <Shield className="h-4 w-4" />
                                Общие
                            </TabsTrigger>
                            <TabsTrigger value="users" className="justify-start gap-2 w-full">
                                <Users className="h-4 w-4" />
                                Пользователи
                            </TabsTrigger>
                            <TabsTrigger value="departments" className="justify-start gap-2 w-full">
                                <Building className="h-4 w-4" />
                                Департаменты
                            </TabsTrigger>
                            <TabsTrigger value="notifications" className="justify-start gap-2 w-full">
                                <Bell className="h-4 w-4" />
                                Уведомления
                            </TabsTrigger>
                            <TabsTrigger value="appearance" className="justify-start gap-2 w-full">
                                <Palette className="h-4 w-4" />
                                Внешний вид
                            </TabsTrigger>
                        </TabsList>
                    </div>

                    <div className="flex-1">
                        <TabsContent value="general">
                            <Card>
                                <CardHeader>
                                    <CardTitle className="flex items-center gap-2">
                                        <Shield className="h-5 w-5" />
                                        Система заявок
                                    </CardTitle>
                                    <CardDescription>
                                        Настройка системы подачи заявок для доступа к CAD
                                    </CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-6">
                                    <div className="flex items-center justify-between">
                                        <div className="space-y-1">
                                            <Label>Включить систему заявок</Label>
                                            <p className="text-sm text-muted-foreground">
                                                После регистрации пользователи должны подать заявку для доступа к CAD
                                            </p>
                                        </div>
                                        <Switch
                                            checked={settings.enableApplicationSystem === 'true'}
                                            onCheckedChange={(checked) => setSettings(prev => ({
                                                ...prev,
                                                enableApplicationSystem: checked ? 'true' : 'false'
                                            }))}
                                        />
                                    </div>

                                    <div className="flex items-center justify-between">
                                        <div className="space-y-1">
                                            <Label>Требовать одобрение</Label>
                                            <p className="text-sm text-muted-foreground">
                                                Заявки должны быть одобрены администратором
                                            </p>
                                        </div>
                                        <Switch
                                            checked={settings.applicationRequireApproval === 'true'}
                                            onCheckedChange={(checked) => setSettings(prev => ({
                                                ...prev,
                                                applicationRequireApproval: checked ? 'true' : 'false'
                                            }))}
                                            disabled={settings.enableApplicationSystem !== 'true'}
                                        />
                                    </div>

                                    <Button onClick={saveSettings} disabled={saving} className="w-full">
                                        <Save className="h-4 w-4 mr-2" />
                                        {saving ? 'Сохранение...' : 'Сохранить настройки'}
                                    </Button>
                                </CardContent>
                            </Card>
                        </TabsContent>

                        <TabsContent value="users">
                            <Card>
                                <CardHeader>
                                    <CardTitle className="flex items-center gap-2">
                                        <Users className="h-5 w-5" />
                                        Настройки пользователей
                                    </CardTitle>
                                    <CardDescription>
                                        Параметры регистрации и авторизации
                                    </CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <p className="text-muted-foreground">Настройки пользователей скоро будут доступны...</p>
                                </CardContent>
                            </Card>
                        </TabsContent>

                        <TabsContent value="departments">
                            <Card>
                                <CardHeader>
                                    <CardTitle className="flex items-center gap-2">
                                        <Building className="h-5 w-5" />
                                        Настройки департаментов
                                    </CardTitle>
                                    <CardDescription>
                                        Параметры департаментов
                                    </CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <p className="text-muted-foreground">Настройки департаментов скоро будут доступны...</p>
                                </CardContent>
                            </Card>
                        </TabsContent>

                        <TabsContent value="notifications">
                            <Card>
                                <CardHeader>
                                    <CardTitle className="flex items-center gap-2">
                                        <Bell className="h-5 w-5" />
                                        Уведомления
                                    </CardTitle>
                                    <CardDescription>
                                        Настройки уведомлений
                                    </CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <p className="text-muted-foreground">Настройки уведомлений скоро будут доступны...</p>
                                </CardContent>
                            </Card>
                        </TabsContent>

                        <TabsContent value="appearance">
                            <Card>
                                <CardHeader>
                                    <CardTitle className="flex items-center gap-2">
                                        <Palette className="h-5 w-5" />
                                        Внешний вид
                                    </CardTitle>
                                    <CardDescription>
                                        Настройки оформления
                                    </CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <p className="text-muted-foreground">Настройки внешнего вида скоро будут доступны...</p>
                                </CardContent>
                            </Card>
                        </TabsContent>
                    </div>
                </div>
            </Tabs>
        </div>
    );
}
