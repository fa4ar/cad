'use client';

import { useEffect, useState, useCallback } from 'react';
import { useRouter } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { CivilianModal } from '@/components/CivilianModal';
import { useSocket } from '@/hooks/useSocket';
import { useLanguage } from '@/hooks/useLanguage';
import { toast } from 'sonner';
import api from '@/lib/api/axios';
import { sounds } from '@/lib/sounds';
import { 
    Search, 
    Shield, 
    AlertTriangle, 
    Clock, 
    MapPin,
    Car,
    User,
    Users,
    Activity,
    Radio,
    Target,
    CheckCircle,
    XCircle,
    Eye,
    FileText,
    Key,
    Power,
    LogOut,
    Mic,
    MicOff,
    Volume2,
    VolumeX,
    Bell,
    TrendingUp,
    Wifi,
    WifiOff,
    Plus,
    Trash2,
    Edit,
    DollarSign,
    UserMinus,
    AlertCircle
} from 'lucide-react';

const getUploadUrl = (path: string | null | undefined): string | undefined => {
  if (!path) return undefined;
  let baseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
  baseUrl = baseUrl.replace('/api', '');
  return path.startsWith('http') ? path : `${baseUrl}${path}`;
};

interface Call {
  id: string;
  type: "911" | "traffic" | "crime" | "medical" | "fire" | "other";
  priority: "low" | "medium" | "high" | "critical";
  status:
    | "pending"
    | "dispatched"
    | "enroute"
    | "on_scene"
    | "completed"
    | "cancelled";
  location: string;
  description: string;
  callerName?: string;
  callerPhone?: string;
  assignedUnits: string[];
  createdAt: string;
  logs?: CallLog[];
}

interface ShiftSchedule {
  id: string;
  unitId: string;
  date: string;
  startTime: string;
  endTime: string;
}

interface CallLog {
    id: string;
    type: string;
    logType: string;
    content: string;
    authorCallsign?: string;
    authorId?: string;
    authorName?: string;
    createdAt: string;
}

interface Unit {
    id: string;
    callsign: string;
    name: string;
    type: 'police' | 'ems' | 'fire' | 'civilian' | 'other';
    status: 'available' | 'busy' | 'enroute' | 'on_scene' | 'off_duty';
    department?: string;
    currentCallId?: string;
    onDuty: boolean;
}

const getUnitCallsign = (unitId: string, unitsList: any[]): string => {
    const unit = unitsList.find(u => u.id === unitId);
    return unit?.callsign || unitId;
};

interface ShiftLog {
    id: string;
    unitId: string;
    officerId: string;
    officerName: string;
    startTime: string;
    endTime?: string;
    status: 'active' | 'completed';
}

interface ResponseTime {
    hour: number;
    avgTime: number;
    callCount: number;
}

const priorityMap: Record<string, string> = {
    critical: 'P1-CRIT',
    high: 'P2-URG',
    medium: 'P3-RPT',
    low: 'P4-RPT'
};

const priorityColors: Record<string, string> = {
    critical: 'border-red-500 text-red-500 bg-red-500/10',
    high: 'border-orange-500 text-orange-500 bg-orange-500/10',
    medium: 'border-yellow-500 text-yellow-500 bg-yellow-500/10',
    low: 'border-blue-500 text-blue-500 bg-blue-500/10'
};

const statusMap: Record<string, string> = {
    pending: 'QUEUED',
    dispatched: 'DISPATCHED',
    enroute: 'EN ROUTE',
    on_scene: 'ON SCENE',
    completed: 'CLEARED',
    cancelled: 'CANCELLED'
};

const statusColors: Record<string, string> = {
    pending: 'text-muted-foreground',
    dispatched: 'text-red-500',
    enroute: 'text-yellow-500',
    on_scene: 'text-green-500',
    completed: 'text-gray-500',
    cancelled: 'text-gray-500'
};

const unitStatusMap: Record<string, string> = {
    available: 'AVAIL',
    busy: 'BUSY',
    enroute: 'ROUTE',
    on_scene: 'SCENE',
    off_duty: 'OFF DUTY'
};

const unitStatusColors: Record<string, string> = {
    available: 'bg-green-500',
    busy: 'bg-red-500',
    enroute: 'bg-yellow-500',
    on_scene: 'bg-blue-500',
    off_duty: 'bg-gray-500'
};

const unitTypeIcons: Record<string, string> = {
    police: 'PATROL',
    ems: 'EMS',
    fire: 'FIRE',
    other: 'UNIT'
};

interface Officer {
    id: string;
    badgeNumber?: string;
    officerRank?: string;
    callsign?: string;
    department: { name: string };
    character: { id: string; firstName: string; lastName: string };
}

export default function PolicePage() {
    const router = useRouter();
    const { t } = useLanguage();
    const [currentTime, setCurrentTime] = useState('');
    const [isOnDuty, setIsOnDuty] = useState(false);
    const [myStatus, setMyStatus] = useState('off_duty');
    const [myUnit, setMyUnit] = useState<Unit | null>(null);
    const [myCallsign, setMyCallsign] = useState('');
    const [myOfficerId, setMyOfficerId] = useState<string | null>(null);
    const [officers, setOfficers] = useState<Officer[]>([]);
    const [searchType, setSearchType] = useState('');
    const [showSearchFields, setShowSearchFields] = useState(false);
    const [calls, setCalls] = useState<Call[]>([]);
    const [units, setUnits] = useState<Unit[]>([]);
    const [myCall, setMyCall] = useState<Call | null>(null);
    const [selectedCall, setSelectedCall] = useState<Call | null>(null);
    const [callLogs, setCallLogs] = useState<CallLog[]>([]);
    const [newMessage, setNewMessage] = useState('');
    const [showCallModal, setShowCallModal] = useState(false);
    const [shiftLogs, setShiftLogs] = useState<ShiftLog[]>([]);
    const [responseTimes, setResponseTimes] = useState<ResponseTime[]>([]);
    const [isRadioOn, setIsRadioOn] = useState(true);
    const [isMuted, setIsMuted] = useState(false);
    const [showCallsignDialog, setShowCallsignDialog] = useState(false);
    const [tempCallsign, setTempCallsign] = useState('');
    const [tempOfficerId, setTempOfficerId] = useState('');
    
    const [searchForm, setSearchForm] = useState({
        firstName: '',
        lastName: '',
        dobDay: '',
        dobMonth: '',
        dobYear: ''
    });
    
    const [searchTerm, setSearchTerm] = useState('');
    const [searchResults, setSearchResults] = useState<any[]>([]);
    const [showPanicDialog, setShowPanicDialog] = useState(false);
    const [showWarrantDialog, setShowWarrantDialog] = useState(false);

    const [activeTab, setActiveTab] = useState<'calls' | 'search'>('calls');
    const [searchCategory, setSearchCategory] = useState<'citizens' | 'vehicles' | 'weapons' | 'warrants'>('citizens');
    const [searchQuery, setSearchQuery] = useState<{
        firstName: string;
        lastName: string;
        dobDay: string;
        dobMonth: string;
        dobYear: string;
        plate: string;
        serialNumber: string;
        model: string;
        ownerName: string;
        phone: string;
        ssn: string;
    }>({
        firstName: '',
        lastName: '',
        dobDay: '',
        dobMonth: '',
        dobYear: '',
        plate: '',
        serialNumber: '',
        model: '',
        ownerName: '',
        phone: '',
        ssn: ''
    });
    const [searchResults2, setSearchResults2] = useState<any[]>([]);
    const [isSearching, setIsSearching] = useState(false);
    const [selectedResult, setSelectedResult] = useState<any>(null);
    const [showSearchModal, setShowSearchModal] = useState(false);
    const [selectedCitizenForWarrant, setSelectedCitizenForWarrant] = useState<any>(null);
    const [myDivision, setMyDivision] = useState<{id: string; name: string; isDetective: boolean} | null>(null);
    const [newWarrant, setNewWarrant] = useState({
        type: 'arrest' as 'arrest' | 'search',
        reason: '',
        description: '',
        address: '',
        issuingOfficer: ''
    });
    const [showFineDialog, setShowFineDialog] = useState(false);
    const [selectedCitizenForFine, setSelectedCitizenForFine] = useState<any>(null);
    const [newFine, setNewFine] = useState({
        amount: '',
        reason: '',
        description: '',
        article: '',
        incidentDate: '',
        incidentTime: ''
    });
    const [showArrestDialog, setShowArrestDialog] = useState(false);
    const [selectedCitizenForArrest, setSelectedCitizenForArrest] = useState<any>(null);
    const [newArrest, setNewArrest] = useState({
        reason: '',
        description: '',
        articles: '',
        bailAmount: ''
    });
    const [showFineDetailDialog, setShowFineDetailDialog] = useState(false);
    const [selectedFine, setSelectedFine] = useState<any>(null);
    const [showArrestDetailDialog, setShowArrestDetailDialog] = useState(false);
    const [selectedArrest, setSelectedArrest] = useState<any>(null);
    const [showWarrantDetailDialog, setShowWarrantDetailDialog] = useState(false);
    const [selectedWarrant, setSelectedWarrant] = useState<any>(null);

    const { isConnected, on, off, emit } = useSocket();

    useEffect(() => {
        const fetchDutyStatus = async () => {
            try {
                const [dutyRes, officersRes] = await Promise.all([
                    api.get('/auth/duty'),
                    api.get('/auth/officers')
                ]);
                setOfficers(officersRes.data);
                
                if (dutyRes.data) {
                    setMyCallsign(dutyRes.data.callsign);
                    setMyOfficerId(dutyRes.data.officerId);
                    setIsOnDuty(true);
                    setMyStatus(dutyRes.data.status);
                    
                    if (dutyRes.data.officer?.division) {
                        setMyDivision({
                            id: dutyRes.data.officer.division.id,
                            name: dutyRes.data.officer.division.name,
                            isDetective: dutyRes.data.officer.division.isDetective || false
                        });
                    }
                }
            } catch (error) {
                console.error('Error fetching duty status:', error);
            }
        };
        fetchDutyStatus();
    }, []);

    const fetchData = useCallback(async () => {
        try {
            const [callsRes, unitsRes, timesRes] = await Promise.all([
                api.get('/character/emergency-calls?status=all'),
                api.get('/leo/active-officers'),
                api.get('/dispatch/response-times')
            ]);
            setCalls(callsRes.data.calls || callsRes.data);
            setUnits(unitsRes.data.map((u: any) => ({
                id: u.id,
                callsign: u.callsign,
                status: u.status,
                type: u.type,
                name: u.firstName ? `${u.firstName} ${u.lastName || ''}`.trim() : u.callsign,
                onDuty: true,
                department: u.department?.name
            })));
            setResponseTimes(timesRes.data);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }, []);

    useEffect(() => {
        fetchData();
        const interval = setInterval(fetchData, 10000);
        return () => clearInterval(interval);
    }, [fetchData]);

    useEffect(() => {
        const updateTime = () => {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            setCurrentTime(`${hours}:${minutes}:${seconds}`);
        };
        updateTime();
        const interval = setInterval(updateTime, 1000);
        return () => clearInterval(interval);
    }, []);

    useEffect(() => {
        if (!isConnected) return;

        if (myUnit?.id) {
            emit('join-police', myUnit.id);
        }

        on('new-call', (newCall: Call) => {
            setCalls(prev => [newCall, ...prev]);
            if (isOnDuty && isRadioOn && !isMuted) {
                toast.info(`NEW CALL: ${newCall.type.toUpperCase()}`, {
                    description: newCall.description
                });
            }
        });

        on('call-created', (newCall: Call) => {
            setCalls(prev => [newCall, ...prev]);
            if (isOnDuty && isRadioOn && !isMuted) {
                toast.info(`NEW CALL: ${newCall.type.toUpperCase()}`, {
                    description: newCall.description
                });
            }
        });

        on('call-updated', (updatedCall: Call) => {
            setCalls(prev => prev.map(c => c.id === updatedCall.id ? updatedCall : c));
            if (myCall?.id === updatedCall.id) {
                setMyCall(updatedCall);
            }
        });

        on('assigned-call', (data: { callId: string; unitId: string; call: Call }) => {
            if (myUnit && data.unitId === myUnit.id) {
                setMyCall(data.call);
                toast.success(`ASSIGNED: ${data.call.type.toUpperCase()}`, {
                    description: data.call.location
                });
                if (isRadioOn && !isMuted) {
                }
            }
        });

        on('schedule-updated', (data: ShiftSchedule) => {
            if (myUnit && data.unitId === myUnit.id) {
                fetchData();
            }
        });

        on('call-log-added', (data: { callId: string; log: CallLog }) => {
            if (selectedCall?.id === data.callId && data.log.logType === 'user') {
                setCallLogs(prev => [...prev, data.log]);
            }
            fetchData();
        });

        on('call-note-added', (data: { callId: string; log: CallLog }) => {
            if (selectedCall?.id === data.callId && data.log.logType === 'user') {
                setCallLogs(prev => [...prev, data.log]);
            }
            fetchData();
        });

        return () => {
            if (myUnit?.id) {
                emit('leave-police', myUnit.id);
            }
            off('new-call');
            off('call-created');
            off('call-updated');
            off('assigned-call');
            off('schedule-updated');
            off('call-log-added');
            off('call-note-added');
        };
    }, [isConnected, on, off, emit, isOnDuty, isRadioOn, isMuted, myCall, myUnit, selectedCall, fetchData]);

    const handleStartShiftClick = () => {
        setTempCallsign('');
        setTempOfficerId('');
        setShowCallsignDialog(true);
    };

    const handleOfficerSelect = (officerId: string) => {
        setTempOfficerId(officerId);
        const selectedOfficer = officers.find(o => o.id === officerId);
        if (selectedOfficer?.callsign) {
            setTempCallsign(selectedOfficer.callsign);
        } else if (selectedOfficer?.badgeNumber) {
            setTempCallsign(selectedOfficer.badgeNumber);
        } else if (selectedOfficer?.character) {
            const initials = `${selectedOfficer.character.firstName.charAt(0)}${selectedOfficer.character.lastName.charAt(0)}`;
            setTempCallsign(`${initials}-${Math.floor(Math.random() * 100)}`);
        }
    };

    const handleConfirmCallsign = async () => {
        if (!tempOfficerId) {
            toast.warning('Выберите офицера');
            return;
        }
        const selectedOfficer = officers.find(o => o.id === tempOfficerId);
        
        try {
            const response = await api.post('/auth/duty/start', {
                officerId: tempOfficerId,
                type: 'police'
            });
            const shiftData = response.data;
            setMyCallsign(shiftData.callsign);
            setMyOfficerId(tempOfficerId);
            setIsOnDuty(true);
            setMyStatus('available');
            fetchData();
            setShowCallsignDialog(false);
            setTempCallsign('');
            setTempOfficerId('');
            toast.success(`Смена начата. Позывной: ${shiftData.callsign}`);
        } catch (error: any) {
            if (error.response?.data?.error) {
                toast.error(error.response.data.error);
            } else {
                toast.error('Ошибка начала смены');
            }
        }
    };

    const handleEndShift = async () => {
        try {
            await api.post('/auth/duty/end');
            setIsOnDuty(false);
            setMyStatus('off_duty');
            setMyCall(null);
            setMyUnit(null);
            setMyCallsign('');
            fetchData();
            toast.success('Смена завершена');
        } catch (error) {
            toast.error('Ошибка завершения смены');
        }
    };

    const handleStatusChange = async (newStatus: string) => {
        if (!isOnDuty) {
            toast.warning('Вы не на смене');
            return;
        }
        
        try {
            await api.put('/auth/duty/status', { status: newStatus });
            setMyStatus(newStatus);
            fetchData();
            
            emit('unit-status-change', {
                callsign: myCallsign,
                status: newStatus,
                officerId: 'current_user'
            });
            
            toast.success(`Status: ${unitStatusMap[newStatus as keyof typeof unitStatusMap]}`);
        } catch (error) {
            toast.error('Failed to update status');
        }
    };

    const handlePanicButton = () => {
        setShowPanicDialog(true);
    };

    const confirmPanic = async () => {
        try {
            emit('panic-button', {
                callsign: myCallsign,
                officerId: 'current_user',
                location: myCall?.location || 'Unknown'
            });
            toast.error('PANIC BUTTON ACTIVATED!');
            setShowPanicDialog(false);
        } catch (error) {
            console.error('Panic error:', error);
        }
    };

    const handleAcceptCall = async (callId: string) => {
        try {
            if (myUnit) {
                await api.post(`/dispatch/calls/${callId}/assign`, { unitIds: [myUnit.id] });
            }
            fetchData();
            toast.success('Call accepted');
        } catch (error) {
            toast.error('Error accepting call');
        }
    };

    const handleCompleteCall = async () => {
        if (!myCall) return;
        
        try {
            await api.put(`/dispatch/calls/${myCall.id}`, { status: 'completed' });
            if (myUnit) {
                await api.put(`/dispatch/units/${myUnit.id}`, { status: 'available', currentCallId: null });
            }
            setMyCall(null);
            setMyStatus('available');
            fetchData();
            toast.success('Call completed');
        } catch (error) {
            toast.error('Error completing call');
        }
    };

    const fetchCallLogs = async (callId: string) => {
        try {
            const res = await api.get(`/call-logs/${callId}?logType=user`);
            setCallLogs(res.data.logs || []);
        } catch (error) {
            console.error('Error fetching call logs:', error);
        }
    };

    const handleOpenCallModal = (call: Call) => {
        setSelectedCall(call);
        fetchCallLogs(call.id);
        setShowCallModal(true);
    };

    const handleSendMessage = async () => {
        if (!selectedCall || !newMessage.trim()) return;
        
        try {
            await api.post(`/call-logs/${selectedCall.id}/note`, {
                content: newMessage.trim(),
                authorCallsign: myCallsign
            });
            setNewMessage('');
            fetchCallLogs(selectedCall.id);
        } catch (error) {
            toast.error('Ошибка отправки');
        }
    };

    const handleSelfAssign = async () => {
        if (!selectedCall || !myUnit) return;
        
        try {
            const updatedUnits = [...(selectedCall.assignedUnits || []), myUnit.id];
            await api.put(`/character/emergency-calls/${selectedCall.id}`, { assignedUnits: updatedUnits });
            fetchCallLogs(selectedCall.id);
            fetchData();
            toast.success('Вы назначены на вызов');
        } catch (error) {
            toast.error('Ошибка назначения');
        }
    };

    const handleSelfUnassign = async () => {
        if (!selectedCall || !myUnit) return;
        
        try {
            const updatedUnits = (selectedCall.assignedUnits || []).filter(id => id !== myUnit.id);
            await api.put(`/character/emergency-calls/${selectedCall.id}`, { assignedUnits: updatedUnits });
            fetchCallLogs(selectedCall.id);
            fetchData();
            toast.success('Вы сняты с вызова');
        } catch (error) {
            toast.error('Ошибка');
        }
    };

    const handleUpdateCallStatus = async (callId: string, status: string) => {
        try {
            await api.put(`/character/emergency-calls/${callId}`, { status });
            fetchCallLogs(callId);
            fetchData();
            toast.success('Статус обновлён');
        } catch (error) {
            toast.error('Ошибка обновления');
        }
    };

    const handleSearch = async () => {
        setIsSearching(true);
        setSearchResults2([]);
        
        const hasSearchField = () => {
            switch (searchCategory) {
                case 'citizens':
                    return searchQuery.firstName || searchQuery.lastName || 
                           (searchQuery.dobDay && searchQuery.dobMonth && searchQuery.dobYear);
                case 'vehicles':
                    return searchQuery.plate || searchQuery.model || searchQuery.ownerName;
                case 'weapons':
                    return searchQuery.serialNumber || searchQuery.ownerName;
                case 'warrants':
                    return true;
                default:
                    return false;
            }
        };

        if (!hasSearchField()) {
            toast.error('Заполните хотя бы одно поле для поиска');
            setIsSearching(false);
            return;
        }
        
        try {
            let endpoint = '';
            let params = new URLSearchParams();
            
            switch (searchCategory) {
                case 'citizens':
                    endpoint = '/leo/search/citizens';
                    if (searchQuery.firstName) params.append('firstName', searchQuery.firstName);
                    if (searchQuery.lastName) params.append('lastName', searchQuery.lastName);
                    if (searchQuery.dobDay && searchQuery.dobMonth && searchQuery.dobYear) {
                        params.append('dobDay', searchQuery.dobDay);
                        params.append('dobMonth', searchQuery.dobMonth);
                        params.append('dobYear', searchQuery.dobYear);
                    }
                    break;
                case 'vehicles':
                    endpoint = '/leo/search/vehicles';
                    if (searchQuery.plate) params.append('plate', searchQuery.plate);
                    break;
                case 'weapons':
                    endpoint = '/leo/search/weapons';
                    if (searchQuery.serialNumber) params.append('serialNumber', searchQuery.serialNumber);
                    break;
                case 'warrants':
                    endpoint = '/leo/search/warrants';
                    break;
            }
            
            const res = await api.get(`${endpoint}?${params.toString()}`);
            
            if (searchCategory === 'citizens') {
                setSearchResults2(res.data.citizens || []);
                if (res.data.citizens?.length > 0) sounds.success();
                else sounds.error();
            } else if (searchCategory === 'vehicles') {
                setSearchResults2(res.data.vehicles || []);
                if (res.data.vehicles?.length > 0) sounds.success();
                else sounds.error();
            } else if (searchCategory === 'weapons') {
                setSearchResults2(res.data.weapons || []);
                if (res.data.weapons?.length > 0) sounds.success();
                else sounds.error();
            } else if (searchCategory === 'warrants') {
                setSearchResults2(res.data.warrants || []);
                if (res.data.warrants?.length > 0) sounds.success();
                else sounds.error();
            }
        } catch (error) {
            console.error('Search error:', error);
            sounds.error();
            toast.error('Ошибка поиска');
        } finally {
            setIsSearching(false);
        }
    };

    const handleViewDetails = async (result: any) => {
        try {
            let endpoint = '';
            switch (searchCategory) {
                case 'citizens':
                    endpoint = `/leo/search/citizens/${result.id}`;
                    break;
                case 'vehicles':
                    endpoint = `/leo/search/vehicles/${result.id}`;
                    break;
                case 'weapons':
                    endpoint = `/leo/search/weapons/${result.id}`;
                    break;
            }
            
            if (endpoint) {
                const res = await api.get(endpoint);
                setSelectedResult(res.data.citizen || res.data.vehicle || res.data.weapon);
                setShowSearchModal(true);
            }
        } catch (error) {
            console.error('Error getting details:', error);
            toast.error('Ошибка получения деталей');
        }
    };

    const handleCreateWarrant = async () => {
        if (!selectedCitizenForWarrant || !newWarrant.reason) return;
        
        try {
            const prefix = newWarrant.type === 'arrest' ? 'WRA' : 'WRS';
            await api.post('/character/warrants', {
                characterId: selectedCitizenForWarrant.id,
                title: newWarrant.type === 'arrest' ? 'Arrest Warrant' : 'Search Warrant',
                reason: newWarrant.reason,
                description: newWarrant.description,
                warrantType: prefix
            });
            
            toast.success('Ордер создан');
            setShowWarrantDialog(false);
            setSelectedCitizenForWarrant(null);
            setNewWarrant({ type: 'arrest', reason: '', description: '', address: '', issuingOfficer: '' });
            
            if (searchCategory === 'citizens') {
                handleSearch();
            } else if (searchCategory === 'warrants') {
                handleSearch();
            }
        } catch (error) {
            console.error('Error creating warrant:', error);
            toast.error('Ошибка создания ордера');
        }
    };

    const handleCreateFine = async () => {
        if (!selectedCitizenForFine || !newFine.reason || !newFine.amount) return;
        
        try {
            await api.post(`/character/characters/${selectedCitizenForFine.id}/fines`, {
                amount: parseFloat(newFine.amount),
                reason: newFine.reason,
                description: newFine.description,
                article: newFine.article,
                incidentDate: newFine.incidentDate || new Date().toISOString().split('T')[0],
                incidentTime: newFine.incidentTime || new Date().toTimeString().slice(0, 5)
            });
            
            toast.success('Штраф создан');
            setShowFineDialog(false);
            setSelectedCitizenForFine(null);
            setNewFine({ amount: '', reason: '', description: '', article: '', incidentDate: '', incidentTime: '' });
            
            if (selectedResult && selectedResult.id === selectedCitizenForFine.id) {
                handleViewDetails(selectedCitizenForFine);
            }
        } catch (error) {
            console.error('Error creating fine:', error);
            toast.error('Ошибка создания штрафа');
        }
    };

    const handleCreateArrest = async () => {
        if (!selectedCitizenForArrest || !newArrest.reason) return;
        
        try {
            await api.post(`/character/characters/${selectedCitizenForArrest.id}/arrests`, {
                reason: newArrest.reason,
                description: newArrest.description,
                articles: newArrest.articles,
                bailAmount: newArrest.bailAmount ? parseFloat(newArrest.bailAmount) : null
            });
            
            toast.success('Арест зарегистрирован');
            setShowArrestDialog(false);
            setSelectedCitizenForArrest(null);
            setNewArrest({ reason: '', description: '', articles: '', bailAmount: '' });
            
            if (selectedResult && selectedResult.id === selectedCitizenForArrest.id) {
                handleViewDetails(selectedCitizenForArrest);
            }
        } catch (error) {
            console.error('Error creating arrest:', error);
            toast.error('Ошибка регистрации ареста');
        }
    };

    const formatTime = (dateStr: string) => {
        const date = new Date(dateStr);
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return `${hours}:${minutes}`;
    };

    const formatDate = () => {
        const now = new Date();
        return now.toISOString().split('T')[0];
    };

    const formatResponseTime = (seconds: number) => {
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${mins}m ${secs}s`;
    };

    const activeCalls = calls.filter(c => c.status !== 'completed' && c.status !== 'cancelled' && (c.type === '911' || c.type === 'crime' || c.type === 'traffic'));
    const policeUnits = units.filter(u => u.onDuty);
    const availableUnits = policeUnits.filter(u => u.status === 'available').length;
    const totalOnDuty = policeUnits.length;

    const avgResponseTime = Math.round(responseTimes.reduce((acc, r) => acc + r.avgTime, 0) / responseTimes.length);

    return (
        <div className="min-h-screen bg-background">
            <div className="bg-card border-b">
                <div className="container mx-auto px-4 py-1 flex items-center justify-between text-xs font-mono">
                    <div className="flex items-center gap-4">
                        <span className="text-muted-foreground">// STATUS CONTROL</span>
                        <Badge variant={isConnected ? "default" : "destructive"} className="gap-1">
                            {isConnected ? <Wifi className="h-3 w-3" /> : <WifiOff className="h-3 w-3" />}
                            {isConnected ? 'ONLINE' : 'OFFLINE'}
                        </Badge>
                    </div>
                    <div className="flex items-center gap-2">
                        <span className="text-muted-foreground">{formatDate()}</span>
                        <span className="text-primary">{currentTime}</span>
                    </div>
                </div>
            </div>

            <div className="container mx-auto px-4 py-4">
                <div className="grid gap-4 lg:grid-cols-3 mb-4">
                    <Card className="bg-card border-border">
                        <CardContent className="p-4">
                            <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-3">// STATUS CONTROL</div>
                            <div className="space-y-2 mb-4">
                                <div className="flex gap-2 text-xs font-mono">
                                    <span className="text-muted-foreground">OPERATOR:</span>
                                    <span>OFFICER [ID-001]</span>
                                </div>
                                <div className="flex gap-2 text-xs font-mono">
                                    <span className="text-muted-foreground">UNIT:</span>
                                    <span>{myCallsign || 'N/A'}</span>
                                </div>
                                <div className="flex gap-2 text-xs font-mono">
                                    <span className="text-muted-foreground">SHIFT:</span>
                                    <span className={isOnDuty ? 'text-green-500' : 'text-muted-foreground'}>
                                        {isOnDuty ? 'ON DUTY' : 'OFF DUTY'}
                                    </span>
                                </div>
                                <div className="flex gap-2 text-xs font-mono">
                                    <span className="text-muted-foreground">ALERT LEVEL:</span>
                                    <span className={activeCalls.some(c => c.priority === 'critical') ? 'text-red-500' : 'text-green-500'}>
                                        {activeCalls.some(c => c.priority === 'critical') ? 'HIGH' : 'NORMAL'}
                                    </span>
                                </div>
                                {myCall && (
                                    <div className="flex gap-2 text-xs font-mono mt-2 p-2 bg-red-500/10 border border-red-500/30 rounded">
                                        <span className="text-red-500">CURRENT CALL:</span>
                                        <span className="text-red-400 truncate">{myCall.description}</span>
                                    </div>
                                )}
                            </div>
                            
                            {!isOnDuty ? (
                                <Button 
                                    className="w-full font-mono text-xs bg-green-600 hover:bg-green-700"
                                    onClick={handleStartShiftClick}
                                >
                                    <Power className="h-4 w-4 mr-2" />
                                    START SHIFT
                                </Button>
                            ) : (
                                <div className="space-y-2">
                                    <div className="flex gap-2 flex-wrap">
                                        <Button 
                                            size="sm" 
                                            variant={myStatus === 'available' ? 'default' : 'outline'}
                                            className="text-xs font-mono bg-green-600 hover:bg-green-700 flex-1"
                                            onClick={() => handleStatusChange('available')}
                                        >
                                            AVAILABLE
                                        </Button>
                                        <Button 
                                            size="sm" 
                                            variant={myStatus === 'busy' ? 'default' : 'outline'}
                                            className="text-xs font-mono flex-1"
                                            onClick={() => handleStatusChange('busy')}
                                        >
                                            BUSY
                                        </Button>
                                    </div>
                                    <div className="flex gap-2 flex-wrap">
                                        <Button 
                                            size="sm" 
                                            variant={myStatus === 'enroute' ? 'default' : 'outline'}
                                            className="text-xs font-mono bg-yellow-600 hover:bg-yellow-700 flex-1"
                                            onClick={() => handleStatusChange('enroute')}
                                        >
                                            EN ROUTE
                                        </Button>
                                        <Button 
                                            size="sm" 
                                            variant={myStatus === 'on_scene' ? 'default' : 'outline'}
                                            className="text-xs font-mono bg-blue-600 hover:bg-blue-700 flex-1"
                                            onClick={() => handleStatusChange('on_scene')}
                                        >
                                            ON SCENE
                                        </Button>
                                    </div>
                                    <Button 
                                        variant="outline"
                                        size="sm"
                                        className="w-full font-mono text-xs text-red-500 border-red-500 hover:bg-red-500 hover:text-white"
                                        onClick={handleEndShift}
                                    >
                                        <LogOut className="h-4 w-4 mr-2" />
                                        END SHIFT
                                    </Button>
                                </div>
                            )}
                        </CardContent>
                    </Card>

                    <Card className="bg-card border-border">
                        <CardContent className="p-4">
                            <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-3">// QUICK SEARCH</div>
                            
                            <div className="space-y-3">
                                <Select 
                                    value={searchCategory} 
                                    onValueChange={(v: 'citizens' | 'vehicles' | 'weapons' | 'warrants') => {
                                        setSearchCategory(v);
                                        setSearchQuery({
                                            firstName: '',
                                            lastName: '',
                                            dobDay: '',
                                            dobMonth: '',
                                            dobYear: '',
                                            plate: '',
                                            serialNumber: '',
                                            model: '',
                                            ownerName: '',
                                            phone: '',
                                            ssn: ''
                                        });
                                        setSearchResults2([]);
                                    }}
                                >
                                    <SelectTrigger className="font-mono text-xs">
                                        <SelectValue />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="citizens">
                                            <div className="flex items-center gap-2">
                                                <User className="h-3 w-3" />
                                                Citizens
                                            </div>
                                        </SelectItem>
                                        <SelectItem value="vehicles">
                                            <div className="flex items-center gap-2">
                                                <Car className="h-3 w-3" />
                                                Vehicles
                                            </div>
                                        </SelectItem>
                                        <SelectItem value="weapons">
                                            <div className="flex items-center gap-2">
                                                <Target className="h-3 w-3" />
                                                Weapons
                                            </div>
                                        </SelectItem>
                                        <SelectItem value="warrants">
                                            <div className="flex items-center gap-2">
                                                <FileText className="h-3 w-3" />
                                                Warrants
                                            </div>
                                        </SelectItem>
                                    </SelectContent>
                                </Select>

                                {searchCategory === 'citizens' && (
                                    <>
                                        <Input 
                                            placeholder="First Name"
                                            value={searchQuery.firstName}
                                            onChange={(e) => setSearchQuery({...searchQuery, firstName: e.target.value})}
                                            className="text-xs font-mono"
                                        />
                                        <Input 
                                            placeholder="Last Name"
                                            value={searchQuery.lastName}
                                            onChange={(e) => setSearchQuery({...searchQuery, lastName: e.target.value})}
                                            className="text-xs font-mono"
                                        />
                                        <div className="grid grid-cols-3 gap-1">
                                            <Input 
                                                placeholder="DD"
                                                value={searchQuery.dobDay}
                                                onChange={(e) => setSearchQuery({...searchQuery, dobDay: e.target.value})}
                                                className="text-xs font-mono"
                                                maxLength={2}
                                            />
                                            <Input 
                                                placeholder="MM"
                                                value={searchQuery.dobMonth}
                                                onChange={(e) => setSearchQuery({...searchQuery, dobMonth: e.target.value})}
                                                className="text-xs font-mono"
                                                maxLength={2}
                                            />
                                            <Input 
                                                placeholder="YYYY"
                                                value={searchQuery.dobYear}
                                                onChange={(e) => setSearchQuery({...searchQuery, dobYear: e.target.value})}
                                                className="text-xs font-mono"
                                                maxLength={4}
                                            />
                                        </div>
                                    </>
                                )}

                                {searchCategory === 'vehicles' && (
                                    <>
                                        <Input 
                                            placeholder={t('Plate')}
                                            value={searchQuery.plate}
                                            onChange={(e) => setSearchQuery({...searchQuery, plate: e.target.value.toUpperCase()})}
                                            className="text-xs font-mono"
                                        />
                                    </>
                                )}

                                {searchCategory === 'weapons' && (
                                    <>
                                        <Input 
                                            placeholder={t('Serial Number')}
                                            value={searchQuery.serialNumber}
                                            onChange={(e) => setSearchQuery({...searchQuery, serialNumber: e.target.value.toUpperCase()})}
                                            className="text-xs font-mono"
                                        />
                                    </>
                                )}

                                {searchCategory === 'warrants' && (
                                    <div className="text-xs text-muted-foreground text-center py-2">
                                        Click search to view all warrants
                                    </div>
                                )}

                                <Button 
                                    onClick={handleSearch}
                                    disabled={isSearching}
                                    className="w-full font-mono text-xs"
                                    size="sm"
                                >
                                    {isSearching ? 'Searching...' : 'SEARCH'}
                                </Button>

                                {searchResults2.length > 0 && (
                                    <ScrollArea className="h-[150px]">
                                        <div className="space-y-1">
                                            {searchResults2.slice(0, 5).map((result, idx) => (
                                                <div 
                                                    key={idx}
                                                    className="p-2 border rounded hover:bg-accent cursor-pointer text-xs"
                                                    onClick={() => handleViewDetails(result)}
                                                >
                                                    {searchCategory === 'citizens' && (
                                                        <div className="flex justify-between items-center">
                                                            <span className="font-bold">{result.firstName} {result.lastName}</span>
                                                            <div className="flex gap-1">
                                                                {result.isWanted && <span className="text-red-500 text-[10px]">WANTED</span>}
                                                            </div>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'vehicles' && (
                                                        <div className="flex justify-between items-center">
                                                            <span className="font-bold">{result.model}</span>
                                                            <span className="font-mono">{result.plate}</span>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'weapons' && (
                                                        <div className="flex justify-between items-center">
                                                            <span>{result.type}</span>
                                                            <span className="font-mono text-[10px]">{result.serialNumber}</span>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'warrants' && (
                                                        <div className="flex justify-between items-center">
                                                            <span>{result.character?.firstName} {result.character?.lastName}</span>
                                                            <span className={`text-[10px] ${result.status === 'active' ? 'text-red-500' : 'text-muted-foreground'}`}>
                                                                {result.status}
                                                            </span>
                                                        </div>
                                                    )}
                                                </div>
                                            ))}
                                            {searchResults2.length > 5 && (
                                                <div className="text-xs text-muted-foreground text-center">
                                                    +{searchResults2.length - 5} more results
                                                </div>
                                            )}
                                        </div>
                                    </ScrollArea>
                                )}
                            </div>
                        </CardContent>
                    </Card>

                    <Card className="bg-card border-border">
                        <CardContent className="p-4">
                            {myDivision?.isDetective ? (
                                <div>
                                    <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-3">// DETECTIVE UNIT</div>
                                    <div 
                                        className="p-3 bg-purple-500/10 border border-purple-500/30 rounded-lg mb-3 cursor-pointer hover:bg-purple-500/20 transition-colors"
                                        onClick={() => router.push('/police/detective')}
                                    >
                                        <div className="flex items-center gap-2 text-purple-400 font-mono text-sm">
                                            <Target className="h-4 w-4" />
                                            <span>Детективный отдел</span>
                                        </div>
                                        <div className="text-xs text-muted-foreground mt-1">{myDivision.name}</div>
                                    </div>
                                    <Button 
                                        className="w-full bg-red-600 hover:bg-red-700"
                                        onClick={() => setShowWarrantDialog(true)}
                                    >
                                        <FileText className="h-4 w-4 mr-2" />
                                        Request Warrant
                                    </Button>
                                </div>
                            ) : (
                                <div className="text-center py-4">
                                    <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-2">// UNIT INFO</div>
                                    <div className="text-sm text-muted-foreground">
                                        {isOnDuty ? (
                                            <span className="text-green-500">На дежурстве</span>
                                        ) : (
                                            <span>Не на дежурстве</span>
                                        )}
                                    </div>
                                </div>
                            )}
                        </CardContent>
                    </Card>
                </div>

                <div className="grid gap-4 lg:grid-cols-3">
                    <div className="lg:col-span-2">
                        <Card className="bg-card border-border">
                            <CardHeader className="py-3 px-4 border-b">
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-4">
                                        <button
                                            onClick={() => setActiveTab('calls')}
                                            className={`flex items-center gap-2 text-sm font-bold uppercase tracking-wide ${activeTab === 'calls' ? 'text-red-500' : 'text-muted-foreground'}`}
                                        >
                                            <div className="w-2 h-2 rounded-full bg-red-500 animate-pulse" />
                                            Active Incidents
                                        </button>
                                        <button
                                            onClick={() => setActiveTab('search')}
                                            className={`flex items-center gap-2 text-sm font-bold uppercase tracking-wide ${activeTab === 'search' ? 'text-blue-500' : 'text-muted-foreground'}`}
                                        >
                                            <Search className="h-4 w-4" />
                                            Search
                                        </button>
                                    </div>
                                    <span className="text-xs font-mono text-red-500">LIVE FEED_</span>
                                </div>
                            </CardHeader>
                            {activeTab === 'calls' && (
                            <CardContent className="p-0">
                                <ScrollArea className="h-[350px]">
                                    <table className="w-full">
                                        <thead>
                                            <tr className="border-b">
                                                <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">Priority</th>
                                                <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">Time</th>
                                                <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">Type</th>
                                                <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">Location</th>
                                                <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody className="font-mono text-xs">
                                            {activeCalls.map((call) => (
                                                <tr 
                                                    key={call.id} 
                                                    className="border-b hover:bg-muted/50 cursor-pointer"
                                                    onClick={() => {
                                                        setSelectedCall(call);
                                                        fetchCallLogs(call.id);
                                                        setShowCallModal(true);
                                                    }}
                                                >
                                                    <td className="p-3">
                                                        <span className={`inline-block px-2 py-1 text-[10px] font-bold border ${priorityColors[call.priority]}`}>
                                                            {priorityMap[call.priority]}
                                                        </span>
                                                    </td>
                                                    <td className="p-3">{formatTime(call.createdAt)}</td>
                                                    <td className="p-3">{call.type.toUpperCase()}</td>
                                                    <td className="p-3 max-w-[150px] truncate">{call.location}</td>
                                                    <td className={`p-3 ${statusColors[call.status]}`}>
                                                        {statusMap[call.status]}
                                                    </td>
                                                </tr>
                                            ))}
                                            {activeCalls.length === 0 && (
                                                <tr>
                                                    <td colSpan={5} className="p-8 text-center text-muted-foreground">
                                                        NO ACTIVE INCIDENTS
                                                    </td>
                                                </tr>
                                            )}
                                        </tbody>
                                    </table>
                                </ScrollArea>
                            </CardContent>
                            )}

                            {activeTab === 'search' && (
                            <CardContent className="p-4">
                                <div className="space-y-4">
                                    <div className="flex gap-2 flex-wrap">
                                        <Button 
                                            variant={searchCategory === 'citizens' ? 'default' : 'outline'}
                                            size="sm"
                                            className="font-mono text-xs"
                                            onClick={() => setSearchCategory('citizens')}
                                        >
                                            <User className="h-3 w-3 mr-1" />
                                            Citizens
                                        </Button>
                                        <Button 
                                            variant={searchCategory === 'vehicles' ? 'default' : 'outline'}
                                            size="sm"
                                            className="font-mono text-xs"
                                            onClick={() => setSearchCategory('vehicles')}
                                        >
                                            <Car className="h-3 w-3 mr-1" />
                                            Vehicles
                                        </Button>
                                        <Button 
                                            variant={searchCategory === 'weapons' ? 'default' : 'outline'}
                                            size="sm"
                                            className="font-mono text-xs"
                                            onClick={() => setSearchCategory('weapons')}
                                        >
                                            <Target className="h-3 w-3 mr-1" />
                                            Weapons
                                        </Button>
                                        <Button 
                                            variant={searchCategory === 'warrants' ? 'default' : 'outline'}
                                            size="sm"
                                            className="font-mono text-xs"
                                            onClick={() => setSearchCategory('warrants')}
                                        >
                                            <FileText className="h-3 w-3 mr-1" />
                                            Warrants
                                        </Button>
                                    </div>

                                    <div className="grid gap-2">
                                        {searchCategory === 'citizens' && (
                                            <>
                                                <div className="grid grid-cols-2 gap-2">
                                                    <Input 
                                                        placeholder="First Name"
                                                        value={searchQuery.firstName}
                                                        onChange={(e) => setSearchQuery({...searchQuery, firstName: e.target.value})}
                                                        className="text-xs font-mono"
                                                    />
                                                    <Input 
                                                        placeholder="Last Name"
                                                        value={searchQuery.lastName}
                                                        onChange={(e) => setSearchQuery({...searchQuery, lastName: e.target.value})}
                                                        className="text-xs font-mono"
                                                    />
                                                </div>
                                                <div className="grid grid-cols-2 gap-2">
                                                    <Input 
                                                        placeholder="SSN"
                                                        value={searchQuery.ssn}
                                                        onChange={(e) => setSearchQuery({...searchQuery, ssn: e.target.value})}
                                                        className="text-xs font-mono"
                                                    />
                                                    <Input 
                                                        placeholder="Phone"
                                                        value={searchQuery.phone}
                                                        onChange={(e) => setSearchQuery({...searchQuery, phone: e.target.value})}
                                                        className="text-xs font-mono"
                                                    />
                                                </div>
                                            </>
                                        )}
                                        {searchCategory === 'vehicles' && (
                                            <div className="grid grid-cols-3 gap-2">
                                                <Input 
                                                    placeholder="Plate"
                                                    value={searchQuery.plate}
                                                    onChange={(e) => setSearchQuery({...searchQuery, plate: e.target.value})}
                                                    className="text-xs font-mono"
                                                />
                                                <Input 
                                                    placeholder="Model"
                                                    value={searchQuery.model}
                                                    onChange={(e) => setSearchQuery({...searchQuery, model: e.target.value})}
                                                    className="text-xs font-mono"
                                                />
                                                <Input 
                                                    placeholder="Owner Name"
                                                    value={searchQuery.ownerName}
                                                    onChange={(e) => setSearchQuery({...searchQuery, ownerName: e.target.value})}
                                                    className="text-xs font-mono"
                                                />
                                            </div>
                                        )}
                                        {searchCategory === 'weapons' && (
                                            <div className="grid grid-cols-2 gap-2">
                                                <Input 
                                                    placeholder="Serial Number"
                                                    value={searchQuery.serialNumber}
                                                    onChange={(e) => setSearchQuery({...searchQuery, serialNumber: e.target.value})}
                                                    className="text-xs font-mono"
                                                />
                                                <Input 
                                                    placeholder="Owner Name"
                                                    value={searchQuery.ownerName}
                                                    onChange={(e) => setSearchQuery({...searchQuery, ownerName: e.target.value})}
                                                    className="text-xs font-mono"
                                                />
                                            </div>
                                        )}
                                    </div>

                                    <Button 
                                        onClick={handleSearch}
                                        disabled={isSearching}
                                        className="w-full font-mono text-xs"
                                    >
                                    {isSearching ? t('Searching...') : t('SEARCH')}
                                    </Button>

                                    <ScrollArea className="h-[250px]">
                                        <div className="space-y-2">
                                            {searchResults2.map((result, idx) => (
                                                <div 
                                                    key={idx}
                                                    className="p-3 border rounded-lg hover:bg-accent cursor-pointer"
                                                    onClick={() => handleViewDetails(result)}
                                                >
                                                    {searchCategory === 'citizens' && (
                                                        <div className="flex justify-between items-center">
                                                            <div>
                                                                <div className="font-bold text-sm">{result.firstName} {result.lastName}</div>
                                                                <div className="text-xs text-muted-foreground">SSN: {result.ssn || 'N/A'}</div>
                                                            </div>
                                                            <div className="flex gap-1 flex-col items-end">
                                                                {result.isWanted && <Badge className="bg-red-500">WANTED</Badge>}
                                                                {result.isArrested && <Badge className="bg-orange-500">ARRESTED</Badge>}
                                                                {(result._count?.fines > 0 || result._count?.warrants > 0 || result._count?.arrests > 0) && (
                                                                    <div className="flex gap-1 mt-1">
                                                                        {result._count?.fines > 0 && (
                                                                            <span className="text-xs text-yellow-500 font-mono">{result._count.fines} штр</span>
                                                                        )}
                                                                        {result._count?.warrants > 0 && (
                                                                            <span className="text-xs text-red-500 font-mono">{result._count.warrants} орд</span>
                                                                        )}
                                                                        {result._count?.arrests > 0 && (
                                                                            <span className="text-xs text-orange-500 font-mono">{result._count.arrests} арест</span>
                                                                        )}
                                                                    </div>
                                                                )}
                                                            </div>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'vehicles' && (
                                                        <div className="flex justify-between items-center">
                                                            <div>
                                                                <div className="font-bold text-sm">{result.model}</div>
                                                                <div className="text-xs text-muted-foreground">Plate: {result.plate}</div>
                                                            </div>
                                                            <div className="text-xs text-muted-foreground">{result.ownerName}</div>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'weapons' && (
                                                        <div className="flex justify-between items-center">
                                                            <div>
                                                                <div className="font-bold text-sm">{result.type} - {result.name}</div>
                                                                <div className="text-xs text-muted-foreground">S/N: {result.serialNumber}</div>
                                                            </div>
                                                            <Badge className={result.status === 'active' ? 'bg-green-500' : 'bg-red-500'}>
                                                                {result.status}
                                                            </Badge>
                                                        </div>
                                                    )}
                                                    {searchCategory === 'warrants' && (
                                                        <div className="flex justify-between items-center">
                                                            <div>
                                                                <div className="font-bold text-sm">{result.character?.firstName} {result.character?.lastName}</div>
                                                                <div className="text-xs text-muted-foreground">{result.title}</div>
                                                            </div>
                                                            <Badge className={result.status === 'active' ? 'bg-red-500' : 'bg-gray-500'}>
                                                                {result.status}
                                                            </Badge>
                                                        </div>
                                                    )}
                                                </div>
                                            ))}
                                            {searchResults2.length === 0 && !isSearching && activeTab === 'search' && (
                                                <div className="text-center text-muted-foreground py-8">
                                                    Enter search criteria and click SEARCH
                                                </div>
                                            )}
                                        </div>
                                    </ScrollArea>
                                </div>
                            </CardContent>
                            )}
                        </Card>

                        {myCall && (
                            <Card className="bg-card border-green-500 mt-4">
                                <CardHeader className="py-3 px-4 border-b bg-green-500/10">
                                    <div className="flex items-center justify-between">
                                        <span className="text-sm font-bold uppercase tracking-wide text-green-500">
                                            MY CALL
                                        </span>
                                        <Button 
                                            size="sm" 
                                            className="font-mono text-xs"
                                            onClick={handleCompleteCall}
                                        >
                                            COMPLETE CALL
                                        </Button>
                                    </div>
                                </CardHeader>
                                <CardContent className="p-4">
                                    <div className="grid grid-cols-2 gap-4 text-xs font-mono">
                                        <div>
                                            <span className="text-muted-foreground">TYPE:</span>
                                            <span className="ml-2">{myCall.type.toUpperCase()}</span>
                                        </div>
                                        <div>
                                            <span className="text-muted-foreground">PRIORITY:</span>
                                            <span className="ml-2">{priorityMap[myCall.priority]}</span>
                                        </div>
                                        <div className="col-span-2">
                                            <span className="text-muted-foreground">LOCATION:</span>
                                            <span className="ml-2">{myCall.location}</span>
                                        </div>
                                        <div className="col-span-2">
                                            <span className="text-muted-foreground">DESCRIPTION:</span>
                                            <span className="ml-2">{myCall.description}</span>
                                        </div>
                                    </div>
                                </CardContent>
                            </Card>
                        )}
                    </div>

                    <div className="space-y-4">
                        <Card className="bg-card border-border">
                            <CardHeader className="py-3 px-4 border-b">
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-2">
                                        <div className="w-2 h-2 rounded-full bg-green-500" />
                                        <span className="text-sm font-bold uppercase tracking-wide">Unit Status</span>
                                    </div>
                                    <span className="text-xs font-mono text-muted-foreground">
                                        {availableUnits}/{totalOnDuty} AVAIL
                                    </span>
                                </div>
                            </CardHeader>
                            <CardContent className="p-2">
                                <div className="grid grid-cols-2 gap-2">
                                    {policeUnits.map((unit) => (
                                        <div 
                                            key={unit.id}
                                            className={`p-3 rounded border ${
                                                unit.status === 'available' ? 'border-green-500/50 bg-green-500/5' :
                                                unit.status === 'enroute' ? 'border-yellow-500/50 bg-yellow-500/5' :
                                                myUnit && unit.id === myUnit.id ? 'border-primary bg-primary/10' :
                                                'border-border bg-muted/30'
                                            }`}
                                        >
                                            <div className="flex items-center justify-between mb-1">
                                                <span className="font-mono text-xs font-bold">
                                                    {unit.callsign}
                                                    {myUnit && unit.id === myUnit.id && ' *'}
                                                </span>
                                                <div className={`w-2 h-2 rounded-full ${unitStatusColors[unit.status]}`} />
                                            </div>
                                            <div className={`text-[10px] font-mono ${
                                                unit.status === 'available' ? 'text-green-500' :
                                                unit.status === 'enroute' ? 'text-yellow-500' :
                                                unit.status === 'on_scene' ? 'text-blue-500' :
                                                'text-muted-foreground'
                                            }`}>
                                                {unitStatusMap[unit.status]}
                                            </div>
                                        </div>
                                    ))}
                                    {policeUnits.length === 0 && (
                                        <div className="col-span-2 text-center text-muted-foreground py-4 text-xs font-mono">
                                            NO UNITS ON DUTY
                                        </div>
                                    )}
                                </div>
                            </CardContent>
                        </Card>

                        <Card className="bg-card border-border">
                            <CardHeader className="py-3 px-4 border-b">
                                <div className="flex items-center gap-2">
                                    <span className="text-sm font-bold uppercase tracking-wide">{t('My Shift')}</span>
                                </div>
                            </CardHeader>
                            <CardContent className="p-4">
                                <div className="space-y-2 text-xs font-mono">
                                    <div className="flex justify-between">
                                        <span className="text-muted-foreground">{t('Status')}</span>
                                        <span className={isOnDuty ? 'text-green-500' : 'text-muted-foreground'}>
                                            {isOnDuty ? t('Active') : t('Inactive')}
                                        </span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="text-muted-foreground">{t('Status')}</span>
                                        <span>{unitStatusMap[myStatus as keyof typeof unitStatusMap] || 'N/A'}</span>
                                    </div>
                                    <div className="flex justify-between">
                                        <span className="text-muted-foreground">{t('Calls')}</span>
                                        <span>{activeCalls.length}</span>
                                    </div>
                                </div>
                            </CardContent>
                        </Card>
                    </div>
                </div>
            </div>

            <Dialog open={showPanicDialog} onOpenChange={setShowPanicDialog}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle className="text-red-500 font-mono">// PANIC BUTTON</DialogTitle>
                    </DialogHeader>
                    <div className="py-4 text-center">
                        <AlertTriangle className="h-16 w-16 mx-auto text-red-500 animate-pulse" />
                        <p className="mt-4 font-bold text-lg">ВЫ УВЕРЕНЫ?</p>
                        <p className="text-muted-foreground">Это отправит сигнал тревоги диспетчеру</p>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowPanicDialog(false)}>
                            ОТМЕНА
                        </Button>
                        <Button variant="destructive" onClick={confirmPanic}>
                            ПОДТВЕРДИТЬ
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showCallsignDialog} onOpenChange={setShowCallsignDialog}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle className="font-mono">// НАЧАЛО СМЕНЫ</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <div>
                            <Label className="text-xs font-mono">ОФИЦЕР</Label>
                            <Select value={tempOfficerId} onValueChange={handleOfficerSelect}>
                                <SelectTrigger>
                                    <SelectValue placeholder="Выберите офицера" />
                                </SelectTrigger>
                                <SelectContent>
                                    {officers.map((officer) => (
                                        <SelectItem key={officer.id} value={officer.id}>
                                            {officer.character.firstName} {officer.character.lastName} - {officer.department.name} {officer.officerRank && `(${officer.officerRank})`}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div>
                            <Label className="text-xs font-mono">ПОЗЫВНОЙ</Label>
                            <Input 
                                placeholder="Заполнится автоматически"
                                value={tempCallsign}
                                onChange={(e) => setTempCallsign(e.target.value.toUpperCase())}
                                onKeyDown={(e) => e.key === 'Enter' && handleConfirmCallsign()}
                            />
                            <p className="text-xs text-muted-foreground mt-1">Позывной будет выбран автоматически из данных офицера</p>
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowCallsignDialog(false)}>
                            ОТМЕНА
                        </Button>
                        <Button onClick={handleConfirmCallsign}>
                            НАЧАТЬ СМЕНУ
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showCallModal} onOpenChange={setShowCallModal}>
                <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
                    <DialogHeader>
                        <DialogTitle className="font-mono flex items-center gap-2">
                            <span className="text-red-500">//</span> ДЕТАЛИ ВЫЗОВА
                        </DialogTitle>
                    </DialogHeader>
                    {selectedCall && (
                        <div className="space-y-4 py-4">
                            <div className="flex items-center justify-between">
                                <div className="flex items-center gap-2">
                                    <span className="text-xl font-bold">{selectedCall.type === '911' ? <><AlertCircle className="h-5 w-5 inline text-red-500" /> 911</> : selectedCall.type.toUpperCase()}</span>
                                    <Badge className={priorityColors[selectedCall.priority]}>{priorityMap[selectedCall.priority]}</Badge>
                                    <Badge className={`${statusColors[selectedCall.status]} text-white`}>{statusMap[selectedCall.status]}</Badge>
                                </div>
                                <span className="text-sm text-muted-foreground">{formatTime(selectedCall.createdAt)}</span>
                            </div>
                            
                            <div className="space-y-2">
                                <div className="flex items-center gap-2 text-sm">
                                    <MapPin className="h-4 w-4 text-muted-foreground" />
                                    <span className="font-medium">{selectedCall.location}</span>
                                </div>
                                
                                <div className="bg-muted rounded p-3">
                                    <p className="text-xs text-muted-foreground mb-1">Описание</p>
                                    <p className="text-sm">{selectedCall.description}</p>
                                </div>
                                
                                {(selectedCall.callerName || selectedCall.callerPhone) && (
                                    <div className="flex items-center gap-2 text-sm">
                                        <User className="h-4 w-4 text-muted-foreground" />
                                        <span>{selectedCall.callerName} {selectedCall.callerPhone && `(${selectedCall.callerPhone})`}</span>
                                    </div>
                                )}
                                
                                <div>
                                    <p className="text-xs text-muted-foreground mb-2">Назначенные юниты</p>
                                    <div className="flex flex-wrap gap-2">
                                        {selectedCall.assignedUnits.length > 0 ? (
                                            selectedCall.assignedUnits.map((unitId, idx) => (
                                                <Badge key={idx} variant="outline" className="font-mono">
                                                    {getUnitCallsign(unitId, units)}
                                                </Badge>
                                            ))
                                        ) : (
                                            <span className="text-muted-foreground text-sm">Нет назначенных</span>
                                        )}
                                    </div>
                                </div>

                                {isOnDuty && (
                                    <div className="space-y-2 pt-2 border-t">
                                        <p className="text-xs text-muted-foreground">УЧАСТИЕ В ВЫЗОВЕ</p>
                                        {selectedCall.assignedUnits.includes(myUnit?.id || '') ? (
                                            <Button 
                                                variant="outline" 
                                                size="sm"
                                                className="w-full text-red-500 border-red-500 hover:bg-red-500 hover:text-white"
                                                onClick={handleSelfUnassign}
                                            >
                                                СНЯТЬСЯ С ВЫЗОВА
                                            </Button>
                                        ) : (
                                            <Button 
                                                variant="default" 
                                                size="sm"
                                                className="w-full"
                                                onClick={handleSelfAssign}
                                            >
                                                ПРИСТУПИТЬ К ВЫЗОВУ
                                            </Button>
                                        )}
                                    </div>
                                )}

                                <div className="space-y-2 pt-2 border-t">
                                    <p className="text-xs text-muted-foreground">ЛОГ СОБЫТИЙ</p>
                                    <div className="bg-muted rounded-lg max-h-[200px] overflow-y-auto space-y-2 p-3">
                                        {callLogs.map((log) => (
                                            <div key={log.id} className="text-sm border-b border-border pb-2 last:border-0">
                                                <div className="flex items-center gap-2">
                                                    <span className="font-bold text-primary text-xs">
                                                        {log.authorCallsign || log.authorName || 'Система'}
                                                    </span>
                                                    <span className="text-xs text-muted-foreground">
                                                        {formatTime(log.createdAt)}
                                                    </span>
                                                </div>
                                                <p className="text-sm mt-0.5">{log.content}</p>
                                            </div>
                                        ))}
                                        {callLogs.length === 0 && (
                                            <p className="text-muted-foreground text-sm text-center py-4">Нет записей</p>
                                        )}
                                    </div>
                                    <div className="flex gap-2">
                                        <Input 
                                            placeholder="Добавить информацию..."
                                            value={newMessage}
                                            onChange={(e) => setNewMessage(e.target.value)}
                                            onKeyDown={(e) => e.key === 'Enter' && handleSendMessage()}
                                            className="text-sm"
                                        />
                                        <Button size="sm" onClick={handleSendMessage}>
                                            ОТПРАВИТЬ
                                        </Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    )}
                </DialogContent>
            </Dialog>

            {searchCategory === 'citizens' && (
                <CivilianModal
                    open={showSearchModal}
                    onOpenChange={setShowSearchModal}
                    civilian={selectedResult}
                    mode="view"
                    extraActions={
                        <div className="flex gap-2 mr-auto">
                            {selectedResult && (
                                <>
                                    <Button 
                                        size="sm"
                                        className="font-mono text-xs bg-red-500/20 border border-red-500/50 text-red-400 hover:bg-red-500/30"
                                        onClick={() => {
                                            setSelectedCitizenForWarrant(selectedResult);
                                            setShowWarrantDialog(true);
                                        }}
                                    >
                                        <FileText className="h-3 w-3 mr-1" />
                                        ОРДЕР
                                    </Button>
                                    <Button 
                                        size="sm"
                                        className="font-mono text-xs bg-yellow-500/20 border border-yellow-500/50 text-yellow-400 hover:bg-yellow-500/30"
                                        onClick={() => {
                                            setSelectedCitizenForFine(selectedResult);
                                            setShowFineDialog(true);
                                        }}
                                    >
                                        <DollarSign className="h-3 w-3 mr-1" />
                                        ШТРАФ
                                    </Button>
                                    <Button 
                                        size="sm"
                                        className="font-mono text-xs bg-orange-500/20 border border-orange-500/50 text-orange-400 hover:bg-orange-500/30"
                                        onClick={() => {
                                            setSelectedCitizenForArrest(selectedResult);
                                            setShowArrestDialog(true);
                                        }}
                                    >
                                        <UserMinus className="h-3 w-3 mr-1" />
                                        АРЕСТ
                                    </Button>
                                </>
                            )}
                        </div>
                    }
                />
            )}

            {searchCategory === 'vehicles' && (
                <Dialog open={showSearchModal} onOpenChange={setShowSearchModal}>
                    <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
                        <DialogHeader>
                            <DialogTitle className="font-mono">
                                // VEHICLE INFO
                            </DialogTitle>
                        </DialogHeader>
                        {selectedResult && (
                            <div className="space-y-4 py-4">
                                <div className="grid grid-cols-2 gap-4 text-sm">
                                    <div>
                                        <span className="text-muted-foreground">Model:</span>
                                        <span className="ml-2 font-bold">{selectedResult.model}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Plate:</span>
                                        <span className="ml-2 font-mono text-lg">{selectedResult.plate}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Color:</span>
                                        <span className="ml-2">{selectedResult.color || 'N/A'}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Type:</span>
                                        <span className="ml-2">{selectedResult.type}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Owner:</span>
                                        <span className="ml-2">{selectedResult.ownerName || 'N/A'}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">VIN:</span>
                                        <span className="ml-2 font-mono">{selectedResult.vin || 'N/A'}</span>
                                    </div>
                                </div>
                            </div>
                        )}
                        <DialogFooter>
                            <Button variant="outline" onClick={() => setShowSearchModal(false)}>
                                CLOSE
                            </Button>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            )}

            {searchCategory === 'weapons' && (
                <Dialog open={showSearchModal} onOpenChange={setShowSearchModal}>
                    <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
                        <DialogHeader>
                            <DialogTitle className="font-mono">
                                // WEAPON INFO
                            </DialogTitle>
                        </DialogHeader>
                        {selectedResult && (
                            <div className="space-y-4 py-4">
                                <div className="grid grid-cols-2 gap-4 text-sm">
                                    <div>
                                        <span className="text-muted-foreground">Type:</span>
                                        <span className="ml-2 font-bold">{selectedResult.type}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Name:</span>
                                        <span className="ml-2">{selectedResult.name}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Serial:</span>
                                        <span className="ml-2 font-mono">{selectedResult.serialNumber || 'N/A'}</span>
                                    </div>
                                    <div>
                                        <span className="text-muted-foreground">Owner:</span>
                                        <span className="ml-2">{selectedResult.ownerName || 'N/A'}</span>
                                    </div>
                                </div>
                            </div>
                        )}
                        <DialogFooter>
                            <Button variant="outline" onClick={() => setShowSearchModal(false)}>
                                CLOSE
                            </Button>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            )}

            <Dialog open={showWarrantDialog} onOpenChange={setShowWarrantDialog}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle className="font-mono">// CREATE WARRANT</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        {selectedCitizenForWarrant && (
                            <div className="flex items-center gap-4 p-2 bg-muted rounded">
                                {selectedCitizenForWarrant.mugshot && (
                                    <div className="w-12 h-12 rounded overflow-hidden">
                                        <img 
                                            src={getUploadUrl(selectedCitizenForWarrant.mugshot)} 
                                            alt="Mugshot"
                                            className="w-full h-full object-cover"
                                            crossOrigin="anonymous"
                                        />
                                    </div>
                                )}
                                <div>
                                    <span className="text-muted-foreground">Subject:</span>
                                    <span className="ml-2 font-bold">{selectedCitizenForWarrant.firstName} {selectedCitizenForWarrant.lastName}</span>
                                </div>
                            </div>
                        )}
                        
                        <div>
                            <Label className="text-xs font-mono">WARRANT TYPE</Label>
                            <Select 
                                value={newWarrant.type}
                                onValueChange={(v: 'arrest' | 'search') => setNewWarrant({...newWarrant, type: v})}
                            >
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="arrest">
                                        <div className="flex items-center gap-2">
                                            <span className="text-red-500 font-bold">WRA</span>
                                            <span>- Arrest Warrant</span>
                                        </div>
                                    </SelectItem>
                                    <SelectItem value="search">
                                        <div className="flex items-center gap-2">
                                            <span className="text-orange-500 font-bold">WRS</span>
                                            <span>- Search Warrant</span>
                                        </div>
                                    </SelectItem>
                                </SelectContent>
                            </Select>
                            <p className="text-xs text-muted-foreground mt-1">
                                {newWarrant.type === 'arrest' ? 'WRA-XX-XXX-XX (Arrest Warrant)' : 'WRS-XXX-X-XX-XX (Search Warrant)'}
                            </p>
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">REASON</Label>
                            <Input 
                                placeholder="Reason for warrant..."
                                value={newWarrant.reason}
                                onChange={(e) => setNewWarrant({...newWarrant, reason: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">ADDRESS (Location)</Label>
                            <Input 
                                placeholder="Address to search/arrest..."
                                value={newWarrant.address}
                                onChange={(e) => setNewWarrant({...newWarrant, address: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">ISSUING OFFICER</Label>
                            <Input 
                                placeholder="Officer name/badge..."
                                value={newWarrant.issuingOfficer}
                                onChange={(e) => setNewWarrant({...newWarrant, issuingOfficer: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">DESCRIPTION</Label>
                            <Input 
                                placeholder="Additional details..."
                                value={newWarrant.description}
                                onChange={(e) => setNewWarrant({...newWarrant, description: e.target.value})}
                            />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowWarrantDialog(false)}>
                            CANCEL
                        </Button>
                        <Button onClick={handleCreateWarrant}>
                            CREATE WARRANT
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showFineDialog} onOpenChange={setShowFineDialog}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle className="font-mono">// CREATE FINE</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        {selectedCitizenForFine && (
                            <div className="flex items-center gap-4 p-2 bg-muted rounded">
                                {selectedCitizenForFine.mugshot && (
                                    <div className="w-12 h-12 rounded overflow-hidden">
                                        <img 
                                            src={getUploadUrl(selectedCitizenForFine.mugshot)} 
                                            alt="Mugshot"
                                            className="w-full h-full object-cover"
                                            crossOrigin="anonymous"
                                        />
                                    </div>
                                )}
                                <div>
                                    <span className="text-muted-foreground">Subject:</span>
                                    <span className="ml-2 font-bold">{selectedCitizenForFine.firstName} {selectedCitizenForFine.lastName}</span>
                                </div>
                            </div>
                        )}
                        
                        <div>
                            <Label className="text-xs font-mono">AMOUNT ($)</Label>
                            <Input 
                                type="number"
                                placeholder="Amount..."
                                value={newFine.amount}
                                onChange={(e) => setNewFine({...newFine, amount: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">ARTICLE (e.g., PC 123)</Label>
                            <Input 
                                placeholder="Article/Code..."
                                value={newFine.article}
                                onChange={(e) => setNewFine({...newFine, article: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">REASON</Label>
                            <Input 
                                placeholder="Reason for fine..."
                                value={newFine.reason}
                                onChange={(e) => setNewFine({...newFine, reason: e.target.value})}
                            />
                        </div>
                        
                        <div className="grid grid-cols-2 gap-2">
                            <div>
                                <Label className="text-xs font-mono">INCIDENT DATE</Label>
                                <Input 
                                    type="date"
                                    value={newFine.incidentDate}
                                    onChange={(e) => setNewFine({...newFine, incidentDate: e.target.value})}
                                />
                            </div>
                            <div>
                                <Label className="text-xs font-mono">INCIDENT TIME</Label>
                                <Input 
                                    type="time"
                                    value={newFine.incidentTime}
                                    onChange={(e) => setNewFine({...newFine, incidentTime: e.target.value})}
                                />
                            </div>
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">DESCRIPTION</Label>
                            <Input 
                                placeholder="Additional details..."
                                value={newFine.description}
                                onChange={(e) => setNewFine({...newFine, description: e.target.value})}
                            />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowFineDialog(false)}>
                            CANCEL
                        </Button>
                        <Button onClick={handleCreateFine} className="bg-yellow-500 hover:bg-yellow-600">
                            CREATE FINE
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showArrestDialog} onOpenChange={setShowArrestDialog}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle className="font-mono">// CREATE ARREST</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        {selectedCitizenForArrest && (
                            <div className="flex items-center gap-4 p-2 bg-muted rounded">
                                {selectedCitizenForArrest.mugshot && (
                                    <div className="w-12 h-12 rounded overflow-hidden">
                                        <img 
                                            src={getUploadUrl(selectedCitizenForArrest.mugshot)} 
                                            alt="Mugshot"
                                            className="w-full h-full object-cover"
                                            crossOrigin="anonymous"
                                        />
                                    </div>
                                )}
                                <div>
                                    <span className="text-muted-foreground">Subject:</span>
                                    <span className="ml-2 font-bold">{selectedCitizenForArrest.firstName} {selectedCitizenForArrest.lastName}</span>
                                </div>
                            </div>
                        )}
                        
                        <div>
                            <Label className="text-xs font-mono">REASON</Label>
                            <Input 
                                placeholder="Reason for arrest..."
                                value={newArrest.reason}
                                onChange={(e) => setNewArrest({...newArrest, reason: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">ARTICLES (e.g., PC 459)</Label>
                            <Input 
                                placeholder="Articles/Charges..."
                                value={newArrest.articles}
                                onChange={(e) => setNewArrest({...newArrest, articles: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">DESCRIPTION</Label>
                            <Input 
                                placeholder="Additional details..."
                                value={newArrest.description}
                                onChange={(e) => setNewArrest({...newArrest, description: e.target.value})}
                            />
                        </div>
                        
                        <div>
                            <Label className="text-xs font-mono">BAIL AMOUNT ($)</Label>
                            <Input 
                                type="number"
                                placeholder="Bail amount (optional)..."
                                value={newArrest.bailAmount}
                                onChange={(e) => setNewArrest({...newArrest, bailAmount: e.target.value})}
                            />
                        </div>
                    </div>
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowArrestDialog(false)}>
                            CANCEL
                        </Button>
                        <Button onClick={handleCreateArrest} className="bg-orange-500 hover:bg-orange-600">
                            CREATE ARREST
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showFineDetailDialog} onOpenChange={setShowFineDetailDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle className="font-mono text-yellow-500">// FINE DETAILS</DialogTitle>
                    </DialogHeader>
                    {selectedFine && (
                        <div className="space-y-4 py-4">
                            <div className="flex items-center gap-4">
                                <div className="text-3xl font-bold text-yellow-500">${selectedFine.amount}</div>
                                <Badge variant="outline" className="border-yellow-500/50 text-yellow-500 text-sm">
                                    {selectedFine.status?.toUpperCase() || 'UNPAID'}
                                </Badge>
                            </div>
                            
                            <div className="space-y-3">
                                <div>
                                    <span className="text-xs text-muted-foreground">REASON</span>
                                    <p className="text-sm font-medium">{selectedFine.reason}</p>
                                </div>
                                
                                {selectedFine.article && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">ARTICLE</span>
                                        <p className="text-sm font-medium">{selectedFine.article}</p>
                                    </div>
                                )}
                                
                                {selectedFine.description && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">DESCRIPTION</span>
                                        <p className="text-sm">{selectedFine.description}</p>
                                    </div>
                                )}
                                
                                <div className="grid grid-cols-2 gap-2">
                                    <div>
                                        <span className="text-xs text-muted-foreground">ISSUED DATE</span>
                                        <p className="text-sm">{selectedFine.issuedDate ? new Date(selectedFine.issuedDate).toLocaleDateString() : 'N/A'}</p>
                                    </div>
                                    {selectedFine.incidentDate && (
                                        <div>
                                            <span className="text-xs text-muted-foreground">INCIDENT DATE</span>
                                            <p className="text-sm">{new Date(selectedFine.incidentDate).toLocaleDateString()}</p>
                                        </div>
                                    )}
                                </div>
                                
                                {selectedFine.incidentTime && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">INCIDENT TIME</span>
                                        <p className="text-sm font-mono">{selectedFine.incidentTime}</p>
                                    </div>
                                )}
                                
                                {selectedFine.officerName && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">ISSUING OFFICER</span>
                                        <p className="text-sm">{selectedFine.officerName}</p>
                                    </div>
                                )}
                            </div>
                        </div>
                    )}
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowFineDetailDialog(false)}>
                            CLOSE
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showArrestDetailDialog} onOpenChange={setShowArrestDetailDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle className="font-mono text-orange-500">// ARREST DETAILS</DialogTitle>
                    </DialogHeader>
                    {selectedArrest && (
                        <div className="space-y-4 py-4">
                            <div className="flex items-center gap-4">
                                <Badge className="bg-orange-500 text-lg px-3 py-1">
                                    {selectedArrest.status?.toUpperCase() || 'HELD'}
                                </Badge>
                                {selectedArrest.bondAmount && (
                                    <span className="text-lg font-bold text-yellow-500">${selectedArrest.bondAmount} BAIL</span>
                                )}
                            </div>
                            
                            <div className="space-y-3">
                                <div>
                                    <span className="text-xs text-muted-foreground">REASON</span>
                                    <p className="text-sm font-medium">{selectedArrest.reason}</p>
                                </div>
                                
                                {selectedArrest.articles && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">ARTICLES/CHARGES</span>
                                        <p className="text-sm font-medium">{selectedArrest.articles}</p>
                                    </div>
                                )}
                                
                                {selectedArrest.description && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">DESCRIPTION</span>
                                        <p className="text-sm">{selectedArrest.description}</p>
                                    </div>
                                )}
                                
                                <div className="grid grid-cols-2 gap-2">
                                    <div>
                                        <span className="text-xs text-muted-foreground">ARREST DATE</span>
                                        <p className="text-sm">{selectedArrest.arrestedDate ? new Date(selectedArrest.arrestedDate).toLocaleDateString() : 'N/A'}</p>
                                    </div>
                                    {selectedArrest.releaseDate && (
                                        <div>
                                            <span className="text-xs text-muted-foreground">RELEASE DATE</span>
                                            <p className="text-sm">{new Date(selectedArrest.releaseDate).toLocaleDateString()}</p>
                                        </div>
                                    )}
                                </div>
                                
                                {selectedArrest.officerName && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">ARRESTING OFFICER</span>
                                        <p className="text-sm">{selectedArrest.officerName}</p>
                                    </div>
                                )}
                                
                                {selectedArrest.warrantId && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">WARRANT ID</span>
                                        <p className="text-sm font-mono">{selectedArrest.warrantId}</p>
                                    </div>
                                )}
                            </div>
                        </div>
                    )}
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowArrestDetailDialog(false)}>
                            CLOSE
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            <Dialog open={showWarrantDetailDialog} onOpenChange={setShowWarrantDetailDialog}>
                <DialogContent className="max-w-md">
                    <DialogHeader>
                        <DialogTitle className="font-mono text-red-500">// WARRANT DETAILS</DialogTitle>
                    </DialogHeader>
                    {selectedWarrant && (
                        <div className="space-y-4 py-4">
                            <div className="flex items-center gap-4">
                                <span className="text-lg font-bold text-red-500">{selectedWarrant.title}</span>
                                <Badge className="bg-red-500">
                                    {selectedWarrant.status?.toUpperCase() || 'ACTIVE'}
                                </Badge>
                            </div>
                            
                            <div className="space-y-3">
                                <div>
                                    <span className="text-xs text-muted-foreground">REASON</span>
                                    <p className="text-sm font-medium">{selectedWarrant.reason}</p>
                                </div>
                                
                                {selectedWarrant.description && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">DESCRIPTION</span>
                                        <p className="text-sm">{selectedWarrant.description}</p>
                                    </div>
                                )}
                                
                                <div>
                                    <span className="text-xs text-muted-foreground">ISSUE DATE</span>
                                    <p className="text-sm">{selectedWarrant.issuedDate ? new Date(selectedWarrant.issuedDate).toLocaleDateString() : 'N/A'}</p>
                                </div>
                                
                                {selectedWarrant.expirationDate && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">EXPIRATION DATE</span>
                                        <p className="text-sm">{new Date(selectedWarrant.expirationDate).toLocaleDateString()}</p>
                                    </div>
                                )}
                                
                                {selectedWarrant.officerName && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">ISSUING OFFICER</span>
                                        <p className="text-sm">{selectedWarrant.officerName}</p>
                                    </div>
                                )}
                                
                                {selectedWarrant.judgeName && (
                                    <div>
                                        <span className="text-xs text-muted-foreground">JUDGE</span>
                                        <p className="text-sm">{selectedWarrant.judgeName}</p>
                                    </div>
                                )}
                            </div>
                        </div>
                    )}
                    <DialogFooter>
                        <Button variant="outline" onClick={() => setShowWarrantDetailDialog(false)}>
                            CLOSE
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </div>
    );
}
