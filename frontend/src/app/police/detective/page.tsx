'use client';

import { useEffect, useState, useCallback } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Textarea } from '@/components/ui/textarea';
import { toast } from 'sonner';
import { useLanguage } from '@/hooks/useLanguage';
import api from '@/lib/api/axios';
import { useUser } from '@/hooks/getUseMangr';
import { 
    Search, 
    Plus, 
    FileText, 
    User, 
    Users,
    Camera,
    FolderOpen,
    Clock,
    AlertTriangle,
    CheckCircle,
    XCircle,
    Eye,
    Edit,
    Trash2,
    Image,
    Paperclip,
    MessageSquare,
    Briefcase,
    ArrowLeft,
    Save
} from 'lucide-react';

const getUploadUrl = (path: string | null | undefined): string | undefined => {
  if (!path) return undefined;
  let baseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
  baseUrl = baseUrl.replace('/api', '');
  return path.startsWith('http') ? path : `${baseUrl}${path}`;
};

interface Case {
    id: string;
    caseNumber: string;
    title: string;
    description?: string;
    status: string;
    priority: string;
    type: string;
    departmentId: string;
    department?: {
        id: string;
        name: string;
        shortCode: string;
        color: string;
    };
    createdById: string;
    createdBy?: {
        id: string;
        username: string;
    };
    assignedToId?: string;
    assignedTo?: {
        id: string;
        username: string;
    };
    createdAt: string;
    updatedAt: string;
    solvedAt?: string;
    closedAt?: string;
    _count?: {
        suspects: number;
        witnesses: number;
        victims: number;
        evidence: number;
        photos: number;
        events: number;
    };
}

interface CaseDetail extends Case {
    suspects: any[];
    witnesses: any[];
    victims: any[];
    evidence: any[];
    photos: any[];
    events: any[];
    characters: any[];
}

const caseTypes = [
    { value: 'general', label: 'Общее' },
    { value: 'homicide', label: 'Убийство' },
    { value: 'robbery', label: 'Ограбление' },
    { value: 'kidnapping', label: 'Похищение' },
    { value: 'missing_person', label: 'Пропавший человек' },
    { value: 'fraud', label: 'Мошенничество' },
    { value: 'other', label: 'Другое' },
];

const casePriorities = [
    { value: 'low', label: 'Низкий', color: 'bg-green-500' },
    { value: 'medium', label: 'Средний', color: 'bg-yellow-500' },
    { value: 'high', label: 'Высокий', color: 'bg-orange-500' },
    { value: 'critical', label: 'Критический', color: 'bg-red-500' },
];

const caseStatuses = [
    { value: 'open', label: 'Открыто', color: 'bg-blue-500' },
    { value: 'in_progress', label: 'В работе', color: 'bg-yellow-500' },
    { value: 'solved', label: 'Раскрыто', color: 'bg-green-500' },
    { value: 'closed', label: 'Закрыто', color: 'bg-gray-500' },
    { value: 'archived', label: 'В архиве', color: 'bg-purple-500' },
];

export default function DetectivePage() {
    const { user } = useUser();
    const { t } = useLanguage();
    const [cases, setCases] = useState<Case[]>([]);
    const [selectedCase, setSelectedCase] = useState<CaseDetail | null>(null);
    const [loading, setLoading] = useState(true);
    const [searchQuery, setSearchQuery] = useState('');
    const [statusFilter, setStatusFilter] = useState('all');
    const [showCreateDialog, setShowCreateDialog] = useState(false);
    const [showCaseDetailDialog, setShowCaseDetailDialog] = useState(false);
    const [showAddPhotoDialog, setShowAddPhotoDialog] = useState(false);
    const [showAddEvidenceDialog, setShowAddEvidenceDialog] = useState(false);
    const [showAddEventDialog, setShowAddEventDialog] = useState(false);
    const [showAddCharacterDialog, setShowAddCharacterDialog] = useState(false);
    const [photoUrl, setPhotoUrl] = useState('');
    const [photoFile, setPhotoFile] = useState<File | null>(null);
    const [photoDescription, setPhotoDescription] = useState('');
    const [photoType, setPhotoType] = useState('general');
    const [evidenceName, setEvidenceName] = useState('');
    const [evidenceDescription, setEvidenceDescription] = useState('');
    const [evidenceType, setEvidenceType] = useState('other');
    const [evidenceLocation, setEvidenceLocation] = useState('');
    const [eventTitle, setEventTitle] = useState('');
    const [eventDescription, setEventDescription] = useState('');
    const [eventType, setEventType] = useState('note');
    const [newCharacterFirstName, setNewCharacterFirstName] = useState('');
    const [newCharacterLastName, setNewCharacterLastName] = useState('');
    const [newCharacterRole, setNewCharacterRole] = useState<'suspect' | 'witness' | 'victim'>('suspect');
    const [newCase, setNewCase] = useState({
        title: '',
        description: '',
        type: 'general',
        priority: 'medium',
        departmentId: ''
    });

    const fetchCases = useCallback(async () => {
        try {
            const params = new URLSearchParams();
            if (searchQuery) params.append('search', searchQuery);
            if (statusFilter !== 'all') params.append('status', statusFilter);
            
            const response = await api.get(`/detective/cases?${params}`);
            setCases(response.data);
        } catch (error) {
            console.error('Error fetching cases:', error);
            toast.error('Ошибка при загрузке дел');
        } finally {
            setLoading(false);
        }
    }, [searchQuery, statusFilter]);

    const fetchCaseDetail = async (caseId: string) => {
        try {
            const response = await api.get(`/detective/cases/${caseId}`);
            setSelectedCase(response.data);
        } catch (error) {
            console.error('Error fetching case detail:', error);
            toast.error('Ошибка при загрузке дела');
        }
    };

    useEffect(() => {
        fetchCases();
    }, [fetchCases]);

    const handleCreateCase = async () => {
        if (!newCase.title || !newCase.departmentId) {
            toast.error('Заполните обязательные поля');
            return;
        }

        try {
            await api.post('/detective/cases', newCase);
            toast.success('Дело создано');
            setShowCreateDialog(false);
            setNewCase({ title: '', description: '', type: 'general', priority: 'medium', departmentId: '' });
            fetchCases();
        } catch (error) {
            console.error('Error creating case:', error);
            toast.error('Ошибка при создании дела');
        }
    };

    const handleUpdateCaseStatus = async (caseId: string, status: string) => {
        try {
            await api.put(`/detective/cases/${caseId}`, { status });
            toast.success('Статус обновлён');
            fetchCases();
            if (selectedCase) fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error updating case status:', error);
            toast.error('Ошибка при обновлении статуса');
        }
    };

    const handleAddPhoto = async () => {
        if (!selectedCase) return;

        let url = photoUrl;

        if (photoFile) {
            const formData = new FormData();
            formData.append('file', photoFile);
            
            try {
                const uploadRes = await api.post('/upload?type=detective', formData, {
                    headers: { 'Content-Type': 'multipart/form-data' }
                });
                url = uploadRes.data.url;
            } catch (error) {
                console.error('Error uploading file:', error);
                toast.error('Ошибка при загрузке файла');
                return;
            }
        }

        if (!url) {
            toast.error('Выберите файл или введите URL');
            return;
        }

        try {
            await api.post(`/detective/cases/${selectedCase.id}/photos`, {
                url,
                description: photoDescription,
                type: photoType
            });
            toast.success('Фото добавлено');
            setShowAddPhotoDialog(false);
            setPhotoUrl('');
            setPhotoFile(null);
            setPhotoDescription('');
            fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error adding photo:', error);
            toast.error('Ошибка при добавлении фото');
        }
    };

    const handleAddEvidence = async () => {
        if (!selectedCase || !evidenceName) return;

        try {
            await api.post(`/detective/cases/${selectedCase.id}/evidence`, {
                name: evidenceName,
                description: evidenceDescription,
                type: evidenceType,
                location: evidenceLocation
            });
            toast.success('Доказательство добавлено');
            setShowAddEvidenceDialog(false);
            setEvidenceName('');
            setEvidenceDescription('');
            setEvidenceLocation('');
            fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error adding evidence:', error);
            toast.error('Ошибка при добавлении доказательства');
        }
    };

    const handleAddEvent = async () => {
        if (!selectedCase || !eventTitle) return;

        try {
            await api.post(`/detective/cases/${selectedCase.id}/events`, {
                title: eventTitle,
                description: eventDescription,
                type: eventType
            });
            toast.success('Событие добавлено');
            setShowAddEventDialog(false);
            setEventTitle('');
            setEventDescription('');
            fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error adding event:', error);
            toast.error('Ошибка при добавлении события');
        }
    };

    const handleAddCharacter = async () => {
        if (!selectedCase || !newCharacterFirstName || !newCharacterLastName) {
            toast.error('Заполните имя и фамилию');
            return;
        }
        
        try {
            await api.post(`/detective/cases/${selectedCase.id}/characters`, {
                firstName: newCharacterFirstName,
                lastName: newCharacterLastName,
                role: newCharacterRole
            });
            
            toast.success('Персонаж добавлен');
            setShowAddCharacterDialog(false);
            setNewCharacterFirstName('');
            setNewCharacterLastName('');
            fetchCaseDetail(selectedCase.id);
        } catch (error: any) {
            console.error('Error adding character:', error);
            toast.error(error?.response?.data?.error || error?.response?.data?.details || 'Ошибка при добавлении персонажа');
        }
    };

    const handleDeletePhoto = async (photoId: string) => {
        if (!selectedCase) return;
        
        try {
            await api.delete(`/detective/cases/${selectedCase.id}/photos/${photoId}`);
            toast.success('Фото удалено');
            fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error deleting photo:', error);
            toast.error('Ошибка при удалении фото');
        }
    };

    const handleDeleteEvidence = async (evidenceId: string) => {
        if (!selectedCase) return;
        
        try {
            await api.delete(`/detective/cases/${selectedCase.id}/evidence/${evidenceId}`);
            toast.success('Доказательство удалено');
            fetchCaseDetail(selectedCase.id);
        } catch (error) {
            console.error('Error deleting evidence:', error);
            toast.error('Ошибка при удалении доказательства');
        }
    };

    const openCaseDetail = async (caseItem: Case) => {
        await fetchCaseDetail(caseItem.id);
        setShowCaseDetailDialog(true);
    };

    const getPriorityColor = (priority: string) => {
        const p = casePriorities.find(p => p.value === priority);
        return p?.color || 'bg-gray-500';
    };

    const getStatusColor = (status: string) => {
        const s = caseStatuses.find(s => s.value === status);
        return s?.color || 'bg-gray-500';
    };

    const getStatusLabel = (status: string) => {
        const s = caseStatuses.find(s => s.value === status);
        return s?.label || status;
    };

    const getTypeLabel = (type: string) => {
        const t = caseTypes.find(t => t.value === type);
        return t?.label || type;
    };

    const getCharacterName = (char: any) => {
        return char.character ? `${char.character.firstName} ${char.character.lastName}` : 'Unknown';
    };

    return (
        <div className="min-h-screen bg-[#0a0a0a] text-[#e6e6e6]">
            <div className="container mx-auto px-4 py-6">
                <div className="flex items-center justify-between mb-6">
                    <div>
                        <h1 className="text-2xl font-bold flex items-center gap-3">
                            <Briefcase className="h-7 w-7 text-purple-500" />
                            Детективное управление
                        </h1>
                        <p className="text-[#808080] text-sm mt-1">Хранение и управление делами</p>
                    </div>
                    <Button 
                        onClick={() => setShowCreateDialog(true)}
                        className="bg-purple-600 hover:bg-purple-700"
                    >
                        <Plus className="h-4 w-4 mr-2" />
                        Новое дело
                    </Button>
                </div>

                <div className="flex gap-4 mb-6">
                    <div className="flex-1 relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-[#808080]" />
                        <Input
                            placeholder="Поиск по делам..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="pl-10 bg-[#111111] border border-white/10 text-[#e6e6e6]"
                        />
                    </div>
                    <Select value={statusFilter} onValueChange={setStatusFilter}>
                        <SelectTrigger className="w-48 bg-[#111111] border border-white/10">
                            <SelectValue placeholder="Статус" />
                        </SelectTrigger>
                        <SelectContent className="bg-[#111111] border border-white/10">
                            <SelectItem value="all">Все статусы</SelectItem>
                            {caseStatuses.map(status => (
                                <SelectItem key={status.value} value={status.value}>
                                    <div className="flex items-center gap-2">
                                        <div className={`w-2 h-2 rounded-full ${status.color}`} />
                                        {status.label}
                                    </div>
                                </SelectItem>
                            ))}
                        </SelectContent>
                    </Select>
                </div>

                <div className="grid gap-4">
                    {loading ? (
                        <div className="text-center py-10 text-[#808080]">Загрузка...</div>
                    ) : cases.length === 0 ? (
                        <div className="text-center py-10 text-[#808080]">
                            <FolderOpen className="h-12 w-12 mx-auto mb-3 opacity-50" />
                            <p>Нет дел</p>
                        </div>
                    ) : (
                        cases.map((caseItem) => (
                            <Card 
                                key={caseItem.id} 
                                className="bg-[#111111] border border-white/10 cursor-pointer hover:border-purple-500/50 transition-colors"
                                onClick={() => openCaseDetail(caseItem)}
                            >
                                <CardContent className="p-4">
                                    <div className="flex items-start justify-between">
                                        <div className="flex-1">
                                            <div className="flex items-center gap-3 mb-2">
                                                <span className="font-mono text-xs text-[#808080]">{caseItem.caseNumber}</span>
                                                <div className={`w-2 h-2 rounded-full ${getPriorityColor(caseItem.priority)}`} />
                                                <Badge className={getStatusColor(caseItem.status)}>
                                                    {getStatusLabel(caseItem.status)}
                                                </Badge>
                                                <Badge variant="outline" className="text-xs">
                                                    {getTypeLabel(caseItem.type)}
                                                </Badge>
                                            </div>
                                            <h3 className="font-semibold text-lg">{caseItem.title}</h3>
                                            {caseItem.description && (
                                                <p className="text-[#808080] text-sm mt-1 line-clamp-2">
                                                    {caseItem.description}
                                                </p>
                                            )}
                                        </div>
                                        <div className="flex items-center gap-4 text-sm text-[#808080]">
                                            {caseItem._count && (
                                                <div className="flex gap-3">
                                                    <span className="flex items-center gap-1">
                                                        <User className="h-3 w-3" />
                                                        {caseItem._count.suspects}
                                                    </span>
                                                    <span className="flex items-center gap-1">
                                                        <Image className="h-3 w-3" />
                                                        {caseItem._count.photos}
                                                    </span>
                                                    <span className="flex items-center gap-1">
                                                        <Paperclip className="h-3 w-3" />
                                                        {caseItem._count.evidence}
                                                    </span>
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                </CardContent>
                            </Card>
                        ))
                    )}
                </div>
            </div>

            <Dialog open={showCreateDialog} onOpenChange={setShowCreateDialog}>
                <DialogContent className="max-w-4xl">
                    <DialogHeader>
                        <DialogTitle>Создать новое дело</DialogTitle>
                        <DialogDescription>
                            Заполните информацию о новом деле
                        </DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label>НАЗВАНИЕ *</Label>
                            <Input
                                value={newCase.title}
                                onChange={(e) => setNewCase({...newCase, title: e.target.value})}
                                placeholder="Название дела"
                            />
                        </div>
                        <div>
                            <Label>ОПИСАНИЕ</Label>
                            <Textarea
                                value={newCase.description}
                                onChange={(e) => setNewCase({...newCase, description: e.target.value})}
                                placeholder="Описание дела"
                                className="min-h-[80px]"
                            />
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <Label>ТИП</Label>
                                <Select 
                                    value={newCase.type} 
                                    onValueChange={(v) => setNewCase({...newCase, type: v})}
                                >
                                    <SelectTrigger>
                                        <SelectValue />
                                    </SelectTrigger>
                                    <SelectContent>
                                        {caseTypes.map(type => (
                                            <SelectItem key={type.value} value={type.value}>
                                                {type.label}
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            <div>
                                <Label>ПРИОРИТЕТ</Label>
                                <Select 
                                    value={newCase.priority} 
                                    onValueChange={(v) => setNewCase({...newCase, priority: v})}
                                >
                                    <SelectTrigger>
                                        <SelectValue />
                                    </SelectTrigger>
                                    <SelectContent>
                                        {casePriorities.map(p => (
                                            <SelectItem key={p.value} value={p.value}>
                                                <div className="flex items-center gap-2">
                                                    <div className={`w-2 h-2 rounded-full ${p.color}`} />
                                                    {p.label}
                                                </div>
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                        </div>
                        <div>
                            <Label>ДЕПАРТАМЕНТ *</Label>
                            <Select 
                                value={newCase.departmentId} 
                                onValueChange={(v) => setNewCase({...newCase, departmentId: v})}
                            >
                                <SelectTrigger>
                                    <SelectValue placeholder="Выберите департамент" />
                                </SelectTrigger>
                                <SelectContent>
                                    {user?.department && (
                                        <SelectItem value={user.department.id}>
                                            {user.department.name}
                                        </SelectItem>
                                    )}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter className="mt-2">
                        <Button variant="outline" onClick={() => setShowCreateDialog(false)}>
                            Отмена
                        </Button>
                        <Button onClick={handleCreateCase}>
                            <Plus className="h-4 w-4 mr-2" />
                            Создать дело
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showCaseDetailDialog} onOpenChange={setShowCaseDetailDialog}>
                <DialogContent className="bg-card border-border text-card-foreground w-[70vw] h-[98vh] max-w-none overflow-hidden flex flex-col">
                    <DialogHeader>
                        <div className="flex items-center gap-3">
                            <Button 
                                variant="ghost" 
                                size="icon"
                                onClick={() => setShowCaseDetailDialog(false)}
                            >
                                <ArrowLeft className="h-4 w-4" />
                            </Button>
                            <div>
                                <DialogTitle className="font-mono text-lg">
                                    {selectedCase?.caseNumber}
                                </DialogTitle>
                                <DialogDescription>
                                    {selectedCase?.title}
                                </DialogDescription>
                            </div>
                        </div>
                    </DialogHeader>
                    
                    {selectedCase && (
                        <div className="flex-1 overflow-y-auto space-y-6 py-4 custom-scrollbar">
                            <div className="flex items-center gap-4">
                                <Select 
                                    value={selectedCase.status} 
                                    onValueChange={(v) => handleUpdateCaseStatus(selectedCase.id, v)}
                                >
                                    <SelectTrigger className="w-44">
                                        <SelectValue />
                                    </SelectTrigger>
                                    <SelectContent>
                                        {caseStatuses.map(status => (
                                            <SelectItem key={status.value} value={status.value}>
                                                <div className="flex items-center gap-2">
                                                    <div className={`w-2 h-2 rounded-full ${status.color}`} />
                                                    {status.label}
                                                </div>
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                                <Badge className={getPriorityColor(selectedCase.priority)}>
                                    {casePriorities.find(p => p.value === selectedCase.priority)?.label}
                                </Badge>
                                <Badge variant="outline">
                                    {getTypeLabel(selectedCase.type)}
                                </Badge>
                            </div>

                            {selectedCase.description && (
                                <div className="p-4 rounded-lg border">
                                    <h4 className="text-xs font-medium mb-2 flex items-center gap-2">
                                        <FileText className="h-3 w-3" />
                                        ОПИСАНИЕ
                                    </h4>
                                    <p>{selectedCase.description}</p>
                                </div>
                            )}

                            <div className="grid grid-cols-3 gap-4">
                                <Card>
                                    <CardHeader className="pb-2">
                                        <CardTitle className="text-sm flex items-center gap-2">
                                            <User className="h-4 w-4" />
                                            ПОДОЗРЕВАЕМЫЕ
                                        </CardTitle>
                                    </CardHeader>
                                    <CardContent>
                                        <div className="flex items-center justify-between">
                                            <span className="text-3xl font-bold">{selectedCase.suspects?.length || 0}</span>
                                        </div>
                                    </CardContent>
                                </Card>
                                <Card>
                                    <CardHeader className="pb-2">
                                        <CardTitle className="text-sm">СВИДЕТЕЛИ</CardTitle>
                                    </CardHeader>
                                    <CardContent>
                                        <div className="flex items-center justify-between">
                                            <span className="text-2xl font-bold">{selectedCase.witnesses?.length || 0}</span>
                                        </div>
                                    </CardContent>
                                </Card>
                                <Card>
                                    <CardHeader className="pb-2">
                                        <CardTitle className="text-sm">ЖЕРТВЫ</CardTitle>
                                    </CardHeader>
                                    <CardContent>
                                        <div className="flex items-center justify-between">
                                            <span className="text-2xl font-bold">{selectedCase.victims?.length || 0}</span>
                                        </div>
                                    </CardContent>
                                </Card>
                            </div>

                            <div className="flex justify-center">
                                <Button 
                                    variant="outline"
                                    onClick={() => {
                                        setNewCharacterRole('suspect');
                                        setShowAddCharacterDialog(true);
                                    }}
                                >
                                    <Plus className="h-4 w-4 mr-2" />
                                    Добавить персонажа
                                </Button>
                            </div>

                            <Separator />

                            <div>
                                <div className="flex items-center justify-between mb-4">
                                    <h3 className="font-semibold flex items-center gap-2">
                                        <Camera className="h-4 w-4" />
                                        Фотографии
                                    </h3>
                                    <Button 
                                        variant="outline" 
                                        size="sm"
                                        onClick={() => setShowAddPhotoDialog(true)}
                                    >
                                        <Plus className="h-4 w-4 mr-1" />
                                        Добавить
                                    </Button>
                                </div>
                                <div className="grid grid-cols-4 gap-3">
                                    {selectedCase.photos?.map((photo: any) => (
                                        <div key={photo.id} className="relative group">
                                            <div className="aspect-video rounded-lg border overflow-hidden">
                                                <img 
                                                    src={getUploadUrl(photo.url)} 
                                                    alt={photo.description || 'Фото'}
                                                    className="w-full h-full object-cover"
                                                    crossOrigin="anonymous"
                                                    onError={(e) => {
                                                        console.log('Image load error for:', photo.url);
                                                        (e.target as HTMLImageElement).src = 'https://placehold.co/400x300?text=No+Image';
                                                    }}
                                                />
                                            </div>
                                            <Button
                                                variant="destructive"
                                                size="icon"
                                                className="absolute top-1 right-1 h-6 w-6 opacity-0 group-hover:opacity-100 transition-opacity"
                                                onClick={() => handleDeletePhoto(photo.id)}
                                            >
                                                <Trash2 className="h-3 w-3" />
                                            </Button>
                                        </div>
                                    ))}
                                    {(!selectedCase.photos || selectedCase.photos.length === 0) && (
                                        <div className="col-span-4 text-center py-8 text-muted-foreground">
                                            <Image className="h-8 w-8 mx-auto mb-2 opacity-50" />
                                            <p>Нет фотографий</p>
                                        </div>
                                    )}
                                </div>
                            </div>

                            <Separator />

                            <div>
                                <div className="flex items-center justify-between mb-4">
                                    <h3 className="font-semibold flex items-center gap-2">
                                        <Paperclip className="h-4 w-4" />
                                        Доказательства
                                    </h3>
                                    <Button 
                                        variant="outline" 
                                        size="sm"
                                        onClick={() => setShowAddEvidenceDialog(true)}
                                    >
                                        <Plus className="h-4 w-4 mr-1" />
                                        Добавить
                                    </Button>
                                </div>
                                <div className="space-y-2">
                                    {selectedCase.evidence?.map((ev: any) => (
                                        <div key={ev.id} className="flex items-center justify-between p-3 rounded-lg border">
                                            <div className="flex items-center gap-3">
                                                <div className="w-10 h-10 rounded-lg flex items-center justify-center">
                                                    <Paperclip className="h-5 w-5" />
                                                </div>
                                                <div>
                                                    <p className="font-medium">{ev.name}</p>
                                                    <p className="text-xs text-muted-foreground">{ev.type} {ev.location && `• ${ev.location}`}</p>
                                                </div>
                                            </div>
                                            <Button
                                                variant="ghost"
                                                size="icon"
                                                onClick={() => handleDeleteEvidence(ev.id)}
                                            >
                                                <Trash2 className="h-4 w-4" />
                                            </Button>
                                        </div>
                                    ))}
                                    {(!selectedCase.evidence || selectedCase.evidence.length === 0) && (
                                        <div className="text-center py-8 text-muted-foreground">
                                            <p>Нет доказательств</p>
                                        </div>
                                    )}
                                </div>
                            </div>

                            <Separator />

                            <div>
                                <div className="flex items-center justify-between mb-4">
                                    <h3 className="font-semibold flex items-center gap-2">
                                        <MessageSquare className="h-4 w-4" />
                                        Хронология
                                    </h3>
                                    <Button 
                                        variant="outline" 
                                        size="sm"
                                        onClick={() => setShowAddEventDialog(true)}
                                    >
                                        <Plus className="h-4 w-4 mr-1" />
                                        Добавить
                                    </Button>
                                </div>
                                <div className="space-y-3">
                                    {selectedCase.events?.map((event: any) => (
                                        <div key={event.id} className="p-3 rounded-lg border">
                                            <div className="flex items-center gap-2 mb-1">
                                                <Badge variant="outline" className="text-xs">{event.type}</Badge>
                                                <span className="font-medium">{event.title}</span>
                                            </div>
                                            {event.description && (
                                                <p className="text-sm text-muted-foreground">{event.description}</p>
                                            )}
                                            <p className="text-xs text-muted-foreground mt-2">
                                                {event.authorName} • {new Date(event.createdAt).toLocaleString('ru-RU')}
                                            </p>
                                        </div>
                                    ))}
                                    {(!selectedCase.events || selectedCase.events.length === 0) && (
                                        <div className="text-center py-8 text-muted-foreground">
                                            <p>Нет событий</p>
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    )}
                </DialogContent>
            </Dialog>

            <Dialog open={showAddPhotoDialog} onOpenChange={setShowAddPhotoDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Добавить фото</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label>ФАЙЛ</Label>
                            <Input
                                type="file"
                                accept="image/*"
                                onChange={(e) => {
                                    const file = e.target.files?.[0];
                                    if (file) setPhotoFile(file);
                                }}
                                className="cursor-pointer"
                            />
                        </div>
                        <div className="text-center text-sm text-muted-foreground">или</div>
                        <div>
                            <Label>URL</Label>
                            <Input
                                value={photoUrl}
                                onChange={(e) => setPhotoUrl(e.target.value)}
                                placeholder="https://..."
                            />
                        </div>
                        <div>
                            <Label>ОПИСАНИЕ</Label>
                            <Input
                                value={photoDescription}
                                onChange={(e) => setPhotoDescription(e.target.value)}
                                placeholder="Описание фото"
                            />
                        </div>
                        <div>
                            <Label>ТИП</Label>
                            <Select value={photoType} onValueChange={setPhotoType}>
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="general">Общее</SelectItem>
                                    <SelectItem value="crime_scene">Место преступления</SelectItem>
                                    <SelectItem value="evidence">Доказательство</SelectItem>
                                    <SelectItem value="document">Документ</SelectItem>
                                    <SelectItem value="person">Человек</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowAddPhotoDialog(false)}>Отмена</Button>
                        <Button onClick={handleAddPhoto}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showAddEvidenceDialog} onOpenChange={setShowAddEvidenceDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Добавить доказательство</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label>НАЗВАНИЕ *</Label>
                            <Input
                                value={evidenceName}
                                onChange={(e) => setEvidenceName(e.target.value)}
                                placeholder="Название доказательства"
                            />
                        </div>
                        <div>
                            <Label>ОПИСАНИЕ</Label>
                            <Textarea
                                value={evidenceDescription}
                                onChange={(e) => setEvidenceDescription(e.target.value)}
                                placeholder="Описание"
                            />
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <Label>ТИП</Label>
                                <Select value={evidenceType} onValueChange={setEvidenceType}>
                                    <SelectTrigger>
                                        <SelectValue />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="physical">Физическое</SelectItem>
                                        <SelectItem value="document">Документ</SelectItem>
                                        <SelectItem value="digital">Цифровое</SelectItem>
                                        <SelectItem value="photo">Фото</SelectItem>
                                        <SelectItem value="other">Другое</SelectItem>
                                    </SelectContent>
                                </Select>
                            </div>
                            <div>
                                <Label>МЕСТОНАХОЖДЕНИЕ</Label>
                                <Input
                                    value={evidenceLocation}
                                    onChange={(e) => setEvidenceLocation(e.target.value)}
                                    placeholder="Где найдено"
                                />
                            </div>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowAddEvidenceDialog(false)}>Отмена</Button>
                        <Button onClick={handleAddEvidence}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showAddEventDialog} onOpenChange={setShowAddEventDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Добавить событие</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label>ТИП</Label>
                            <Select value={eventType} onValueChange={setEventType}>
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="note">Заметка</SelectItem>
                                    <SelectItem value="action">Действие</SelectItem>
                                    <SelectItem value="interview">Допрос</SelectItem>
                                    <SelectItem value="evidence">Доказательство</SelectItem>
                                    <SelectItem value="photo">Фото</SelectItem>
                                    <SelectItem value="other">Другое</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                        <div>
                            <Label>ЗАГОЛОВОК *</Label>
                            <Input
                                value={eventTitle}
                                onChange={(e) => setEventTitle(e.target.value)}
                                placeholder="Заголовок события"
                            />
                        </div>
                        <div>
                            <Label>ОПИСАНИЕ</Label>
                            <Textarea
                                value={eventDescription}
                                onChange={(e) => setEventDescription(e.target.value)}
                                placeholder="Описание"
                            />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowAddEventDialog(false)}>Отмена</Button>
                        <Button onClick={handleAddEvent}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showAddCharacterDialog} onOpenChange={setShowAddCharacterDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle>Добавить персонажа к делу</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <Label>ИМЯ</Label>
                                <Input
                                    value={newCharacterFirstName}
                                    onChange={(e) => setNewCharacterFirstName(e.target.value)}
                                    placeholder="Имя"
                                />
                            </div>
                            <div>
                                <Label>ФАМИЛИЯ</Label>
                                <Input
                                    value={newCharacterLastName}
                                    onChange={(e) => setNewCharacterLastName(e.target.value)}
                                    placeholder="Фамилия"
                                />
                            </div>
                        </div>
                        <div>
                            <Label>РОЛЬ</Label>
                            <Select value={newCharacterRole} onValueChange={(v: 'suspect' | 'witness' | 'victim') => setNewCharacterRole(v)}>
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="suspect">Подозреваемый</SelectItem>
                                    <SelectItem value="witness">Свидетель</SelectItem>
                                    <SelectItem value="victim">Жертва</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowAddCharacterDialog(false)}>Отмена</Button>
                        <Button onClick={handleAddCharacter}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </div>
    );
}
