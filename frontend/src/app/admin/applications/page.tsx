'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { toast } from 'sonner';
import api from '@/lib/api/axios';
import { FileText, Check, X, Search, User } from 'lucide-react';

interface Application {
    id: string;
    discordId: string | null;
    discordName: string | null;
    robloxUsername: string | null;
    age: number | null;
    whyJoin: string;
    experience: string | null;
    status: string;
    reviewedBy: string | null;
    reviewedAt: string | null;
    rejectReason: string | null;
    createdAt: string;
    user: {
        id: string;
        username: string;
        email: string;
    };
}

export default function ApplicationsAdminPage() {
    const [applications, setApplications] = useState<Application[]>([]);
    const [loading, setLoading] = useState(true);
    const [filter, setFilter] = useState<string>('pending');
    const [selectedApp, setSelectedApp] = useState<Application | null>(null);
    const [rejectReason, setRejectReason] = useState('');

    useEffect(() => {
        fetchApplications();
    }, [filter]);

    const fetchApplications = async () => {
        try {
            const res = await api.get(`/applications?status=${filter}`);
            setApplications(res.data.applications || []);
        } catch (error) {
            console.error('Error fetching applications:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleReview = async (id: string, status: 'approved' | 'rejected') => {
        if (status === 'rejected' && !rejectReason) {
            toast.error('Укажите причину отказа');
            return;
        }

        try {
            await api.put(`/applications/${id}/review`, { 
                status, 
                rejectReason: status === 'rejected' ? rejectReason : null 
            });
            toast.success(status === 'approved' ? 'Заявка одобрена' : 'Заявка отклонена');
            setSelectedApp(null);
            setRejectReason('');
            fetchApplications();
        } catch (error) {
            toast.error('Ошибка при рассмотрении заявки');
        }
    };

    const getStatusBadge = (status: string) => {
        switch (status) {
            case 'approved':
                return <Badge className="bg-green-500">Одобрена</Badge>;
            case 'rejected':
                return <Badge className="bg-red-500">Отклонена</Badge>;
            default:
                return <Badge className="bg-yellow-500">На рассмотрении</Badge>;
        }
    };

    return (
        <div className="p-6 space-y-6">
            <div className="flex items-center gap-3">
                <FileText className="h-8 w-8" />
                <div>
                    <h1 className="text-2xl font-bold">Заявки на доступ</h1>
                    <p className="text-muted-foreground">Рассмотрение заявок пользователей</p>
                </div>
            </div>

            <div className="flex gap-2">
                {['pending', 'approved', 'rejected'].map((status) => (
                    <Button
                        key={status}
                        variant={filter === status ? 'default' : 'outline'}
                        onClick={() => setFilter(status)}
                    >
                        {status === 'pending' && 'На рассмотрении'}
                        {status === 'approved' && 'Одобренные'}
                        {status === 'rejected' && 'Отклоненные'}
                    </Button>
                ))}
            </div>

            {loading ? (
                <div>Загрузка...</div>
            ) : applications.length === 0 ? (
                <div className="text-muted-foreground text-center py-8">Нет заявок</div>
            ) : (
                <div className="grid gap-4">
                    {applications.map((app) => (
                        <Card 
                            key={app.id} 
                            className="cursor-pointer hover:bg-accent/50"
                            onClick={() => setSelectedApp(app)}
                        >
                            <CardContent className="p-4">
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-3">
                                        <User className="h-8 w-8" />
                                        <div>
                                            <p className="font-medium">{app.user.username}</p>
                                            <p className="text-sm text-muted-foreground">{app.user.email}</p>
                                        </div>
                                    </div>
                                    <div className="flex items-center gap-3">
                                        <span className="text-sm text-muted-foreground">
                                            {new Date(app.createdAt).toLocaleDateString()}
                                        </span>
                                        {getStatusBadge(app.status)}
                                    </div>
                                </div>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            )}

            {selectedApp && (
                <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
                    <Card className="w-full max-w-2xl max-h-[90vh] overflow-y-auto">
                        <CardHeader>
                            <CardTitle>Заявка от {selectedApp.user.username}</CardTitle>
                            <CardDescription>
                                Подана {new Date(selectedApp.createdAt).toLocaleString()}
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <div className="grid grid-cols-2 gap-4">
                                <div>
                                    <Label className="text-muted-foreground">Discord</Label>
                                    <p>{selectedApp.discordName || 'Не указан'} ({selectedApp.discordId || 'N/A'})</p>
                                </div>
                                <div>
                                    <Label className="text-muted-foreground">Roblox</Label>
                                    <p>{selectedApp.robloxUsername || 'Не указан'}</p>
                                </div>
                                <div>
                                    <Label className="text-muted-foreground">Возраст</Label>
                                    <p>{selectedApp.age || 'Не указан'}</p>
                                </div>
                                <div>
                                    <Label className="text-muted-foreground">Email</Label>
                                    <p>{selectedApp.user.email}</p>
                                </div>
                            </div>

                            <div>
                                <Label className="text-muted-foreground">Почему хочет присоединиться</Label>
                                <p className="mt-1 p-3 bg-muted rounded">{selectedApp.whyJoin}</p>
                            </div>

                            {selectedApp.experience && (
                                <div>
                                    <Label className="text-muted-foreground">Опыт</Label>
                                    <p className="mt-1 p-3 bg-muted rounded">{selectedApp.experience}</p>
                                </div>
                            )}

                            {filter === 'pending' && (
                                <div className="space-y-3 pt-4 border-t">
                                    <div>
                                        <Label>Причина отказа (если отклоняете)</Label>
                                        <Textarea 
                                            value={rejectReason}
                                            onChange={(e) => setRejectReason(e.target.value)}
                                            placeholder="Укажите причину отказа..."
                                            rows={2}
                                        />
                                    </div>
                                    <div className="flex gap-2">
                                        <Button 
                                            variant="destructive" 
                                            className="flex-1"
                                            onClick={() => handleReview(selectedApp.id, 'rejected')}
                                        >
                                            <X className="h-4 w-4 mr-2" />
                                            Отклонить
                                        </Button>
                                        <Button 
                                            className="flex-1"
                                            onClick={() => handleReview(selectedApp.id, 'approved')}
                                        >
                                            <Check className="h-4 w-4 mr-2" />
                                            Одобрить
                                        </Button>
                                    </div>
                                </div>
                            )}
                        </CardContent>
                    </Card>
                </div>
            )}
        </div>
    );
}
