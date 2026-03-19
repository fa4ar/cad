'use client';

import { useState, useEffect, useRef } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { toast } from 'sonner';
import api from '@/lib/api/axios';
import { User, Phone, MapPin, Briefcase, FileText, Calendar, Shield, Upload, X } from 'lucide-react';

const getUploadUrl = (path: string | null | undefined): string | undefined => {
  if (!path) return undefined;
  let baseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
  baseUrl = baseUrl.replace('/api', '');
  return path.startsWith('http') ? path : `${baseUrl}${path}`;
};

interface CivilianData {
  id?: string;
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
  mugshot?: string;
  fullBodyImage?: string;
  isDead?: boolean;
  isMissing?: boolean;
  isWanted?: boolean;
  isArrested?: boolean;
  wantedReason?: string;
  wantedArticles?: string;
  arrestReason?: string;
  playTime?: number;
  money?: number;
  bankBalance?: number;
  reputation?: number;
  vehicles?: any[];
  weapons?: any[];
  isOfficer?: boolean;
  officerDepartmentId?: string;
  department?: {
    name: string;
    shortCode: string;
    color: string;
  };
  fines?: any[];
  warrants?: any[];
  arrests?: any[];
}

interface CivilianModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  civilian?: CivilianData | null;
  mode: 'view' | 'create' | 'edit';
  onSuccess?: (data: CivilianData) => void;
  extraActions?: React.ReactNode;
}

export function CivilianModal({ open, onOpenChange, civilian, mode, onSuccess, extraActions }: CivilianModalProps) {
  const [formData, setFormData] = useState<CivilianData>({
    firstName: '',
    lastName: '',
    dateOfBirth: '',
    gender: '',
    nationality: '',
    ethnicity: '',
    hairColor: '',
    eyeColor: '',
    height: undefined,
    weight: undefined,
    build: '',
    ssn: '',
    licenseNumber: '',
    passportNumber: '',
    driversLicense: false,
    weaponsLicense: false,
    pilotLicense: false,
    commercialLicense: false,
    phoneNumber: '',
    email: '',
    address: '',
    city: '',
    postalCode: '',
    occupation: '',
    employer: '',
    salary: undefined,
    departmentRank: '',
    bloodType: '',
    allergies: '',
    medicalNotes: '',
    biography: '',
    notes: '',
    mugshot: '',
    isDead: false,
    isMissing: false,
    isWanted: false,
    wantedReason: '',
    wantedArticles: '',
    isOfficer: false,
    officerDepartmentId: '',
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [departments, setDepartments] = useState<any[]>([]);
  const [photoPreview, setPhotoPreview] = useState<string>('');
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (mode === 'create' || mode === 'edit') {
      fetchDepartments();
    }
  }, [mode]);

  const formatDateForInput = (dateStr: string | undefined): string => {
    if (!dateStr) return '';
    try {
      const date = new Date(dateStr);
      if (isNaN(date.getTime())) return '';
      return date.toISOString().split('T')[0];
    } catch {
      return '';
    }
  };

  useEffect(() => {
    if (civilian && (mode === 'view' || mode === 'edit')) {
      setFormData({
        ...civilian,
        dateOfBirth: formatDateForInput(civilian.dateOfBirth)
      });
      setCivilianData(civilian);
      setPhotoPreview(civilian.mugshot || '');
    } else if (mode === 'create') {
      setFormData({
        firstName: '',
        lastName: '',
        dateOfBirth: '',
        gender: '',
        nationality: '',
        ethnicity: '',
        hairColor: '',
        eyeColor: '',
        height: undefined,
        weight: undefined,
        build: '',
        ssn: '',
        licenseNumber: '',
        passportNumber: '',
        driversLicense: false,
        weaponsLicense: false,
        pilotLicense: false,
        commercialLicense: false,
        phoneNumber: '',
        email: '',
        address: '',
        city: '',
        postalCode: '',
        occupation: '',
        employer: '',
        salary: undefined,
        departmentRank: '',
        bloodType: '',
        allergies: '',
        medicalNotes: '',
        biography: '',
        notes: '',
        mugshot: '',
        isDead: false,
        isMissing: false,
        isWanted: false,
        wantedReason: '',
        wantedArticles: '',
        isOfficer: false,
        officerDepartmentId: '',
      });
      setCivilianData(null);
      setPhotoPreview('');
    }
  }, [civilian, mode, open]);

  const [showCreateVehicle, setShowCreateVehicle] = useState(false);
  const [showCreateWeapon, setShowCreateWeapon] = useState(false);
  const [newVehicle, setNewVehicle] = useState({ model: '', plate: '', color: '', type: 'car', photo: '', features: '' });
  const [vehiclePhotoPreview, setVehiclePhotoPreview] = useState('');
  const [newWeapon, setNewWeapon] = useState({ type: '', name: '', serialNumber: '' });
  const [isCreating, setIsCreating] = useState(false);

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

  const handleCreateVehicle = async () => {
    const currentData = civilianData || civilian;
    if (!newVehicle.model || !newVehicle.plate || !currentData?.id) {
      toast.error('Заполните модель и госномер');
      return;
    }
    setIsCreating(true);
    try {
      await api.post('/leo/vehicles', {
        ...newVehicle,
        ownerCharacterId: currentData.id,
        ownerName: `${currentData.firstName} ${currentData.lastName}`
      });
      toast.success('Транспорт добавлен');
      setShowCreateVehicle(false);
      setNewVehicle({ model: '', plate: '', color: '', type: 'car', photo: '', features: '' });
      setVehiclePhotoPreview('');
      
      const res = await api.get(`/character/characters/${currentData.id}`);
      const updatedData = res.data.character || res.data;
      setFormData(updatedData);
      setCivilianData(updatedData);
      onSuccess?.(updatedData);
    } catch (error: any) {
      toast.error(error.response?.data?.error || 'Ошибка');
    } finally {
      setIsCreating(false);
    }
  };

  const [civilianData, setCivilianData] = useState<CivilianData | null>(null);

  const handleCreateWeapon = async () => {
    const currentData = civilianData || civilian;
    if (!newWeapon.type || !newWeapon.name || !newWeapon.serialNumber || !currentData?.id) {
      toast.error('Заполните все поля');
      return;
    }
    setIsCreating(true);
    try {
      await api.post('/leo/weapons', {
        ...newWeapon,
        ownerCharacterId: currentData.id,
        ownerName: `${currentData.firstName} ${currentData.lastName}`
      });
      toast.success('Оружие добавлено');
      setShowCreateWeapon(false);
      setNewWeapon({ type: '', name: '', serialNumber: '' });
      
      const res = await api.get(`/character/characters/${currentData.id}`);
      const updatedData = res.data.character || res.data;
      setFormData(updatedData);
      setCivilianData(updatedData);
      onSuccess?.(updatedData);
    } catch (error: any) {
      toast.error(error.response?.data?.error || 'Ошибка');
    } finally {
      setIsCreating(false);
    }
  };

  const fetchDepartments = async () => {
    try {
      const res = await api.get('/departments');
      console.log('Departments response:', res.data);
      let departmentsData = res.data;
      if (res.data?.departments) {
        departmentsData = res.data.departments;
      }
      if (Array.isArray(departmentsData)) {
        setDepartments(departmentsData.filter((d: any) => d.type === 'police'));
      } else {
        console.warn('Unexpected departments data format:', res.data);
        setDepartments([]);
      }
    } catch (error) {
      console.error('Error fetching departments:', error);
    }
  };

  const calculateAgeFromDob = (dob: string | undefined): number | null => {
    if (!dob) return null;
    const birthDate = new Date(dob);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  const handlePhotoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onloadend = () => {
      setPhotoPreview(reader.result as string);
    };
    reader.readAsDataURL(file);

    const formDataFile = new FormData();
    formDataFile.append('file', file);

    try {
      const res = await api.post('/upload?type=character', formDataFile, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });
      setFormData(prev => ({ ...prev, mugshot: res.data.url }));
      toast.success('Фото загружено');
    } catch (error) {
      console.error('Error uploading photo:', error);
      setPhotoPreview('');
      toast.error('Ошибка загрузки фото');
    }
  };

  const removePhoto = () => {
    setFormData(prev => ({ ...prev, mugshot: '' }));
    setPhotoPreview('');
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const handleSubmit = async () => {
    if (!formData.firstName || !formData.lastName) {
      toast.error('Заполните имя и фамилию');
      return;
    }

    const submitData = {
      firstName: formData.firstName,
      lastName: formData.lastName,
      dateOfBirth: formData.dateOfBirth || null,
      gender: formData.gender || 'male',
      nationality: formData.nationality || null,
      ethnicity: formData.ethnicity || null,
      hairColor: formData.hairColor || null,
      eyeColor: formData.eyeColor || null,
      height: formData.height || null,
      weight: formData.weight || null,
      build: formData.build || null,
      ssn: formData.ssn || null,
      licenseNumber: formData.licenseNumber || null,
      passportNumber: formData.passportNumber || null,
      driversLicense: formData.driversLicense || false,
      weaponsLicense: formData.weaponsLicense || false,
      pilotLicense: formData.pilotLicense || false,
      commercialLicense: formData.commercialLicense || false,
      phoneNumber: formData.phoneNumber || null,
      email: formData.email || null,
      address: formData.address || null,
      city: formData.city || null,
      postalCode: formData.postalCode || null,
      occupation: formData.occupation || null,
      employer: formData.employer || null,
      salary: formData.salary || null,
      departmentRank: formData.departmentRank || null,
      bloodType: formData.bloodType || null,
      allergies: formData.allergies || null,
      medicalNotes: formData.medicalNotes || null,
      biography: formData.biography || null,
      notes: formData.notes || null,
      isDead: formData.isDead || false,
      isMissing: formData.isMissing || false,
      isWanted: formData.isWanted || false,
      wantedReason: formData.wantedReason || null,
      wantedArticles: formData.wantedArticles || null,
      mugshot: formData.mugshot || null,
    };

    console.log('Submitting data:', submitData);

    setIsSubmitting(true);
    try {
      if (mode === 'create') {
        await api.post('/character/characters', submitData);
        toast.success('Персонаж создан');
      } else if (mode === 'edit' && civilian?.id) {
        await api.put(`/character/characters/${civilian.id}`, submitData);
        toast.success('Персонаж обновлён');
      }
      onSuccess?.(formData);
      onOpenChange(false);
    } catch (error: any) {
      console.error('Error saving civilian:', error);
      toast.error(error.response?.data?.error || 'Ошибка при сохранении');
    } finally {
      setIsSubmitting(false);
    }
  };

  const renderViewMode = () => {
    const data = civilianData || civilian;
    if (!data) return null;
    
    const age = calculateAgeFromDob(data.dateOfBirth);
    const fines = data.fines || [];
    const warrants = data.warrants || [];
    const vehicles = data.vehicles || [];
    const weapons = data.weapons || [];
    
    return (
      <div className="space-y-3 py-3 max-h-[70vh] overflow-y-auto pr-2">
        <div className="flex justify-center">
          <div className="relative">
            <div className="w-32 h-32 rounded-lg border-2 border-dashed border-muted flex items-center justify-center overflow-hidden">
              {data.mugshot ? (
                <img src={getUploadUrl(data.mugshot)} alt="Mugshot" className="w-full h-full object-cover" crossOrigin="anonymous" />
              ) : (
                <div className="text-center">
                  <Upload className="h-6 w-6 mx-auto text-muted-foreground" />
                  <p className="text-[10px] text-muted-foreground mt-1">Фото</p>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="flex flex-wrap gap-1.5 mb-2">
          {data.isDead && <Badge className="bg-gray-500 text-[10px]">МЁРТВ</Badge>}
          {data.isMissing && <Badge className="bg-yellow-500 text-[10px]">ПРОПАЛ</Badge>}
          {data.isWanted && <Badge className="bg-red-500 text-[10px]">РОЗЫСК</Badge>}
          {data.isArrested && <Badge className="bg-orange-500 text-[10px]">АРЕСТ</Badge>}
          {data.isOfficer && <Badge className="bg-blue-500 text-[10px]">{data.department?.shortCode || 'OFFICER'}</Badge>}
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">ИМЯ</Label>
            <Input value={data.firstName || ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">ФАМИЛИЯ</Label>
            <Input value={data.lastName || ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        <div className="grid grid-cols-3 gap-3">
          <div>
            <Label className="text-xs">ДР</Label>
            <Input value={data.dateOfBirth ? new Date(data.dateOfBirth).toISOString().split('T')[0] : ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">ВОЗРАСТ</Label>
            <Input value={age !== null ? `${age}` : ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">ПОЛ</Label>
            <Input value={data.gender === 'male' ? 'Муж' : data.gender === 'female' ? 'Жен' : ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">SSN</Label>
            <Input value={data.ssn || ''} disabled className="h-8 bg-muted/50 font-mono" />
          </div>
          <div>
            <Label className="text-xs">ТЕЛЕФОН</Label>
            <Input value={data.phoneNumber || ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        <div>
          <Label className="text-xs">АДРЕС</Label>
          <Input value={data.address || ''} disabled className="h-8 bg-muted/50" />
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">ГОРОД</Label>
            <Input value={data.city || ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">ИНДЕКС</Label>
            <Input value={data.postalCode || ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">РАБОТА</Label>
            <Input value={data.occupation || ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">РАБОТОДАТЕЛЬ</Label>
            <Input value={data.employer || ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        <div className="border-t pt-3">
          <Label className="text-xs text-muted-foreground mb-2 block">ВНЕШНОСТЬ</Label>
          <div className="grid grid-cols-4 gap-2">
            <div>
              <Label className="text-[10px]">ВОЛОСЫ</Label>
              <Input value={data.hairColor || ''} disabled className="h-7 text-xs bg-muted/50" />
            </div>
            <div>
              <Label className="text-[10px]">ГЛАЗА</Label>
              <Input value={data.eyeColor || ''} disabled className="h-7 text-xs bg-muted/50" />
            </div>
            <div>
              <Label className="text-[10px]">РОСТ</Label>
              <Input value={data.height || ''} disabled className="h-7 text-xs bg-muted/50" />
            </div>
            <div>
              <Label className="text-[10px]">ВЕС</Label>
              <Input value={data.weight || ''} disabled className="h-7 text-xs bg-muted/50" />
            </div>
          </div>
        </div>

        <div className="border-t pt-3">
          <Label className="text-xs text-muted-foreground mb-2 block">ЛИЦЕНЗИИ</Label>
          <div className="flex flex-wrap gap-2">
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.driversLicense ? 'bg-green-500/20 text-green-500 border border-green-500/50' : 'bg-muted/50 text-muted-foreground'}`}>DL</span>
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.weaponsLicense ? 'bg-red-500/20 text-red-500 border border-red-500/50' : 'bg-muted/50 text-muted-foreground'}`}>CCW</span>
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.pilotLicense ? 'bg-blue-500/20 text-blue-500 border border-blue-500/50' : 'bg-muted/50 text-muted-foreground'}`}>PPL</span>
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.commercialLicense ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/50' : 'bg-muted/50 text-muted-foreground'}`}>CDL</span>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">НОМЕР DL</Label>
            <Input value={data.licenseNumber || ''} disabled className="h-8 bg-muted/50" />
          </div>
          <div>
            <Label className="text-xs">ГОРУППА КРОВИ</Label>
            <Input value={data.bloodType || ''} disabled className="h-8 bg-muted/50" />
          </div>
        </div>

        <div>
          <Label className="text-xs">АЛЛЕРГИИ</Label>
          <Input value={data.allergies || ''} disabled className="h-8 bg-muted/50" />
        </div>

        <div className="border-t pt-3">
          <Label className="text-xs text-muted-foreground mb-2 block">СТАТУС</Label>
          <div className="flex flex-wrap gap-2">
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.isDead ? 'bg-gray-500/20 text-gray-400 border border-gray-500/50' : 'bg-muted/50 text-muted-foreground'}`}>МЁРТВ</span>
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.isMissing ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/50' : 'bg-muted/50 text-muted-foreground'}`}>ПРОПАЛ</span>
            <span className={`px-3 py-1.5 rounded-md text-xs font-mono ${data.isWanted ? 'bg-orange-500/20 text-orange-500 border border-orange-500/50' : 'bg-muted/50 text-muted-foreground'}`}>РОЗЫСК</span>
          </div>
          {data.isWanted && (
            <div className="mt-2">
              <Input value={data.wantedReason || ''} disabled className="h-8 bg-muted/50" />
            </div>
          )}
        </div>

        <div className="border-t pt-3">
          <Label className="text-xs text-muted-foreground mb-2 block">ЗАМЕТКИ</Label>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-xs">БИОГРАФИЯ</Label>
              <Input value={data.biography || ''} disabled className="h-8 bg-muted/50" />
            </div>
            <div>
              <Label className="text-xs">ЗАМЕТКИ</Label>
              <Input value={data.notes || ''} disabled className="h-8 bg-muted/50" />
            </div>
          </div>
        </div>

        {fines.length > 0 && (
          <div className="border-t pt-3">
            <Label className="text-xs text-muted-foreground mb-2 block">{fines.length} ШТРАФ</Label>
            <div className="space-y-1.5 max-h-32 overflow-y-auto">
              {fines.map((fine) => (
                <div key={fine.id} className="p-2 bg-muted/50 rounded flex justify-between items-center text-xs">
                  <div>
                    <span className="font-bold text-yellow-500 font-mono">${fine.amount}</span>
                    <span className="ml-2 text-muted-foreground">{fine.reason}</span>
                  </div>
                  <Badge variant="outline" className="text-[10px] font-mono">{fine.status?.slice(0,4) || 'UNPD'}</Badge>
                </div>
              ))}
            </div>
          </div>
        )}

        {warrants.length > 0 && (
          <div className="border-t pt-3">
            <Label className="text-xs text-muted-foreground mb-2 block">{warrants.length} ОРДЕР</Label>
            <div className="space-y-1.5 max-h-32 overflow-y-auto">
              {warrants.map((warrant) => (
                <div key={warrant.id} className="p-2 bg-red-500/10 border border-red-500/20 rounded text-xs">
                  <span className="font-bold text-red-500 font-mono">{warrant.title}</span>
                  <p className="text-muted-foreground">{warrant.reason}</p>
                </div>
              ))}
            </div>
          </div>
        )}

        {vehicles.length > 0 && (
          <div className="border-t pt-3">
            <Label className="text-xs text-muted-foreground mb-2 block">{vehicles.length} АВТО</Label>
            <div className="space-y-1.5 max-h-32 overflow-y-auto">
              {vehicles.map((vehicle: any) => (
                <div key={vehicle.id} className="p-2 bg-blue-500/10 border border-blue-500/20 rounded flex justify-between items-center text-xs">
                  <div className="flex items-center gap-2">
                    <span className="font-bold text-blue-400 font-mono">{vehicle.model}</span>
                    <span className="text-muted-foreground">{vehicle.color}</span>
                  </div>
                  <span className="font-mono text-blue-400">{vehicle.plate}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        {weapons.length > 0 && (
          <div className="border-t pt-3">
            <Label className="text-xs text-muted-foreground mb-2 block">{weapons.length} ОРУЖИЕ</Label>
            <div className="space-y-1.5 max-h-32 overflow-y-auto">
              {weapons.map((weapon: any) => (
                <div key={weapon.id} className="p-2 bg-purple-500/10 border border-purple-500/20 rounded flex justify-between items-center text-xs">
                  <span className="font-bold text-purple-400 font-mono">{weapon.name}</span>
                  <span className="text-muted-foreground font-mono">{weapon.serialNumber}</span>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    );
  };

  const renderFormMode = () => (
    <div className="space-y-3 py-3 max-h-[70vh] overflow-y-auto pr-2">
      <div className="flex justify-center">
        <div className="relative">
          <div 
            className="w-32 h-32 rounded-lg border-2 border-dashed border-muted flex items-center justify-center cursor-pointer hover:border-primary transition-colors overflow-hidden"
            onClick={() => fileInputRef.current?.click()}
          >
            {photoPreview ? (
              <img 
                src={photoPreview} 
                alt="Preview" 
                className="w-full h-full object-cover"
              />
            ) : (
              <div className="text-center">
                <Upload className="h-6 w-6 mx-auto text-muted-foreground" />
                <p className="text-[10px] text-muted-foreground mt-1">Фото</p>
              </div>
            )}
            <input
              ref={fileInputRef}
              type="file"
              accept="image/*"
              onChange={handlePhotoUpload}
              className="hidden"
            />
          </div>
          {photoPreview && (
            <button
              onClick={removePhoto}
              className="absolute -top-2 -right-2 bg-red-500 text-white p-1 rounded-full"
            >
              <X className="w-3 h-3" />
            </button>
          )}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">ИМЯ *</Label>
          <Input
            value={formData.firstName || ''}
            onChange={(e) => setFormData({ ...formData, firstName: e.target.value })}
            placeholder="Имя"
            className="h-8"
          />
        </div>
        <div>
          <Label className="text-xs">ФАМИЛИЯ *</Label>
          <Input
            value={formData.lastName || ''}
            onChange={(e) => setFormData({ ...formData, lastName: e.target.value })}
            placeholder="Фамилия"
            className="h-8"
          />
        </div>
      </div>

      <div className="grid grid-cols-3 gap-3">
        <div>
          <Label className="text-xs">ДР</Label>
          <Input
            type="date"
            value={formData.dateOfBirth || ''}
            onChange={(e) => setFormData({ ...formData, dateOfBirth: e.target.value })}
            className="h-8"
          />
        </div>
        <div>
          <Label className="text-xs">ПОЛ</Label>
          <Select value={formData.gender || ''} onValueChange={(v) => setFormData({ ...formData, gender: v })}>
            <SelectTrigger className="h-8">
              <SelectValue placeholder="Пол" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="male">Муж</SelectItem>
              <SelectItem value="female">Жен</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label className="text-xs">НАЦИОН</Label>
          <Input
            value={formData.nationality || ''}
            onChange={(e) => setFormData({ ...formData, nationality: e.target.value })}
            placeholder="Страна"
            className="h-8"
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">SSN</Label>
          <Input
            value={formData.ssn || ''}
            onChange={(e) => setFormData({ ...formData, ssn: e.target.value })}
            placeholder="XXX-XX-XXXX"
            className="h-8 font-mono"
          />
        </div>
        <div>
          <Label className="text-xs">ТЕЛЕФОН</Label>
          <Input
            value={formData.phoneNumber || ''}
            onChange={(e) => setFormData({ ...formData, phoneNumber: e.target.value })}
            placeholder="+1 555..."
            className="h-8"
          />
        </div>
      </div>

      <div>
        <Label className="text-xs">АДРЕС</Label>
        <Input
          value={formData.address || ''}
          onChange={(e) => setFormData({ ...formData, address: e.target.value })}
          placeholder="Адрес проживания"
          className="h-8"
        />
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">ГОРОД</Label>
          <Input
            value={formData.city || ''}
            onChange={(e) => setFormData({ ...formData, city: e.target.value })}
            placeholder="Город"
            className="h-8"
          />
        </div>
        <div>
          <Label className="text-xs">ИНДЕКС</Label>
          <Input
            value={formData.postalCode || ''}
            onChange={(e) => setFormData({ ...formData, postalCode: e.target.value })}
            placeholder="XXXXX"
            className="h-8"
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">EMAIL</Label>
          <Input
            value={formData.email || ''}
            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
            placeholder="email@mail.com"
            className="h-8"
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">РАБОТА</Label>
          <Input
            value={formData.occupation || ''}
            onChange={(e) => setFormData({ ...formData, occupation: e.target.value })}
            placeholder="Профессия"
            className="h-8"
          />
        </div>
        <div>
          <Label className="text-xs">РАБОТОДАТЕЛЬ</Label>
          <Input
            value={formData.employer || ''}
            onChange={(e) => setFormData({ ...formData, employer: e.target.value })}
            placeholder="Компания"
            className="h-8"
          />
        </div>
      </div>

      <div className="border-t pt-3">
        <Label className="text-xs text-muted-foreground mb-2 block">ВНЕШНОСТЬ</Label>
        <div className="grid grid-cols-4 gap-2">
          <div>
            <Label className="text-[10px]">ВОЛОСЫ</Label>
            <Input
              value={formData.hairColor || ''}
              onChange={(e) => setFormData({ ...formData, hairColor: e.target.value })}
              placeholder="Цвет"
              className="h-7 text-xs"
            />
          </div>
          <div>
            <Label className="text-[10px]">ГЛАЗА</Label>
            <Input
              value={formData.eyeColor || ''}
              onChange={(e) => setFormData({ ...formData, eyeColor: e.target.value })}
              placeholder="Цвет"
              className="h-7 text-xs"
            />
          </div>
          <div>
            <Label className="text-[10px]">РОСТ</Label>
            <Input
              type="number"
              value={formData.height || ''}
              onChange={(e) => setFormData({ ...formData, height: parseInt(e.target.value) || undefined })}
              placeholder="см"
              className="h-7 text-xs"
            />
          </div>
          <div>
            <Label className="text-[10px]">ВЕС</Label>
            <Input
              type="number"
              value={formData.weight || ''}
              onChange={(e) => setFormData({ ...formData, weight: parseInt(e.target.value) || undefined })}
              placeholder="кг"
              className="h-7 text-xs"
            />
          </div>
        </div>
      </div>

      <div className="border-t pt-3">
        <Label className="text-xs text-muted-foreground mb-2 block">ЛИЦЕНЗИИ</Label>
        <div className="flex flex-wrap gap-2">
          <button
            type="button"
            onClick={() => setFormData({ ...formData, driversLicense: !formData.driversLicense })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.driversLicense 
                ? 'bg-green-500/20 text-green-500 border border-green-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            DL
          </button>
          <button
            type="button"
            onClick={() => setFormData({ ...formData, weaponsLicense: !formData.weaponsLicense })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.weaponsLicense 
                ? 'bg-red-500/20 text-red-500 border border-red-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            CCW
          </button>
          <button
            type="button"
            onClick={() => setFormData({ ...formData, pilotLicense: !formData.pilotLicense })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.pilotLicense 
                ? 'bg-blue-500/20 text-blue-500 border border-blue-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            PPL
          </button>
          <button
            type="button"
            onClick={() => setFormData({ ...formData, commercialLicense: !formData.commercialLicense })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.commercialLicense 
                ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            CDL
          </button>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div>
          <Label className="text-xs">НОМЕР DL</Label>
          <Input
            value={formData.licenseNumber || ''}
            onChange={(e) => setFormData({ ...formData, licenseNumber: e.target.value })}
            placeholder="Номер прав"
            className="h-8"
          />
        </div>
        <div>
          <Label className="text-xs">ГОРУППА КРОВИ</Label>
          <Select value={formData.bloodType || ''} onValueChange={(v) => setFormData({ ...formData, bloodType: v })}>
            <SelectTrigger className="h-8">
              <SelectValue placeholder="Группа" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="A+">A+</SelectItem>
              <SelectItem value="A-">A-</SelectItem>
              <SelectItem value="B+">B+</SelectItem>
              <SelectItem value="B-">B-</SelectItem>
              <SelectItem value="AB+">AB+</SelectItem>
              <SelectItem value="AB-">AB-</SelectItem>
              <SelectItem value="O+">O+</SelectItem>
              <SelectItem value="O-">O-</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      <div>
        <Label className="text-xs">АЛЛЕРГИИ</Label>
        <Input
          value={formData.allergies || ''}
          onChange={(e) => setFormData({ ...formData, allergies: e.target.value })}
          placeholder="Аллергии"
          className="h-8"
        />
      </div>

      <div className="border-t pt-3">
        <Label className="text-xs text-muted-foreground mb-2 block">СТАТУС</Label>
        <div className="flex flex-wrap gap-2">
          <button
            type="button"
            onClick={() => setFormData({ ...formData, isDead: !formData.isDead })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.isDead 
                ? 'bg-gray-500/20 text-gray-400 border border-gray-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            МЁРТВ
          </button>
          <button
            type="button"
            onClick={() => setFormData({ ...formData, isMissing: !formData.isMissing })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.isMissing 
                ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            ПРОПАЛ
          </button>
          <button
            type="button"
            onClick={() => setFormData({ ...formData, isWanted: !formData.isWanted })}
            className={`px-3 py-1.5 rounded-md text-xs font-mono transition-all ${
              formData.isWanted 
                ? 'bg-orange-500/20 text-orange-500 border border-orange-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            РОЗЫСК
          </button>
        </div>
        {formData.isWanted && (
          <div className="mt-2">
            <Input
              value={formData.wantedReason || ''}
              onChange={(e) => setFormData({ ...formData, wantedReason: e.target.value })}
              placeholder="Причина розыска..."
              className="h-8"
            />
          </div>
        )}
      </div>

      <div className="border-t pt-3">
        <Label className="text-xs text-muted-foreground mb-2 block">ЗАМЕТКИ</Label>
        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="text-xs">БИОГРАФИЯ</Label>
            <Input
              value={formData.biography || ''}
              onChange={(e) => setFormData({ ...formData, biography: e.target.value })}
              placeholder="Краткая биография"
              className="h-8"
            />
          </div>
          <div>
            <Label className="text-xs">ЗАМЕТКИ</Label>
            <Input
              value={formData.notes || ''}
              onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
              placeholder="Заметки"
              className="h-8"
            />
          </div>
        </div>
      </div>

      {mode === 'edit' && (
        <div className="border-t pt-3">
          <button
            type="button"
            onClick={() => setFormData({ ...formData, isOfficer: !formData.isOfficer })}
            className={`px-4 py-2 rounded-md text-xs font-mono transition-all ${
              formData.isOfficer 
                ? 'bg-blue-500/20 text-blue-500 border border-blue-500/50' 
                : 'bg-muted/50 text-muted-foreground border border-transparent hover:bg-muted'
            }`}
          >
            {formData.isOfficer ? 'ОФИЦЕР' : 'ГРАЖДАНИН'}
          </button>

          {formData.isOfficer && (
            <div className="grid grid-cols-2 gap-3 mt-3">
              <div>
                <Label className="text-xs">ДЕПАРТАМЕНТ</Label>
                <Select value={formData.officerDepartmentId || ''} onValueChange={(v) => setFormData({ ...formData, officerDepartmentId: v })}>
                  <SelectTrigger className="h-8">
                    <SelectValue placeholder="Департамент" />
                  </SelectTrigger>
                  <SelectContent>
                    {departments.map((dept) => (
                      <SelectItem key={dept.id} value={dept.id}>
                        {dept.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label className="text-xs">ЗВАНИЕ</Label>
                <Input
                  value={formData.departmentRank || ''}
                  onChange={(e) => setFormData({ ...formData, departmentRank: e.target.value })}
                  placeholder="Звание"
                  className="h-8"
                />
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );

  const isFormMode = mode === 'create' || mode === 'edit';
  const title = mode === 'create' ? '+ ГРАЖДАНИН' : mode === 'edit' ? '~ ГРАЖДАНИН' : 'ГРАЖДАНИН';

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-xl max-h-[90vh]">
        <DialogHeader className="pb-2 border-b">
          <DialogTitle className="text-sm font-mono">{title}</DialogTitle>
        </DialogHeader>

        {isFormMode ? renderFormMode() : renderViewMode()}

        <DialogFooter className="pt-2 border-t">
          {isFormMode ? (
            <>
              <Button variant="outline" onClick={() => onOpenChange(false)} className="h-8 text-xs font-mono">
                ОТМЕНА
              </Button>
              <Button onClick={handleSubmit} disabled={isSubmitting} className="h-8 text-xs font-mono">
                {isSubmitting ? '...' : mode === 'create' ? 'СОЗДАТЬ' : 'СОХРАНИТЬ'}
              </Button>
            </>
          ) : (
            <>
              {extraActions}
              <Button variant="outline" onClick={() => onOpenChange(false)} className="h-8 text-xs font-mono">
                ЗАКРЫТЬ
              </Button>
            </>
          )}
        </DialogFooter>
      </DialogContent>

      {/* Create Vehicle Dialog */}
      <Dialog open={showCreateVehicle} onOpenChange={setShowCreateVehicle}>
        <DialogContent className="max-w-sm">
          <DialogHeader>
            <DialogTitle className="text-sm font-mono">+ ТРАНСПОРТ</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="text-xs">МОДЕЛЬ</Label>
              <Input value={newVehicle.model} onChange={e => setNewVehicle({...newVehicle, model: e.target.value})} placeholder="BMW X5" className="h-8" />
            </div>
            <div>
              <Label className="text-xs">ГОСНОМЕР</Label>
              <Input value={newVehicle.plate} onChange={e => setNewVehicle({...newVehicle, plate: e.target.value.toUpperCase()})} placeholder="ABC123" className="h-8 font-mono" />
            </div>
            <div className="grid grid-cols-2 gap-2">
              <div>
                <Label className="text-xs">ЦВЕТ</Label>
                <Input value={newVehicle.color} onChange={e => setNewVehicle({...newVehicle, color: e.target.value})} placeholder="Чёрный" className="h-8" />
              </div>
              <div>
                <Label className="text-xs">ТИП</Label>
                <Select value={newVehicle.type} onValueChange={v => setNewVehicle({...newVehicle, type: v})}>
                  <SelectTrigger className="h-8"><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="car">Авто</SelectItem>
                    <SelectItem value="motorcycle">Мото</SelectItem>
                    <SelectItem value="boat">Лодка</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div>
              <Label className="text-xs">ФОТО</Label>
              <div className="flex items-center gap-2">
                <label className="flex-1 cursor-pointer">
                  <input type="file" accept="image/*" className="hidden" onChange={handleVehiclePhotoUpload} />
                  <div className="h-16 bg-muted border rounded flex items-center justify-center hover:bg-muted/80 transition-colors text-xs text-muted-foreground">
                    {vehiclePhotoPreview || newVehicle.photo ? (
                      <img src={vehiclePhotoPreview || newVehicle.photo} alt="Vehicle" className="h-full object-contain rounded" />
                    ) : (
                      'Загрузить фото'
                    )}
                  </div>
                </label>
                {(vehiclePhotoPreview || newVehicle.photo) && (
                  <Button variant="outline" size="sm" onClick={removeVehiclePhoto} className="h-8 w-8 p-0">✕</Button>
                )}
              </div>
            </div>
            <div>
              <Label className="text-xs">ОСОБЕННОСТИ</Label>
              <Input value={newVehicle.features} onChange={e => setNewVehicle({...newVehicle, features: e.target.value})} placeholder="Тюнинг, повреждения..." className="h-8" />
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowCreateVehicle(false)} className="h-8 text-xs">ОТМЕНА</Button>
            <Button onClick={handleCreateVehicle} disabled={isCreating} className="h-8 text-xs">ДОБАВИТЬ</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Create Weapon Dialog */}
      <Dialog open={showCreateWeapon} onOpenChange={setShowCreateWeapon}>
        <DialogContent className="max-w-sm">
          <DialogHeader>
            <DialogTitle className="text-sm font-mono">+ ОРУЖИЕ</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="text-xs">НАЗВАНИЕ</Label>
              <Input value={newWeapon.name} onChange={e => setNewWeapon({...newWeapon, name: e.target.value})} placeholder="Glock 19" className="h-8" />
            </div>
            <div>
              <Label className="text-xs">ТИП</Label>
              <Input value={newWeapon.type} onChange={e => setNewWeapon({...newWeapon, type: e.target.value})} placeholder="Пистолет" className="h-8" />
            </div>
            <div>
              <Label className="text-xs">СЕРИЙНИК</Label>
              <Input value={newWeapon.serialNumber} onChange={e => setNewWeapon({...newWeapon, serialNumber: e.target.value.toUpperCase()})} placeholder="SN123456" className="h-8 font-mono" />
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowCreateWeapon(false)} className="h-8 text-xs">ОТМЕНА</Button>
            <Button onClick={handleCreateWeapon} disabled={isCreating} className="h-8 text-xs">ДОБАВИТЬ</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </Dialog>
  );
}
