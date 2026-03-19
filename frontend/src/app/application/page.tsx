'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { toast } from 'sonner';
import api from '@/lib/api/axios';
import { FileText, Send, CheckCircle, XCircle, Clock } from 'lucide-react';

export default function ApplicationPage() {
    const router = useRouter();
    const [loading, setLoading] = useState(true);
    const [submitting, setSubmitting] = useState(false);
    const [existingApp, setExistingApp] = useState<any>(null);
    const [formData, setFormData] = useState({
        discordId: '',
        discordName: '',
        robloxUsername: '',
        age: '',
        whyJoin: '',
        experience: ''
    });

    useEffect(() => {
        checkApplication();
    }, []);

    const checkApplication = async () => {
        try {
            const res = await api.get('/applications/my');
            setExistingApp(res.data.application);
        } catch (error) {
            console.error('Error checking application:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleSubmit = async () => {
        if (!formData.whyJoin) {
            toast.error('Заполните поле "Почему вы хотите присоединиться"');
            return;
        }

        setSubmitting(true);
        try {
            await api.post('/applications', formData);
            toast.success('Заявка отправлена!');
            checkApplication();
        } catch (error: any) {
            toast.error(error.response?.data?.error || 'Ошибка отправки заявки');
        } finally {
            setSubmitting(false);
        }
    };

    if (loading) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a]">
                <div className="text-white">Загрузка...</div>
            </div>
        );
    }

    if (existingApp) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a] p-4">
                <Card className="w-full max-w-md">
                    <CardHeader className="text-center">
                        {existingApp.status === 'approved' && (
                            <CheckCircle className="h-16 w-16 text-green-500 mx-auto mb-4" />
                        )}
                        {existingApp.status === 'rejected' && (
                            <XCircle className="h-16 w-16 text-red-500 mx-auto mb-4" />
                        )}
                        {existingApp.status === 'pending' && (
                            <Clock className="h-16 w-16 text-yellow-500 mx-auto mb-4" />
                        )}
                        <CardTitle>
                            {existingApp.status === 'approved' && 'Заявка одобрена!'}
                            {existingApp.status === 'rejected' && 'Заявка отклонена'}
                            {existingApp.status === 'pending' && 'Заявка на рассмотрении'}
                        </CardTitle>
                        <CardDescription>
                            {existingApp.status === 'approved' && 'Теперь вы можете использовать CAD'}
                            {existingApp.status === 'rejected' && existingApp.rejectReason && 
                                `Причина: ${existingApp.rejectReason}`}
                            {existingApp.status === 'pending' && 'Ожидайте решения администратора'}
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        {existingApp.status === 'approved' && (
                            <Button onClick={() => router.push('/')} className="w-full">
                                Перейти в CAD
                            </Button>
                        )}
                        {existingApp.status === 'rejected' && (
                            <div className="space-y-3">
                                <Button onClick={() => {
                                    setExistingApp(null);
                                    setFormData({
                                        discordId: existingApp.discordId || '',
                                        discordName: existingApp.discordName || '',
                                        robloxUsername: existingApp.robloxUsername || '',
                                        age: existingApp.age?.toString() || '',
                                        whyJoin: '',
                                        experience: ''
                                    });
                                }} className="w-full">
                                    Подать новую заявку
                                </Button>
                            </div>
                        )}
                    </CardContent>
                </Card>
            </div>
        );
    }

    return (
        <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a] p-4">
            <Card className="w-full max-w-lg">
                <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                        <FileText className="h-5 w-5" />
                        Заявка на доступ
                    </CardTitle>
                    <CardDescription>
                        Заполните заявку для получения доступа к CAD
                    </CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <Label>Discord ID</Label>
                            <Input 
                                value={formData.discordId}
                                onChange={(e) => setFormData({...formData, discordId: e.target.value})}
                                placeholder="123456789"
                            />
                        </div>
                        <div>
                            <Label>Discord имя</Label>
                            <Input 
                                value={formData.discordName}
                                onChange={(e) => setFormData({...formData, discordName: e.target.value})}
                                placeholder="User#1234"
                            />
                        </div>
                    </div>

                    <div>
                        <Label>Roblox имя пользователя</Label>
                        <Input 
                            value={formData.robloxUsername}
                            onChange={(e) => setFormData({...formData, robloxUsername: e.target.value})}
                            placeholder="Username"
                        />
                    </div>

                    <div>
                        <Label>Ваш возраст</Label>
                        <Select value={formData.age} onValueChange={(v) => setFormData({...formData, age: v})}>
                            <SelectTrigger>
                                <SelectValue placeholder="Выберите возраст" />
                            </SelectTrigger>
                            <SelectContent>
                                {[...Array(20)].map((_, i) => (
                                    <SelectItem key={i + 13} value={(i + 13).toString()}>
                                        {i + 13} лет
                                    </SelectItem>
                                ))}
                            </SelectContent>
                        </Select>
                    </div>

                    <div>
                        <Label>Почему вы хотите присоединиться? *</Label>
                        <Textarea 
                            value={formData.whyJoin}
                            onChange={(e) => setFormData({...formData, whyJoin: e.target.value})}
                            placeholder="Расскажите о себе и почему хотите присоединиться..."
                            rows={4}
                        />
                    </div>

                    <div>
                        <Label>Есть ли опыт на других серверах?</Label>
                        <Textarea 
                            value={formData.experience}
                            onChange={(e) => setFormData({...formData, experience: e.target.value})}
                            placeholder="Опишите ваш опыт (департаменты, роли и т.д.)"
                            rows={3}
                        />
                    </div>

                    <Button onClick={handleSubmit} disabled={submitting} className="w-full">
                        <Send className="h-4 w-4 mr-2" />
                        {submitting ? 'Отправка...' : 'Отправить заявку'}
                    </Button>
                </CardContent>
            </Card>
        </div>
    );
}
