"use client";

import { useState, useEffect } from 'react';
import { api } from '@/lib/api';
import { useAuth } from '@/hooks/useAuth';
import { toast } from 'sonner';
import { 
    Phone, 
    Users, 
    Car, 
    Building, 
    FileText,
    Search,
    Filter,
    Plus,
    Shield,
    AlertTriangle,
    DollarSign,
    XCircle,
    CheckCircle,
    Clock,
    MapPin,
    X,
    Upload,
    User,
    Star
} from 'lucide-react';

const getUploadUrl = (path: string | null | undefined): string | undefined => {
  if (!path) return undefined;
  let baseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
  baseUrl = baseUrl.replace('/api', '');
  return path.startsWith('http') ? path : `${baseUrl}${path}`;
};

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { 
    Select, 
    SelectContent, 
    SelectItem, 
    SelectTrigger, 
    SelectValue 
} from '@/components/ui/select';
import { 
    Dialog, 
    DialogContent, 
    DialogHeader, 
    DialogTitle, 
    DialogFooter,
    DialogDescription 
} from '@/components/ui/dialog';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { CivilianModal } from '@/components/CivilianModal';
import { CreateCharacterModal, CharacterFormData } from '@/components/citizen/CreateCharacterModal';
import { useLanguage } from '@/hooks/useLanguage';

interface Character {
    id: string;
    firstName: string;
    lastName: string;
    dateOfBirth?: string;
    gender?: string;
    nationality?: string;
    ethnicity?: string;
    hairColor?: string;
    eyeColor?: string;
    height?: number;
    weight?: number;
    build?: string;
    ssn?: string;
    licenseNumber?: string;
    passportNumber?: string;
    driversLicense?: boolean;
    weaponsLicense?: boolean;
    pilotLicense?: boolean;
    commercialLicense?: boolean;
    phoneNumber?: string;
    email?: string;
    address?: string;
    city?: string;
    postalCode?: string;
    occupation?: string;
    employer?: string;
    salary?: number;
    departmentRank?: string;
    bloodType?: string;
    allergies?: string;
    medicalNotes?: string;
    biography?: string;
    notes?: string;
    tags?: string[];
    isWanted: boolean;
    wantedReason?: string;
    wantedArticles?: string;
    isArrested: boolean;
    arrestReason?: string;
    isDead?: boolean;
    isMissing?: boolean;
    playTime?: number;
    money?: number;
    bankBalance?: number;
    reputation?: number;
    departmentId?: string;
    department?: {
        id: string;
        name: string;
        type: string;
        shortCode: string;
        color: string;
    };
    officers?: any[];
    mugshot?: string;
    fullBodyImage?: string;
    fines?: any[];
    warrants?: any[];
    arrests?: any[];
    vehicles?: any[];
    weapons?: any[];
    _count?: {
        fines: number;
        warrants: number;
        arrests: number;
    };
    createdAt?: string;
    lastPlayed?: string;
}

const customStyles = `
  .noise-bg {
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.03'/%3E%3C/svg%3E");
  }
`;

function calculateAge(dateOfBirth: string): number {
    const today = new Date();
    const birthDate = new Date(dateOfBirth);
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}

function generateSSN(): string {
    const area = Math.floor(Math.random() * 899) + 100;
    const group = Math.floor(Math.random() * 99);
    const serial = Math.floor(Math.random() * 9999);
    return `${area}-${group.toString().padStart(2, '0')}-${serial.toString().padStart(4, '0')}`;
}

export default function CivilianPage() {
    const { user } = useAuth();
    const { t } = useLanguage();
    const [activeTab, setActiveTab] = useState('Characters');
    const [characters, setCharacters] = useState<Character[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');
    const [showCreateModal, setShowCreateModal] = useState(false);
    const [showViewModal, setShowViewModal] = useState(false);
    const [showEditModal, setShowEditModal] = useState(false);
    const [show911Modal, setShow911Modal] = useState(false);
    const [show911Success, setShow911Success] = useState(false);
    const [showPriorityModal, setShowPriorityModal] = useState(false);
    const [showPrioritySuccess, setShowPrioritySuccess] = useState(false);
    const [priorityForm, setPriorityForm] = useState({
        title: '',
        description: '',
        type: 'request',
        priority: 'medium',
        category: '',
        location: '',
        requesterName: user?.username || '',
        requesterPhone: ''
    });
    const [showOfficerDialog, setShowOfficerDialog] = useState(false);
    const [selectedCharacter, setSelectedCharacter] = useState<Character | null>(null);
    const [isPoliceOfficer, setIsPoliceOfficer] = useState(false);
    const [leoDepartments, setLeoDepartments] = useState<any[]>([]);
    const [departmentRanks, setDepartmentRanks] = useState<any[]>([]);
    const [departmentDivisions, setDepartmentDivisions] = useState<any[]>([]);
    const [characterOfficers, setCharacterOfficers] = useState<any[]>([]);
    const [new911Call, setNew911Call] = useState({
        type: '911',
        priority: 'medium',
        location: '',
        callerName: user?.username || '',
        description: '',
        characterId: ''
    });
    const [officerData, setOfficerData] = useState({
        departmentId: '',
        divisionId: '',
        badgeNumber: '',
        officerRank: '',
        callsign: ''
    });
    const [newCharacter, setNewCharacter] = useState({
        firstName: '',
        lastName: '',
        dateOfBirth: '',
        gender: 'male',
        nationality: '',
        phone: '',
        address: '',
        ssn: '',
        occupation: 'Unemployed',
        description: '',
        isOfficer: false,
        officerDepartmentId: '',
        officerCallsign: '',
        mugshot: '',
        weaponLicense: false,
        driverLicense: false
    });

    const [vehicles, setVehicles] = useState<any[]>([]);
    const [weapons, setWeapons] = useState<any[]>([]);
    const [showCreateVehicle, setShowCreateVehicle] = useState(false);
    const [showCreateWeapon, setShowCreateWeapon] = useState(false);
    const [newVehicle, setNewVehicle] = useState({ model: '', plate: '', color: '', type: 'car', ownerCharacterId: '', ownerName: '', photo: '', features: '' });
    const [vehiclePhotoPreview, setVehiclePhotoPreview] = useState('');
    const [newWeapon, setNewWeapon] = useState({ type: '', name: '', serialNumber: '', ownerCharacterId: '', ownerName: '' });
    const [selectedVehicle, setSelectedVehicle] = useState<any>(null);
    const [selectedWeapon, setSelectedWeapon] = useState<any>(null);
    
    const navItems = [
        { key: 'Characters', label: t('Characters') }, 
        { key: 'Vehicles', label: 'Транспорт' },
        { key: 'Weapons', label: 'Оружие' }
    ];

    const handleVehiclePhotoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onloadend = () => {
            setVehiclePhotoPreview(reader.result as string);
        };
        reader.readAsDataURL(file);

        const formData = new FormData();
        formData.append('file', file);

        try {
            const res = await api.post('/upload?type=vehicle', formData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            });
            setNewVehicle(prev => ({ ...prev, photo: res.data.url }));
            toast.success('Фото загружено');
        } catch (error) {
            console.error('Error uploading photo:', error);
            toast.error('Ошибка загрузки фото');
        }
    };

    const removeVehiclePhoto = () => {
        setNewVehicle(prev => ({ ...prev, photo: '' }));
        setVehiclePhotoPreview('');
    };

    useEffect(() => {
        fetchCharacters();
        fetchLeoDepartments();
    }, []);

    useEffect(() => {
        if (activeTab === 'Vehicles') {
            fetchVehicles();
        } else if (activeTab === 'Weapons') {
            fetchWeapons();
        }
    }, [activeTab]);

    const fetchCharacters = async () => {
        try {
            const response = await api.get('/character/characters');
            setCharacters(response.data.characters || []);
        } catch (error) {
            console.error('Error fetching characters:', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchLeoDepartments = async () => {
        try {
            const response = await api.get('/departments');
            const leoDepts = response.data.departments?.filter((d: any) => d.type === 'LEO') || [];
            setLeoDepartments(leoDepts);
        } catch (error) {
            console.error('Error fetching departments:', error);
        }
    };

    const fetchVehicles = async () => {
        try {
            const response = await api.get('/leo/search/vehicles');
            setVehicles(response.data.vehicles || []);
        } catch (error) {
            console.error('Error fetching vehicles:', error);
        }
    };

    const fetchWeapons = async () => {
        try {
            const response = await api.get('/leo/search/weapons');
            setWeapons(response.data.weapons || []);
        } catch (error) {
            console.error('Error fetching weapons:', error);
        }
    };

    const handleCreateVehicle = async () => {
        if (!newVehicle.model || !newVehicle.plate) {
            toast.error('Заполните модель и госномер');
            return;
        }
        try {
            await api.post('/leo/vehicles', newVehicle);
            toast.success('Транспорт создан');
            setShowCreateVehicle(false);
            setNewVehicle({ model: '', plate: '', color: '', type: 'car', ownerCharacterId: '', ownerName: '', photo: '', features: '' });
            setVehiclePhotoPreview('');
            fetchVehicles();
        } catch (error: any) {
            toast.error(error.response?.data?.error || 'Ошибка');
        }
    };

    const handleCreateWeapon = async () => {
        if (!newWeapon.type || !newWeapon.name || !newWeapon.serialNumber) {
            toast.error('Заполните все поля');
            return;
        }
        try {
            await api.post('/leo/weapons', newWeapon);
            toast.success('Оружие создано');
            setShowCreateWeapon(false);
            setNewWeapon({ type: '', name: '', serialNumber: '', ownerCharacterId: '', ownerName: '' });
            fetchWeapons();
        } catch (error: any) {
            toast.error(error.response?.data?.error || 'Ошибка');
        }
    };

    const fetchDepartmentRanks = async (departmentId: string) => {
        try {
            const response = await api.get(`/departments/${departmentId}`);
            setDepartmentRanks(response.data.department?.ranks || []);
            setDepartmentDivisions(response.data.department?.divisions || []);
        } catch (error) {
            console.error('Error fetching ranks:', error);
        }
    };

    const fetchCharacterOfficers = async (characterId: string) => {
        try {
            const response = await api.get(`/character/characters/${characterId}`);
            setCharacterOfficers(response.data.character?.officers || []);
        } catch (error) {
            console.error('Error fetching officers:', error);
        }
    };

    const handleCreateOfficer = async () => {
        if (!selectedCharacter) return;
        if (!officerData.departmentId) {
            toast.warning('Выберите департамент');
            return;
        }
        try {
            await api.post(`/character/characters/${selectedCharacter.id}/officer`, {
                departmentId: officerData.departmentId,
                divisionId: officerData.divisionId || null,
                badgeNumber: officerData.badgeNumber,
                officerRank: officerData.officerRank,
                callsign: officerData.callsign
            });
            toast.success('Офицер создан');
            setShowOfficerDialog(false);
            fetchCharacters();
            fetchCharacterOfficers(selectedCharacter.id);
        } catch (error: any) {
            toast.error(error.response?.data?.error || 'Ошибка создания офицера');
        }
    };

    const handleUpdateOfficer = async () => {
        if (!selectedCharacter) return;
        try {
            await api.put(`/character/characters/${selectedCharacter.id}/officer`, {
                departmentId: officerData.departmentId,
                divisionId: officerData.divisionId || null,
                badgeNumber: officerData.badgeNumber,
                officerRank: officerData.officerRank,
                callsign: officerData.callsign
            });
            toast.success('Офицер обновлён');
            setShowOfficerDialog(false);
            fetchCharacters();
            fetchCharacterOfficers(selectedCharacter.id);
        } catch (error) {
            toast.error('Ошибка обновления офицера');
        }
    };

    const handleDeleteOfficer = async () => {
        if (!selectedCharacter) return;
        try {
            await api.delete(`/character/characters/${selectedCharacter.id}/officer`);
            toast.success('Офицер удалён');
            setShowOfficerDialog(false);
            fetchCharacters();
            setCharacterOfficers([]);
        } catch (error) {
            toast.error('Ошибка удаления офицера');
        }
    };

    const openOfficerDialog = (character: Character) => {
        setSelectedCharacter(character);
        fetchCharacterOfficers(character.id);
        
        if (character.officers && character.officers.length > 0) {
            const existingOfficer = character.officers[0];
            setOfficerData({
                departmentId: existingOfficer.departmentId || '',
                divisionId: existingOfficer.divisionId || '',
                badgeNumber: existingOfficer.badgeNumber || '',
                officerRank: existingOfficer.officerRank || '',
                callsign: existingOfficer.callsign || ''
            });
            if (existingOfficer.departmentId) {
                fetchDepartmentRanks(existingOfficer.departmentId);
            }
        } else if (character.departmentId) {
            fetchDepartmentRanks(character.departmentId);
            setOfficerData({
                departmentId: character.departmentId,
                divisionId: '',
                badgeNumber: '',
                officerRank: '',
                callsign: ''
            });
        } else {
            setOfficerData({ departmentId: '', divisionId: '', badgeNumber: '', officerRank: '', callsign: '' });
        }
        setShowOfficerDialog(true);
    };

    const handleCreateCharacter = async () => {
        try {
            const ssn = generateSSN();
            
            const characterData = {
                firstName: newCharacter.firstName,
                lastName: newCharacter.lastName,
                dateOfBirth: newCharacter.dateOfBirth,
                gender: newCharacter.gender,
                occupation: newCharacter.occupation,
                mugshot: newCharacter.mugshot || null,
                ssn,
                departmentId: newCharacter.isOfficer ? newCharacter.officerDepartmentId : null
            };

            await api.post('/character/characters', characterData);
            
            toast.success('Персонаж создан');
            setShowCreateModal(false);
            setNewCharacter({
                firstName: '',
                lastName: '',
                dateOfBirth: '',
                gender: 'male',
                nationality: '',
                phone: '',
                address: '',
                ssn: '',
                occupation: 'Unemployed',
                description: '',
                isOfficer: false,
                officerDepartmentId: '',
                officerCallsign: '',
                mugshot: '',
                weaponLicense: false,
                driverLicense: false
            });
            fetchCharacters();
        } catch (error) {
            toast.error('Ошибка создания персонажа');
        }
    };

    const handleCreateCharacterNew = async (data: CharacterFormData) => {
        try {
            const response = await api.post('/character/characters', {
                firstName: data.firstName,
                lastName: data.lastName,
                dateOfBirth: data.dateOfBirth,
                gender: data.gender,
                nationality: data.nationality,
                phoneNumber: data.phone,
                address: data.address,
                ssn: data.ssn,
                occupation: data.occupation,
                notes: data.description,
                mugshot: data.mugshot,
                weaponsLicense: data.weaponLicense,
                driversLicense: data.driverLicense,
                licenseNumber: data.driverLicense ? `DL-${data.ssn?.replace(/-/g, '').slice(-6) || ''}` : null
            });
            
            if (response.data.success) {
                toast.success('Персонаж успешно создан');
                fetchCharacters();
            }
        } catch (error) {
            console.error('Error creating character:', error);
            toast.error('Ошибка создания персонажа');
            throw error;
        }
    };

    const handleCreate911Call = async () => {
        try {
            await api.post('/character/emergency-calls', {
                ...new911Call,
                createdByName: user?.username
            });
            
            setShow911Success(true);
            setTimeout(() => {
                setShow911Modal(false);
                setShow911Success(false);
                setNew911Call({
                    type: '911',
                    priority: 'medium',
                    location: '',
                    callerName: user?.username || '',
                    description: '',
                    characterId: ''
                });
            }, 2000);
        } catch (error) {
            toast.error('Ошибка создания вызова');
        }
    };

    const handleCreatePriority = async () => {
        try {
            await api.post('/admin/priorities', {
                ...priorityForm,
                createdByName: user?.username
            });
            
            setShowPrioritySuccess(true);
            setTimeout(() => {
                setShowPriorityModal(false);
                setShowPrioritySuccess(false);
                setPriorityForm({
                    title: '',
                    description: '',
                    type: 'request',
                    priority: 'medium',
                    category: '',
                    location: '',
                    requesterName: user?.username || '',
                    requesterPhone: ''
                });
            }, 2000);
        } catch (error) {
            toast.error('Ошибка создания приоритета');
        }
    };

    const handleUpdateWanted = async (characterId: string, isWanted: boolean, reason?: string, articles?: string) => {
        try {
            await api.put(`/character/characters/${characterId}`, {
                isWanted,
                wantedReason: reason || null,
                wantedArticles: articles || null
            });
            toast.success(isWanted ? 'Персонаж объявлен в розыск' : 'Розыск отменён');
            fetchCharacters();
        } catch (error) {
            toast.error('Ошибка обновления');
        }
    };

    const handleUpdateArrested = async (characterId: string, isArrested: boolean, reason?: string) => {
        try {
            await api.put(`/character/characters/${characterId}`, {
                isArrested,
                arrestReason: reason || null
            });
            toast.success(isArrested ? 'Персонаж арестован' : 'Персонаж освобождён');
            fetchCharacters();
        } catch (error) {
            toast.error('Ошибка обновления');
        }
    };

    const filteredCharacters = characters.filter(char => 
        `${char.firstName} ${char.lastName}`.toLowerCase().includes(searchTerm.toLowerCase()) ||
        char.ssn?.includes(searchTerm)
    );

    const getStatusBadge = (character: Character) => {
        if (character.isArrested) {
            return <Badge className="bg-red-500">АРЕСТОВАН</Badge>;
        }
        if (character.isWanted) {
            return <Badge className="bg-orange-500">В РОЗЫСКЕ</Badge>;
        }
        return <Badge className="bg-green-500">ACTIVE</Badge>;
    };

    const formatDate = (date: string) => {
        return new Date(date).toLocaleDateString('ru-RU');
    };

    return (
        <>
            <style>{customStyles}</style>
            <div className="text-[#e6e6e6] min-h-screen flex flex-col">
                {/* Navigation */}
                <nav className="h-16 border-b border-white/5 flex items-center px-8 flex-shrink-0">
                    <div className="flex items-center gap-2 font-bold text-sm tracking-wider uppercase text-[#555555] mr-12">
                        <span className="text-[#e6e6e6]">CIV</span>NET
                    </div>
                    <div className="flex gap-8 h-full">
                        {navItems.map((item) => (
                            <div
                                key={item.key}
                                className={`flex items-center h-full text-[13px] font-medium cursor-pointer transition-colors duration-200 relative ${
                                    activeTab === item.key ? 'text-[#e6e6e6]' : 'text-[#808080] hover:text-[#e6e6e6]'
                                }`}
                                onClick={() => setActiveTab(item.key)}
                            >
                                {item.label}
                                {activeTab === item.key && (
                                    <div className="absolute bottom-[-1px] left-0 right-0 h-[2px] bg-[#4ade80] shadow-[0_-2px_8px_rgba(74,222,128,0.3)]"></div>
                                )}
                            </div>
                        ))}
                    </div>
                    <div className="ml-auto flex items-center gap-3">
                        <Button
                            onClick={() => setShowPriorityModal(true)}
                            className="bg-blue-600 hover:bg-blue-700 text-white gap-2"
                        >
                            <Star className="h-4 w-4" />
                            Priority
                        </Button>
                        <Button
                            onClick={() => setShow911Modal(true)}
                            className="bg-red-600 hover:bg-red-700 text-white gap-2"
                        >
                            <Phone className="h-4 w-4" />
                            911
                        </Button>
                    </div>
                </nav>

                {/* Main Content */}
                <main className="flex-1 overflow-y-auto flex flex-col gap-8 p-8">
                    {activeTab === 'Characters' && (
                        <div>
                            {/* Header */}
                            <header className="flex justify-between items-center mb-4">
                                <h1 className="text-xl font-semibold text-[#e6e6e6] tracking-[-0.01em]">{t('Civilian Database')}</h1>
                                <div className="flex gap-3">
                                    <Button
                                        variant="outline"
                                        className="bg-transparent text-[#808080] border border-white/10 hover:bg-white/5"
                                        onClick={() => setSearchTerm('')}
                                    >
                                        <Filter className="h-4 w-4 mr-2" />
                                        {t('Filter')}
                                    </Button>
                                    <Button
                                        onClick={() => setShowCreateModal(true)}
                                        className="bg-[#e6e6e6] text-[#050505] hover:bg-white/90"
                                    >
                                        <Plus className="h-4 w-4 mr-2" />
                                        {t('New Entry')}
                                    </Button>
                                </div>
                            </header>
                            {/* Character Cards Grid */}
                            <div className="grid grid-cols-[repeat(auto-fill,minmax(380px,1fr))] gap-4 pb-16">
                                {filteredCharacters.map((character) => (
                            <div
                                key={character.id} 
                                className="bg-[#111111] rounded-xl h-[140px] relative flex flex-col p-5 px-6 transition-all duration-200 cursor-pointer hover:bg-[#161616] hover:-translate-y-0.5 overflow-hidden"
                                onClick={() => {
                                    const fetchFullCharacter = async () => {
                                        try {
                                            const res = await api.get(`/character/characters/${character.id}`);
                                            setSelectedCharacter(res.data.character || res.data);
                                        } catch (error) {
                                            console.error('Error fetching character details:', error);
                                            setSelectedCharacter(character);
                                        }
                                    };
                                    fetchFullCharacter();
                                    setShowViewModal(true);
                                }}
                            >
                                <div
                                    className={`absolute top-3 bottom-3 right-0 w-[3px] rounded-l-sm ${
                                        character.isArrested ? 'bg-red-500 shadow-[-2px_0_12px_rgba(239,68,68,0.3)]' :
                                        character.isWanted ? 'bg-orange-500 shadow-[-2px_0_12px_rgba(249,115,22,0.3)]' :
                                        'bg-[#4ade80] shadow-[-2px_0_12px_rgba(74,222,128,0.3)]'
                                    }`}
                                ></div>
                                
                                <div className="flex gap-4 items-start">
                                    {character.mugshot && (
                                        <div className="w-16 h-16 rounded-lg overflow-hidden border border-white/10 flex-shrink-0">
                                            <img 
                                                src={getUploadUrl(character.mugshot)} 
                                                alt="Mugshot"
                                                className="w-full h-full object-cover"
                                                crossOrigin="anonymous"
                                            />
                                        </div>
                                    )}
                                    <div className="flex-1">
                                        <div className="flex justify-between items-start mb-auto pr-3">
                                            <div>
                                                <div className="text-[15px] font-semibold text-[#e6e6e6] mb-1">
                                                    {character.lastName}, {character.firstName}
                                                </div>
                                                <div className="text-xs text-[#555555] flex items-center gap-1.5">
                                                    <div className={`w-1.5 h-1.5 rounded-full ${
                                                        character.isArrested ? 'bg-red-500' :
                                                        character.isWanted ? 'bg-orange-500' :
                                                        'bg-[#4ade80]'
                                                    }`}></div>
                                                    {character.isArrested ? t('Arrested') : character.isWanted ? t('Wanted') : t('Active Citizen')}
                                                </div>
                                            </div>
                                            <div className="bg-white/5 px-2 py-1 rounded text-[11px] text-[#808080] tracking-[0.5px]">
                                                {t('SSN')}: {character.ssn || t('N/A')}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div className="flex gap-6 pr-3 mt-2">
                                    <div className="flex flex-col gap-1">
                                        <span className="text-[10px] uppercase tracking-[0.5px] text-[#555555]">{t('Age')}</span>
                                        <span className="text-[13px] font-mono text-[#808080]">
                                            {character.dateOfBirth ? calculateAge(character.dateOfBirth) : 'N/A'}
                                        </span>
                                    </div>
                                    <div className="flex flex-col gap-1">
                                        <span className="text-[10px] uppercase tracking-[0.5px] text-[#555555]">{t('Occupation')}</span>
                                        <span className="text-[13px] font-mono text-[#808080]">{character.occupation || 'Безработный'}</span>
                                    </div>
                                    <div className="flex flex-col gap-1">
                                        <span className="text-[10px] uppercase tracking-[0.5px] text-[#555555]">{t('Records')}</span>
                                        <div className="flex gap-2">
                                            {character._count?.fines ? (
                                                <span className="text-[13px] font-mono text-yellow-500">{character._count.fines} {t('fines')}</span>
                                            ) : null}
                                            {character._count?.warrants ? (
                                                <span className="text-[13px] font-mono text-orange-500">{character._count.warrants} {t('warrants')}</span>
                                            ) : null}
                                            {character._count?.arrests ? (
                                                <span className="text-[13px] font-mono text-red-500">{character._count.arrests} {t('arrests')}</span>
                                            ) : null}
                                            {!character._count?.fines && !character._count?.warrants && !character._count?.arrests && (
                                                <span className="text-[13px] font-mono text-[#808080]">None</span>
                                            )}
                                        </div>
                                    </div>
                                </div>
                                </div>
                                ))}
                            </div>
                        </div>
                    )}

                    {activeTab === 'Vehicles' && (
                        <div className="space-y-4">
                            <div className="flex justify-between items-center">
                                <h2 className="text-xl font-semibold text-[#e6e6e6]">Транспорт</h2>
                                <Button onClick={() => setShowCreateVehicle(true)}>
                                    <Plus className="h-4 w-4 mr-2" />
                                    Добавить транспорт
                                </Button>
                            </div>
                            {vehicles.length > 0 ? (
                                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                    {vehicles.map((vehicle) => (
                                        <div 
                                            key={vehicle.id} 
                                            className="bg-[#0a0a0a] border border-white/10 rounded-lg p-4 cursor-pointer hover:border-blue-500/50 transition-colors"
                                            onClick={() => setSelectedVehicle(vehicle)}
                                        >
                                            <div className="flex justify-between items-start mb-2">
                                                <div>
                                                    <h3 className="font-bold text-blue-400">{vehicle.model}</h3>
                                                    <p className="text-sm text-[#808080]">{vehicle.color}</p>
                                                </div>
                                                <Badge className="bg-blue-500">{vehicle.type}</Badge>
                                            </div>
                                            <div className="text-lg font-mono text-white">{vehicle.plate}</div>
                                            {vehicle.ownerName && (
                                                <p className="text-xs text-[#808080] mt-2">Владелец: {vehicle.ownerName}</p>
                                            )}
                                        </div>
                                    ))}
                                </div>
                            ) : (
                                <div className="text-center py-12">
                                    <Car className="h-12 w-12 mx-auto text-[#808080] mb-4" />
                                    <p className="text-[#808080]">Нет транспорта</p>
                                </div>
                            )}
                        </div>
                    )}

                    {activeTab === 'Weapons' && (
                        <div className="space-y-4">
                            <div className="flex justify-between items-center">
                                <h2 className="text-xl font-semibold text-[#e6e6e6]">Оружие</h2>
                                <Button onClick={() => setShowCreateWeapon(true)}>
                                    <Plus className="h-4 w-4 mr-2" />
                                    Добавить оружие
                                </Button>
                            </div>
                            {weapons.length > 0 ? (
                                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                    {weapons.map((weapon) => (
                                        <div 
                                            key={weapon.id} 
                                            className="bg-[#0a0a0a] border border-white/10 rounded-lg p-4 cursor-pointer hover:border-purple-500/50 transition-colors"
                                            onClick={() => setSelectedWeapon(weapon)}
                                        >
                                            <div className="flex justify-between items-start mb-2">
                                                <div>
                                                    <h3 className="font-bold text-purple-400">{weapon.name}</h3>
                                                    <p className="text-sm text-[#808080]">{weapon.type}</p>
                                                </div>
                                                <Badge className={`${weapon.status === 'active' ? 'bg-green-500' : 'bg-red-500'}`}>
                                                    {weapon.status}
                                                </Badge>
                                            </div>
                                            <div className="text-sm font-mono text-[#808080]">SN: {weapon.serialNumber}</div>
                                            {weapon.ownerName && (
                                                <p className="text-xs text-[#808080] mt-2">Владелец: {weapon.ownerName}</p>
                                            )}
                                        </div>
                                    ))}
                                </div>
                            ) : (
                                <div className="text-center py-12">
                                    <Shield className="h-12 w-12 mx-auto text-[#808080] mb-4" />
                                    <p className="text-[#808080]">Нет оружия</p>
                                </div>
                            )}
                        </div>
                    )}
                </main>

                {/* Create Character Modal */}
                <CivilianModal
                    open={showCreateModal}
                    onOpenChange={setShowCreateModal}
                    mode="create"
                    onSuccess={() => {
                        fetchCharacters();
                        setShowCreateModal(false);
                    }}
                />

                {/* View Character Modal */}
                <CivilianModal
                    open={showViewModal}
                    onOpenChange={setShowViewModal}
                    civilian={selectedCharacter}
                    mode="view"
                    extraActions={
                        <Button 
                            variant="outline"
                            onClick={() => {
                                setShowViewModal(false);
                                setShowEditModal(true);
                            }}
                        >
                            РЕДАКТИРОВАТЬ
                        </Button>
                    }
                />

                {/* Edit Character Modal */}
                <CivilianModal
                    open={showEditModal}
                    onOpenChange={setShowEditModal}
                    civilian={selectedCharacter}
                    mode="edit"
                    onSuccess={() => {
                        fetchCharacters();
                        setShowEditModal(false);
                        setShowViewModal(true);
                    }}
                />

                {/* 911 Call Modal */}
                <Dialog open={show911Modal} onOpenChange={setShow911Modal}>
                    <DialogContent className="bg-[#111111] border border-red-500/30 text-[#e6e6e6]">
                        {show911Success ? (
                            <div className="py-8 text-center">
                                <CheckCircle className="h-16 w-16 mx-auto text-green-500 mb-4" />
                                <h3 className="text-xl font-bold text-green-500">Call Created!</h3>
                                <p className="text-[#808080]">Dispatch has been notified</p>
                            </div>
                        ) : (
                            <>
                                <DialogHeader>
                                    <DialogTitle className="text-red-500 flex items-center gap-2">
                                        <Phone className="h-5 w-5" />
                                        Emergency 911 Call
                                    </DialogTitle>
                                </DialogHeader>
                                <div className="space-y-4 py-4">
                                    <div>
                                        <Label className="text-[#808080] text-xs">Call Type</Label>
                                        <Select 
                                            value={new911Call.type} 
                                            onValueChange={(v) => setNew911Call({...new911Call, type: v})}
                                        >
                                            <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                                <SelectValue />
                                            </SelectTrigger>
                                            <SelectContent className="bg-[#111111] border border-white/10">
                                                <SelectItem value="911">911 - Emergency</SelectItem>
                                                <SelectItem value="traffic">Traffic Incident</SelectItem>
                                                <SelectItem value="crime">Crime Report</SelectItem>
                                                <SelectItem value="medical">Medical Emergency</SelectItem>
                                                <SelectItem value="fire">Fire Emergency</SelectItem>
                                                <SelectItem value="other">Other</SelectItem>
                                            </SelectContent>
                                        </Select>
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Priority</Label>
                                        <Select 
                                            value={new911Call.priority} 
                                            onValueChange={(v) => setNew911Call({...new911Call, priority: v})}
                                        >
                                            <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                                <SelectValue />
                                            </SelectTrigger>
                                            <SelectContent className="bg-[#111111] border border-white/10">
                                                <SelectItem value="low">Low</SelectItem>
                                                <SelectItem value="medium">Medium</SelectItem>
                                                <SelectItem value="high">High</SelectItem>
                                                <SelectItem value="critical">Critical</SelectItem>
                                            </SelectContent>
                                        </Select>
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Location</Label>
                                        <Input
                                            value={new911Call.location}
                                            onChange={(e) => setNew911Call({...new911Call, location: e.target.value})}
                                            placeholder="Enter location"
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                        />
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Caller Name</Label>
                                        <Input
                                            value={new911Call.callerName}
                                            onChange={(e) => setNew911Call({...new911Call, callerName: e.target.value})}
                                            placeholder="Your name"
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                        />
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Description</Label>
                                        <Textarea
                                            value={new911Call.description}
                                            onChange={(e) => setNew911Call({...new911Call, description: e.target.value})}
                                            placeholder="Describe the emergency..."
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                            rows={4}
                                        />
                                    </div>
                                </div>
                                <DialogFooter>
                                    <Button variant="outline" onClick={() => setShow911Modal(false)} className="border-white/10">
                                        Cancel
                                    </Button>
                                    <Button 
                                        onClick={handleCreate911Call}
                                        className="bg-red-600 hover:bg-red-700 text-white"
                                        disabled={!new911Call.location || !new911Call.description}
                                    >
                                        <Phone className="h-4 w-4 mr-2" />
                                        Call 911
                                    </Button>
                                </DialogFooter>
                            </>
                        )}
                    </DialogContent>
                </Dialog>

                {/* Priority Request Modal */}
                <Dialog open={showPriorityModal} onOpenChange={setShowPriorityModal}>
                    <DialogContent className="bg-[#111111] border border-blue-500/30 text-[#e6e6e6]">
                        {showPrioritySuccess ? (
                            <div className="py-8 text-center">
                                <CheckCircle className="h-16 w-16 mx-auto text-green-500 mb-4" />
                                <h3 className="text-xl font-bold text-green-500">Request Submitted!</h3>
                                <p className="text-[#808080]">Priority request has been sent</p>
                            </div>
                        ) : (
                            <>
                                <DialogHeader>
                                    <DialogTitle className="text-blue-500 flex items-center gap-2">
                                        <Star className="h-5 w-5" />
                                        Priority Request
                                    </DialogTitle>
                                </DialogHeader>
                                <div className="space-y-4 py-4">
                                    <div>
                                        <Label className="text-[#808080] text-xs">Title</Label>
                                        <Input
                                            value={priorityForm.title}
                                            onChange={(e) => setPriorityForm({...priorityForm, title: e.target.value})}
                                            placeholder="Brief description"
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                        />
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Category</Label>
                                        <Select 
                                            value={priorityForm.category} 
                                            onValueChange={(v) => setPriorityForm({...priorityForm, category: v})}
                                        >
                                            <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                                <SelectValue placeholder="Select category" />
                                            </SelectTrigger>
                                            <SelectContent className="bg-[#111111] border border-white/10">
                                                <SelectItem value="traffic">Traffic Stop</SelectItem>
                                                <SelectItem value="pullover">Pullover</SelectItem>
                                                <SelectItem value="pursuit">Pursuit</SelectItem>
                                                <SelectItem value="investigation">Investigation</SelectItem>
                                                <SelectItem value="report">Report</SelectItem>
                                                <SelectItem value="other">Other</SelectItem>
                                            </SelectContent>
                                        </Select>
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Priority</Label>
                                        <Select 
                                            value={priorityForm.priority} 
                                            onValueChange={(v) => setPriorityForm({...priorityForm, priority: v})}
                                        >
                                            <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                                <SelectValue />
                                            </SelectTrigger>
                                            <SelectContent className="bg-[#111111] border border-white/10">
                                                <SelectItem value="low">Low</SelectItem>
                                                <SelectItem value="medium">Medium</SelectItem>
                                                <SelectItem value="high">High</SelectItem>
                                                <SelectItem value="critical">Critical</SelectItem>
                                            </SelectContent>
                                        </Select>
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Location</Label>
                                        <Input
                                            value={priorityForm.location}
                                            onChange={(e) => setPriorityForm({...priorityForm, location: e.target.value})}
                                            placeholder="Current location"
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                        />
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Your Name</Label>
                                        <Input
                                            value={priorityForm.requesterName}
                                            onChange={(e) => setPriorityForm({...priorityForm, requesterName: e.target.value})}
                                            placeholder="Your name"
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                        />
                                    </div>

                                    <div>
                                        <Label className="text-[#808080] text-xs">Description</Label>
                                        <Textarea
                                            value={priorityForm.description}
                                            onChange={(e) => setPriorityForm({...priorityForm, description: e.target.value})}
                                            placeholder="Describe what you need..."
                                            className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                            rows={4}
                                        />
                                    </div>
                                </div>
                                <DialogFooter>
                                    <Button variant="outline" onClick={() => setShowPriorityModal(false)} className="border-white/10">
                                        Cancel
                                    </Button>
                                    <Button 
                                        onClick={handleCreatePriority}
                                        className="bg-blue-600 hover:bg-blue-700 text-white"
                                        disabled={!priorityForm.title || !priorityForm.description}
                                    >
                                        <Star className="h-4 w-4 mr-2" />
                                        Submit Request
                                    </Button>
                                </DialogFooter>
                            </>
                        )}
                    </DialogContent>
                </Dialog>

                {/* Officer Management Dialog */}
                <Dialog open={showOfficerDialog} onOpenChange={setShowOfficerDialog}>
                    <DialogContent className="bg-[#111111] border border-white/10 text-[#e6e6e6]">
                        <DialogHeader>
                            <DialogTitle className="text-[#e6e6e6]">
                                {characterOfficers.length > 0 ? 'Редактировать офицера' : 'Создать офицера'}
                            </DialogTitle>
                            <DialogDescription className="text-[#808080]">
                                Управление офицерами для данного персонажа
                            </DialogDescription>
                        </DialogHeader>
                        <div className="space-y-4 py-4">
                            <div>
                                <Label className="text-[#808080] text-xs">ДЕПАРТАМЕНТ</Label>
                                <Select 
                                    value={officerData.departmentId} 
                                    onValueChange={(v) => {
                                        setOfficerData({...officerData, departmentId: v, divisionId: ''});
                                        fetchDepartmentRanks(v);
                                    }}
                                >
                                    <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                        <SelectValue placeholder="Выберите департамент" />
                                    </SelectTrigger>
                                    <SelectContent className="bg-[#111111] border border-white/10">
                                        {leoDepartments.map((dept) => (
                                            <SelectItem key={dept.id} value={dept.id}>
                                                {dept.name} ({dept.shortCode})
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>
                            {departmentDivisions.length > 0 && (
                                <div>
                                    <Label className="text-[#808080] text-xs">ПОДРАЗДЕЛЕНИЕ</Label>
                                    <Select 
                                        value={officerData.divisionId} 
                                        onValueChange={(v) => setOfficerData({...officerData, divisionId: v === 'none' ? '' : v})}
                                    >
                                        <SelectTrigger className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]">
                                            <SelectValue placeholder="Выберите подразделение" />
                                        </SelectTrigger>
                                        <SelectContent className="bg-[#111111] border border-white/10">
                                            <SelectItem value="none">Нет</SelectItem>
                                            {departmentDivisions.map((div) => (
                                                <SelectItem key={div.id} value={div.id}>
                                                    {div.name} {div.isDetective && '(Детективный)'}
                                                </SelectItem>
                                            ))}
                                        </SelectContent>
                                    </Select>
                                </div>
                            )}
                            <div>
                                <Label className="text-[#808080] text-xs">ПОЗЫВНОЙ</Label>
                                <Input
                                    value={officerData.callsign}
                                    onChange={(e) => setOfficerData({...officerData, callsign: e.target.value.toUpperCase()})}
                                    placeholder="Например: 1A-10"
                                    className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                />
                            </div>
                            <div>
                                <Label className="text-[#808080] text-xs">ЗВАНИЕ</Label>
                                <Input
                                    value={officerData.officerRank}
                                    onChange={(e) => setOfficerData({...officerData, officerRank: e.target.value})}
                                    placeholder="Например: Officer, Sergeant"
                                    className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                />
                            </div>
                            <div>
                                <Label className="text-[#808080] text-xs">НОМЕР ЗНАЧКА</Label>
                                <Input
                                    value={officerData.badgeNumber}
                                    onChange={(e) => setOfficerData({...officerData, badgeNumber: e.target.value})}
                                    placeholder="Например: 1234"
                                    className="bg-[#0a0a0a] border border-white/5 text-[#e6e6e6]"
                                />
                            </div>
                        </div>
                        <DialogFooter className="flex justify-between">
                            {characterOfficers.length > 0 && (
                                <Button 
                                    variant="outline" 
                                    className="border-red-500/50 text-red-500 hover:bg-red-500/10"
                                    onClick={handleDeleteOfficer}
                                >
                                    Удалить офицера
                                </Button>
                            )}
                            <div className="flex gap-2 ml-auto">
                                <Button variant="outline" onClick={() => setShowOfficerDialog(false)} className="border-white/10">
                                    Отмена
                                </Button>
                                <Button 
                                    onClick={characterOfficers.length > 0 ? handleUpdateOfficer : handleCreateOfficer}
                                    className="bg-blue-600 hover:bg-blue-700"
                                >
                                    {characterOfficers.length > 0 ? 'Сохранить' : 'Создать'}
                                </Button>
                            </div>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            </div>

            {/* Create Vehicle Modal */}
            <Dialog open={showCreateVehicle} onOpenChange={setShowCreateVehicle}>
                <DialogContent className="bg-[#111111] border border-white/10 text-[#e6e6e6]">
                    <DialogHeader>
                        <DialogTitle>Добавить транспорт</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label className="text-[#808080] text-xs">МОДЕЛЬ *</Label>
                            <Input 
                                value={newVehicle.model} 
                                onChange={(e) => setNewVehicle({...newVehicle, model: e.target.value})}
                                placeholder="BMW X5"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ГОСНОМЕР *</Label>
                            <Input 
                                value={newVehicle.plate} 
                                onChange={(e) => setNewVehicle({...newVehicle, plate: e.target.value.toUpperCase()})}
                                placeholder="ABC123"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ЦВЕТ</Label>
                            <Input 
                                value={newVehicle.color} 
                                onChange={(e) => setNewVehicle({...newVehicle, color: e.target.value})}
                                placeholder="Чёрный"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ТИП</Label>
                            <Select value={newVehicle.type} onValueChange={(v) => setNewVehicle({...newVehicle, type: v})}>
                                <SelectTrigger className="bg-[#0a0a0a] border-white/10">
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="car">Автомобиль</SelectItem>
                                    <SelectItem value="motorcycle">Мотоцикл</SelectItem>
                                    <SelectItem value="boat">Лодка</SelectItem>
                                    <SelectItem value="aircraft">Авиация</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ФОТО</Label>
                            <div className="flex items-center gap-2">
                                <label className="flex-1 cursor-pointer">
                                    <input 
                                        type="file" 
                                        accept="image/*" 
                                        className="hidden" 
                                        onChange={handleVehiclePhotoUpload}
                                    />
                                    <div className="h-20 bg-[#0a0a0a] border border-white/10 rounded flex items-center justify-center hover:bg-white/5 transition-colors">
                                        {vehiclePhotoPreview || newVehicle.photo ? (
                                            <img src={vehiclePhotoPreview || newVehicle.photo} alt="Vehicle" className="h-full object-contain rounded" />
                                        ) : (
                                            <span className="text-[#808080] text-xs">Нажмите для загрузки</span>
                                        )}
                                    </div>
                                </label>
                                {(vehiclePhotoPreview || newVehicle.photo) && (
                                    <Button variant="outline" size="sm" onClick={removeVehiclePhoto} className="h-10">
                                        ✕
                                    </Button>
                                )}
                            </div>
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ОСОБЕННОСТИ</Label>
                            <Input 
                                value={newVehicle.features} 
                                onChange={(e) => setNewVehicle({...newVehicle, features: e.target.value})}
                                placeholder="Тюнинг, повреждения и т.д."
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ВЛАДЕЛЕЦ</Label>
                            <Select value={newVehicle.ownerCharacterId} onValueChange={(v) => {
                                const char = characters.find(c => c.id === v);
                                setNewVehicle({...newVehicle, ownerCharacterId: v, ownerName: char ? `${char.firstName} ${char.lastName}` : ''});
                            }}>
                                <SelectTrigger className="bg-[#0a0a0a] border-white/10">
                                    <SelectValue placeholder="Выберите персонажа" />
                                </SelectTrigger>
                                <SelectContent>
                                    {characters.map((char) => (
                                        <SelectItem key={char.id} value={char.id}>
                                            {char.firstName} {char.lastName}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowCreateVehicle(false)}>Отмена</Button>
                        <Button onClick={handleCreateVehicle}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Create Weapon Modal */}
            <Dialog open={showCreateWeapon} onOpenChange={setShowCreateWeapon}>
                <DialogContent className="bg-[#111111] border border-white/10 text-[#e6e6e6]">
                    <DialogHeader>
                        <DialogTitle>Добавить оружие</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label className="text-[#808080] text-xs">ТИП *</Label>
                            <Input 
                                value={newWeapon.type} 
                                onChange={(e) => setNewWeapon({...newWeapon, type: e.target.value})}
                                placeholder="Пистолет"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">НАЗВАНИЕ *</Label>
                            <Input 
                                value={newWeapon.name} 
                                onChange={(e) => setNewWeapon({...newWeapon, name: e.target.value})}
                                placeholder="Glock 19"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">СЕРИЙНЫЙ НОМЕР *</Label>
                            <Input 
                                value={newWeapon.serialNumber} 
                                onChange={(e) => setNewWeapon({...newWeapon, serialNumber: e.target.value.toUpperCase()})}
                                placeholder="SN123456"
                                className="bg-[#0a0a0a] border-white/10"
                            />
                        </div>
                        <div>
                            <Label className="text-[#808080] text-xs">ВЛАДЕЛЕЦ</Label>
                            <Select value={newWeapon.ownerCharacterId} onValueChange={(v) => {
                                const char = characters.find(c => c.id === v);
                                setNewWeapon({...newWeapon, ownerCharacterId: v, ownerName: char ? `${char.firstName} ${char.lastName}` : ''});
                            }}>
                                <SelectTrigger className="bg-[#0a0a0a] border-white/10">
                                    <SelectValue placeholder="Выберите персонажа" />
                                </SelectTrigger>
                                <SelectContent>
                                    {characters.map((char) => (
                                        <SelectItem key={char.id} value={char.id}>
                                            {char.firstName} {char.lastName}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowCreateWeapon(false)}>Отмена</Button>
                        <Button onClick={handleCreateWeapon}>Добавить</Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </>
    );
}
