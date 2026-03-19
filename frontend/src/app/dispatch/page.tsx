"use client";

import { useEffect, useState, useCallback, useMemo } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CivilianModal } from "@/components/CivilianModal";
import { RadioPanel } from "@/components/dispatch/RadioPanel";
import { useSocket } from "@/hooks/useSocket";
import { useLanguage } from "@/hooks/useLanguage";
import { toast } from "sonner";
import { LiveMap } from "@/components/LiveMap";
import {
  Phone,
  Users,
  User,
  MapPin,
  AlertTriangle,
  Clock,
  Plus,
  Car,
  Stethoscope,
  Flame,
  Shield,
  ChevronRight,
  Activity,
  Siren,
  Radio,
  Target,
  TrendingUp,
  TrendingDown,
  Bell,
  Calendar,
  Trash2,
  AlertCircle,
} from "lucide-react";
import api from "@/lib/api/axios";
import { sounds } from "@/lib/sounds";

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

interface CallLog {
  id: string;
  type: string;
  content: string;
  authorId?: string;
  authorName?: string;
  createdAt: string;
}

interface Unit {
  id: string;
  callsign: string;
  status: string;
  type: string;
  name?: string;
  firstName?: string;
  lastName?: string;
  rank?: string;
  department?: {
    name: string;
    shortName: string;
    color: string;
  };
  onDuty: boolean;
  startedAt?: string;
}

interface Civilian {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth?: string;
  phone?: string;
  address?: string;
  licenses?: {
    driver?: { status: "valid" | "suspended" | "expired"; expires?: string };
    weapon?: { status: "valid" | "suspended" | "expired"; expires?: string };
  };
  warrants?: string[];
  notes?: string;
}

interface Stats {
  calls: {
    pending: number;
    active: number;
    critical: number;
    total: number;
    completed: number;
  };
  units: { available: number; busy: number; onDuty: number; total: number };
}

interface ResponseTime {
  hour: number;
  avgTime: number;
  callCount: number;
}

interface ShiftSchedule {
  id: string;
  unitId: string;
  officerId: string;
  officerName: string;
  dayOfWeek: number;
  startTime: string;
  endTime: string;
  shiftType: "DAY" | "NIGHT" | "SWING";
  isActive: boolean;
}

interface ActivityData {
  callsByHour: { hour: number; count: number }[];
  totalCalls: number;
  avgResponseTime: number;
}

const priorityColors: Record<string, string> = {
  low: "bg-blue-500",
  medium: "bg-yellow-500",
  high: "bg-orange-500",
  critical: "bg-red-500",
};

const statusLabels: Record<string, string> = {
  pending: "Ожидает",
  dispatched: "Назначен",
  enroute: "В пути",
  on_scene: "На месте",
  completed: "Завершён",
  cancelled: "Отменён",
};

const statusColors: Record<string, string> = {
  pending: "bg-yellow-500",
  dispatched: "bg-blue-500",
  enroute: "bg-purple-500",
  on_scene: "bg-green-500",
  completed: "bg-gray-500",
  cancelled: "bg-red-500",
};

const unitStatusColors: Record<string, string> = {
  available: "bg-green-500",
  busy: "bg-yellow-500",
  enroute: "bg-purple-500",
  on_scene: "bg-blue-500",
  off_duty: "bg-gray-500",
};

const typeIcons: Record<string, any> = {
  911: AlertTriangle,
  traffic: Car,
  crime: Shield,
  medical: Stethoscope,
  fire: Flame,
  other: Siren,
};

export default function DispatchPage() {
  const { t } = useLanguage();
  const [activeTab, setActiveTab] = useState("calls");
  const [calls, setCalls] = useState<Call[]>([]);
  const [units, setUnits] = useState<Unit[]>([]);
  const [civilians, setCivilians] = useState<Civilian[]>([]);
  const [stats, setStats] = useState<Stats | null>(null);
  const [responseTimes, setResponseTimes] = useState<ResponseTime[]>([]);
  const [activity, setActivity] = useState<ActivityData | null>(null);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [searchBy, setSearchBy] = useState<"name" | "phone" | "address">(
    "name",
  );
  const [selectedCall, setSelectedCall] = useState<Call | null>(null);
  const [callLogs, setCallLogs] = useState<CallLog[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const [showNewCallDialog, setShowNewCallDialog] = useState(false);
  const [selectedCivilian, setSelectedCivilian] = useState<Civilian | null>(
    null,
  );
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [filterType, setFilterType] = useState<string>("all");
  const [schedules, setSchedules] = useState<ShiftSchedule[]>([]);
  const [radioConfig, setRadioConfig] = useState<any | null>(null);
  const [radioStatus, setRadioStatus] = useState<any | null>(null);
  const [radioError, setRadioError] = useState<string | null>(null);
  const [radioLoading, setRadioLoading] = useState(false);
  const [radioAction, setRadioAction] = useState<string | null>(null);
  const [radioFrequency, setRadioFrequency] = useState("");
  const [radioBroadcastType, setRadioBroadcastType] = useState("Information");
  const [radioBroadcastTone, setRadioBroadcastTone] = useState("NONE");
  const [radioBroadcastMessage, setRadioBroadcastMessage] = useState("");
  const [radioTone, setRadioTone] = useState("ALERT_A");
  const [radioAlertId, setRadioAlertId] = useState("");
  const [radioUserId, setRadioUserId] = useState("");
  const [radioUserMessage, setRadioUserMessage] = useState("");

  const { isConnected, on, off, emit } = useSocket();

  const [newCall, setNewCall] = useState({
    type: "911",
    priority: "medium",
    location: "",
    description: "",
    callerName: "",
    callerPhone: "",
  });

  const fetchData = useCallback(async () => {
    try {
      const [
        callsRes,
        policeUnits,
        fireUnits,
        statsRes,
        activityRes,
        timesRes,
        schedulesRes,
      ] = await Promise.all([
        api.get(
          `/character/emergency-calls?status=${filterStatus}&type=${filterType}`,
        ),
        api.get("/leo/active-officers"),
        api.get("/dispatch/units?type=fire"),
        api.get("/dispatch/stats"),
        api.get("/dispatch/activity"),
        api.get("/dispatch/response-times"),
        api.get("/dispatch/schedules"),
      ]);

      const allUnits = [
        ...(policeUnits.data || policeUnits || []).map((u: any) => ({
          ...u,
          unitType: "police",
        })),
        ...(fireUnits.data || fireUnits || []).map((u: any) => ({
          ...u,
          unitType: "fire",
        })),
      ];

      setCalls(callsRes.data?.calls || callsRes.data || callsRes || []);
      setUnits(
        allUnits.map((u: any) => ({
          id: u.id,
          callsign: u.callsign,
          status: u.status,
          type: u.type || u.unitType,
          name: u.firstName
            ? `${u.firstName} ${u.lastName || ""}`.trim()
            : u.callsign,
          firstName: u.firstName,
          lastName: u.lastName,
          rank: u.rank,
          department: u.department,
          onDuty: u.onDuty !== false,
          startedAt: u.startedAt,
        })),
      );

      const statsData = statsRes.data || statsRes;

      // Calculate stats from local data
      const allCalls = callsRes.data?.calls || callsRes.data || callsRes || [];
      const pendingCalls = allCalls.filter(
        (c: any) => c.status === "pending",
      ).length;
      const activeCalls = allCalls.filter((c: any) =>
        ["dispatched", "enroute", "on_scene"].includes(c.status),
      ).length;
      const criticalCalls = allCalls.filter(
        (c: any) => c.priority === "critical" && c.status !== "completed",
      ).length;

      const availableUnits = allUnits.filter(
        (u: any) => u.onDuty && u.status === "available",
      ).length;
      const busyUnits = allUnits.filter(
        (u: any) => u.onDuty && u.status !== "available",
      ).length;
      const onDutyUnits = allUnits.filter((u: any) => u.onDuty).length;

      const calculatedStats = {
        calls: {
          pending: pendingCalls,
          active: activeCalls,
          critical: criticalCalls,
          total: allCalls.length,
          completed: allCalls.filter((c: any) => c.status === "completed")
            .length,
        },
        units: {
          available: availableUnits,
          busy: busyUnits,
          onDuty: onDutyUnits,
          total: allUnits.length,
        },
      };

      setStats(calculatedStats);

      const activityData = activityRes.data || activityRes;
      setActivity(
        activityData || { callsByHour: [], totalCalls: 0, avgResponseTime: 0 },
      );
      setResponseTimes(timesRes.data || timesRes || []);
      setSchedules(schedulesRes.data || schedulesRes || []);
    } catch (error) {
      console.error("Error fetching data:", error);
      setCalls([]);
      setUnits([]);
      setStats({
        calls: { pending: 0, active: 0, critical: 0, total: 0, completed: 0 },
        units: { available: 0, busy: 0, onDuty: 0, total: 0 },
      });
    } finally {
      setLoading(false);
    }
  }, [filterStatus, filterType]);

  const searchCivilians = async (term: string) => {
    if (term.length < 2) {
      setCivilians([]);
      return;
    }
    try {
      const res = await api.get(
        `/dispatch/civilians?search=${term}&searchBy=${searchBy}`,
      );
      setCivilians(res.data);
    } catch (error) {
      console.error("Error searching civilians:", error);
    }
  };

  const fetchRadioConfig = useCallback(async () => {
    setRadioLoading(true);
    try {
      const res = await api.get("/radio/dispatch/config");
      setRadioConfig(res.data);
      setRadioError(null);
    } catch (error) {
      console.error("Error fetching radio config:", error);
      setRadioError("Radio config unavailable");
    } finally {
      setRadioLoading(false);
    }
  }, []);

  const fetchRadioStatus = useCallback(async () => {
    try {
      const res = await api.get("/radio/dispatch/status");
      setRadioStatus(res.data);
      setRadioError(null);
    } catch (error) {
      console.error("Error fetching radio status:", error);
      setRadioError("Radio status unavailable");
    }
  }, []);

  const refreshRadio = useCallback(async () => {
    await Promise.all([fetchRadioConfig(), fetchRadioStatus()]);
  }, [fetchRadioConfig, fetchRadioStatus]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  useEffect(() => {
    if (searchTerm.length >= 2) {
      searchCivilians(searchTerm);
    } else {
      setCivilians([]);
    }
  }, [searchTerm, searchBy]);

  useEffect(() => {
    fetchRadioConfig();
    fetchRadioStatus();
  }, [fetchRadioConfig, fetchRadioStatus]);

  useEffect(() => {
    const interval = setInterval(() => {
      fetchRadioStatus();
    }, 15000);
    return () => clearInterval(interval);
  }, [fetchRadioStatus]);

  const radioChannels = useMemo(() => {
    const zones = radioConfig?.zones;
    if (!zones || typeof zones !== "object") return [];

    const items: {
      frequency: string;
      label: string;
      name?: string;
      zone?: string;
      type?: string;
    }[] = [];

    Object.values(zones).forEach((zone: any) => {
      const zoneName = zone?.name || zone?.Name || "ZONE";
      const channels = zone?.Channels || zone?.channels || {};
      Object.values(channels).forEach((channel: any) => {
        if (!channel?.frequency) return;
        const frequency = String(channel.frequency);
        const name = channel?.name || channel?.Name || "CH";
        const type = channel?.type || channel?.Type;
        items.push({
          frequency,
          name,
          zone: zoneName,
          type,
          label: `${zoneName} / ${name} (${frequency})`,
        });
      });
    });

    return items.sort((a, b) => a.frequency.localeCompare(b.frequency));
  }, [radioConfig]);

  const radioAlerts = useMemo(() => {
    const alerts = radioConfig?.alerts;
    if (!alerts || typeof alerts !== "object") return [];

    return Object.entries(alerts).map(([id, alert]: [string, any]) => ({
      id,
      ...alert,
    }));
  }, [radioConfig]);

  const radioUsers = useMemo(() => {
    const users = radioStatus?.users;
    if (!users || typeof users !== "object") return [];

    return Object.entries(users).map(([id, user]: [string, any]) => ({
      id,
      ...user,
    }));
  }, [radioStatus]);

  useEffect(() => {
    if (!radioFrequency && radioChannels.length > 0) {
      setRadioFrequency(radioChannels[0].frequency);
    }
  }, [radioChannels, radioFrequency]);

  useEffect(() => {
    if (!radioAlertId && radioAlerts.length > 0) {
      setRadioAlertId(radioAlerts[0].id);
    }
  }, [radioAlerts, radioAlertId]);

  useEffect(() => {
    if (!isConnected) return;

    emit("join-dispatch");

    on("new-call", (newCall: Call) => {
      setCalls((prev) => [newCall, ...prev]);
      sounds.newCall();
      toast.info(`Новый вызов: ${newCall.type}`, {
        description: newCall.description,
      });
      fetchData();
    });

    on("call-created", (newCall: Call) => {
      setCalls((prev) => [newCall, ...prev]);
      sounds.newCall();
      toast.info(`Новый вызов: ${newCall.type}`, {
        description: newCall.description,
      });
      fetchData();
    });

    on("call-updated", (updatedCall: Call) => {
      setCalls((prev) =>
        prev.map((c) => (c.id === updatedCall.id ? updatedCall : c)),
      );
      if (selectedCall?.id === updatedCall.id) {
        setSelectedCall(updatedCall);
      }
      fetchData();
    });

    on(
      "unit-status-updated",
      (data: { unitId: string; status: string; onDuty: boolean }) => {
        setUnits((prev) =>
          prev.map((u) =>
            u.id === data.unitId
              ? { ...u, status: data.status as any, onDuty: data.onDuty }
              : u,
          ),
        );
        fetchData();
      },
    );

    on("unit-created", (data: any) => {
      setUnits((prev) => [
        ...prev,
        {
          id: data.id,
          callsign: data.callsign,
          status: data.status,
          type: data.type,
          name: data.firstName
            ? `${data.firstName} ${data.lastName || ""}`.trim()
            : data.callsign,
          firstName: data.firstName,
          lastName: data.lastName,
          rank: data.rank,
          department: data.department,
          onDuty: data.onDuty !== false,
          startedAt: data.startedAt,
        },
      ]);
      toast.success(`${data.callsign} вышел на смену`);
      fetchData();
    });

    on("unit-updated", (data: any) => {
      setUnits((prev) =>
        prev.map((u) =>
          u.id === data.id
            ? {
                ...u,
                status: data.status,
                callsign: data.callsign,
                onDuty: data.onDuty,
              }
            : u,
        ),
      );
      fetchData();
    });

    on("unit-deleted", (data: { id: string; callsign: string }) => {
      setUnits((prev) => prev.filter((u) => u.id !== data.id));
      toast.warning(`${data.callsign} завершил смену`);
      fetchData();
    });

    on(
      "shift-started",
      (data: {
        unitId: string;
        callsign: string;
        officerName: string;
        rank: string;
        department: string;
      }) => {
        toast.success(
          `${data.callsign} - ${data.officerName} (${data.rank}) на дежурстве в ${data.department}`,
        );
        fetchData();
      },
    );

    on(
      "shift-ended",
      (data: { unitId: string; callsign: string; officerName: string }) => {
        toast.warning(`${data.callsign} - ${data.officerName} закончил смену`);
        fetchData();
      },
    );

    on(
      "officer-on-duty",
      (data: { unitId: string; callsign: string; name: string }) => {
        toast.success(`${data.callsign} - ${data.name} на дежурстве`);
        fetchData();
      },
    );

    on("officer-off-duty", (data: { callsign: string }) => {
      toast.warning(`${data.callsign} закончил смену`);
      fetchData();
    });

    on("panic-alert", (data: { unitId: string; location: string }) => {
      toast.error("ТРЕВОГА!", {
        description: `Юнит ${data.unitId} нажал тревожную кнопку: ${data.location}`,
      });
      fetchData();
    });

    on("schedule-updated", () => {
      fetchData();
    });

    on("schedule-deleted", () => {
      fetchData();
    });

    on("call-log-added", (data: { callId: string; log: CallLog }) => {
      if (selectedCall?.id === data.callId) {
        setCallLogs((prev) => [...prev, data.log]);
      }
      fetchData();
    });

    on("call-note-added", (data: { callId: string; log: CallLog }) => {
      if (selectedCall?.id === data.callId) {
        setCallLogs((prev) => [...prev, data.log]);
      }
      fetchData();
    });

    return () => {
      off("new-call");
      off("call-updated");
      off("call-created");
      off("call-log-added");
      off("call-note-added");
      off("unit-status-updated");
      off("unit-created");
      off("unit-updated");
      off("unit-deleted");
      off("shift-started");
      off("shift-ended");
      off("officer-on-duty");
      off("officer-off-duty");
      off("panic-alert");
      off("schedule-updated");
      off("schedule-deleted");
    };
  }, [isConnected, on, off, emit, selectedCall, fetchData]);

  const handleCreateCall = async () => {
    try {
      await api.post("/character/emergency-calls", {
        type: newCall.type === "911" ? "911" : newCall.type,
        priority: newCall.priority,
        location: newCall.location,
        description: newCall.description,
        callerName: newCall.callerName,
        callerPhone: newCall.callerPhone,
      });
      setShowNewCallDialog(false);
      setNewCall({
        type: "911",
        priority: "medium",
        location: "",
        description: "",
        callerName: "",
        callerPhone: "",
      });
      fetchData();
      toast.success("Вызов создан");
    } catch (error) {
      toast.error("Ошибка создания вызова");
    }
  };

  const handleUpdateCallStatus = async (callId: string, status: string) => {
    try {
      await api.put(`/character/emergency-calls/${callId}`, { status });
      fetchData();
      toast.success("Статус обновлён");
    } catch (error) {
      toast.error("Ошибка обновления");
    }
  };

  const handleAssignUnit = async (callId: string, unitId: string) => {
    try {
      const call = calls.find((c) => c.id === callId);
      if (call?.assignedUnits?.includes(unitId)) {
        toast.error("Юнит уже назначен на этот вызов");
        return;
      }
      const updatedUnits = [...(call?.assignedUnits || []), unitId];
      await api.put(`/character/emergency-calls/${callId}`, {
        assignedUnits: updatedUnits,
      });
      sounds.attach();
      fetchData();
      toast.success("Юнит назначен");
    } catch (error) {
      toast.error("Ошибка назначения");
    }
  };

  const handleUpdateUnitStatus = async (unitId: string, status: string) => {
    try {
      await api.put(`/leo/active-officers/${unitId}`, { status });
      fetchData();
      toast.success("Статус юнита обновлён");
    } catch (error) {
      toast.error("Ошибка обновления");
    }
  };

  const fetchCallLogs = async (callId: string) => {
    try {
      const res = await api.get(`/call-logs/${callId}`);
      setCallLogs(res.data.logs || []);
    } catch (error) {
      console.error("Error fetching call logs:", error);
    }
  };

  const handleSendMessage = async () => {
    if (!selectedCall || !newMessage.trim()) return;

    try {
      await api.post(`/call-logs/${selectedCall.id}/note`, {
        content: newMessage.trim(),
      });
      setNewMessage("");
      fetchCallLogs(selectedCall.id);
      fetchData();
    } catch (error) {
      toast.error("Ошибка отправки");
    }
  };

  const toneOptions = ["ALERT_A", "ALERT_B", "PANIC", "BEEP", "BONK", "CHIRP"];

  const runRadioAction = async (
    action: string,
    runner: () => Promise<void>,
    successMessage: string,
  ) => {
    if (radioAction) return;
    setRadioAction(action);
    try {
      await runner();
      toast.success(successMessage);
      fetchRadioStatus();
    } catch (error) {
      console.error(`Radio action failed (${action}):`, error);
      toast.error("Radio action failed");
    } finally {
      setRadioAction(null);
    }
  };

  const ensureRadioFrequency = () => {
    if (!radioFrequency.trim()) {
      toast.error("Frequency required");
      return false;
    }
    return true;
  };

  const handleRadioBroadcast = () => {
    if (!ensureRadioFrequency()) return;
    if (!radioBroadcastMessage.trim()) {
      toast.error("Message required");
      return;
    }

    runRadioAction(
      "broadcast",
      async () => {
        await api.post("/radio/dispatch/broadcast", {
          frequency: radioFrequency.trim(),
          message: radioBroadcastMessage.trim(),
          type: radioBroadcastType,
          tone:
            radioBroadcastTone && radioBroadcastTone !== "NONE"
              ? radioBroadcastTone
              : undefined,
        });
      },
      "Broadcast sent",
    );
  };

  const handleRadioTone = () => {
    if (!ensureRadioFrequency()) return;

    runRadioAction(
      "tone",
      async () => {
        await api.post("/radio/dispatch/tone", {
          frequency: radioFrequency.trim(),
          tone: radioTone,
        });
      },
      "Tone sent",
    );
  };

  const handleRadioAlertTrigger = (oneshot = false) => {
    if (!ensureRadioFrequency()) return;

    const alertConfig = radioAlerts.find((alert) => alert.id === radioAlertId);
    if (!alertConfig) {
      toast.error("Alert type required");
      return;
    }

    runRadioAction(
      oneshot ? "alert-oneshot" : "alert-trigger",
      async () => {
        const path = oneshot
          ? "/radio/dispatch/alert/oneshot"
          : "/radio/dispatch/alert/trigger";
        await api.post(path, {
          frequency: radioFrequency.trim(),
          alertType: alertConfig.name || "Alert",
          alertConfig,
        });
      },
      oneshot ? "One-shot alert sent" : "Alert triggered",
    );
  };

  const handleRadioAlertClear = () => {
    if (!ensureRadioFrequency()) return;

    runRadioAction(
      "alert-clear",
      async () => {
        await api.post("/radio/dispatch/alert/clear", {
          frequency: radioFrequency.trim(),
        });
      },
      "Alert cleared",
    );
  };

  const handleRadioSwitchChannel = () => {
    if (!ensureRadioFrequency()) return;
    if (!radioUserId) {
      toast.error("User required");
      return;
    }

    runRadioAction(
      "switch-channel",
      async () => {
        await api.post("/radio/dispatch/switch-channel", {
          serverId: Number(radioUserId),
          frequency: radioFrequency.trim(),
        });
      },
      "User channel updated",
    );
  };

  const handleRadioUserAlert = () => {
    if (!radioUserId) {
      toast.error("User required");
      return;
    }
    if (!radioUserMessage.trim()) {
      toast.error("Message required");
      return;
    }

    runRadioAction(
      "user-alert",
      async () => {
        await api.post("/radio/dispatch/user-alert", {
          userId: Number(radioUserId),
          message: radioUserMessage.trim(),
          frequency: radioFrequency.trim() || null,
        });
      },
      "User alert sent",
    );
  };

  const handleRadioUserDisconnect = () => {
    if (!radioUserId) {
      toast.error("User required");
      return;
    }

    runRadioAction(
      "user-disconnect",
      async () => {
        await api.post("/radio/dispatch/user-disconnect", {
          userId: Number(radioUserId),
        });
      },
      "User disconnected",
    );
  };

  useEffect(() => {
    if (selectedCall) {
      fetchCallLogs(selectedCall.id);
    }
  }, [selectedCall?.id]);

  const formatTime = (dateStr: string) => {
    const date = new Date(dateStr);
    const now = new Date();
    const diff = Math.floor((now.getTime() - date.getTime()) / 1000);

    if (diff < 60) return `${diff} сек. назад`;
    if (diff < 3600) return `${Math.floor(diff / 60)} мин. назад`;
    if (diff < 86400) return `${Math.floor(diff / 3600)} ч. назад`;
    return date.toLocaleDateString();
  };

  const formatResponseTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}m ${secs}s`;
  };

  const getDayName = (day: number) => {
    const days = [
      "Воскресенье",
      "Понедельник",
      "Вторник",
      "Среда",
      "Четверг",
      "Пятница",
      "Суббота",
    ];
    return days[day];
  };

  const getShiftTypeName = (type: string) => {
    switch (type) {
      case "DAY":
        return "День";
      case "NIGHT":
        return "Ночь";
      case "SWING":
        return "Смена";
      default:
        return type;
    }
  };

  const getShiftTypeColor = (type: string) => {
    switch (type) {
      case "DAY":
        return "bg-yellow-500";
      case "NIGHT":
        return "bg-blue-500";
      case "SWING":
        return "bg-purple-500";
      default:
        return "bg-gray-500";
    }
  };

  const availableUnits = units.filter(
    (u) => u.onDuty && u.status === "available",
  );

  if (loading) {
    return (
      <div className="container mx-auto py-10 px-4">
        <div className="flex items-center justify-center min-h-[400px]">
          <div className="text-center">
            <Activity className="h-8 w-8 animate-spin mx-auto text-primary" />
            <p className="mt-4 text-muted-foreground">
              Загрузка данных диспетчера...
            </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="bg-card border-b">
        <div className="container mx-auto px-4 py-1 flex items-center justify-between text-xs font-mono">
          <div className="flex items-center gap-4">
            <span className="text-muted-foreground">// DISPATCH CONTROL</span>
            <Badge
              variant={isConnected ? "default" : "destructive"}
              className="gap-1"
            >
              {isConnected ? (
                <Activity className="h-3 w-3" />
              ) : (
                <AlertCircle className="h-3 w-3" />
              )}
              {isConnected ? "ONLINE" : "OFFLINE"}
            </Badge>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-muted-foreground">
              ACTIVE:{" "}
              <span className="text-green-500 font-bold">
                {stats?.calls.active || 0}
              </span>
            </span>
            <span className="text-muted-foreground">
              PENDING:{" "}
              <span className="text-yellow-500 font-bold">
                {stats?.calls.pending || 0}
              </span>
            </span>
            <span className="text-muted-foreground">
              CRITICAL:{" "}
              <span className="text-red-500 font-bold">
                {stats?.calls.critical || 0}
              </span>
            </span>
            <span className="text-muted-foreground">
              COMPLETED:{" "}
              <span className="text-gray-500 font-bold">
                {stats?.calls.completed || 0}
              </span>
            </span>
            <span className="text-muted-foreground">
              UNITS:{" "}
              <span className="text-green-500 font-bold">
                {stats?.units.available || 0}
              </span>
              /
              <span className="text-blue-500 font-bold">
                {stats?.units.onDuty || 0}
              </span>
              /
              <span className="text-muted-foreground">
                {stats?.units.total || 0}
              </span>
            </span>
            <Button size="sm" onClick={() => setShowNewCallDialog(true)}>
              <Plus className="h-3 w-3 mr-1" />
              NEW CALL
            </Button>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-2">
        <div className="flex items-center gap-2 mb-4">
          <Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-32 font-mono text-xs">
              <SelectValue placeholder="STATUS" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">ALL</SelectItem>
              <SelectItem value="pending">PENDING</SelectItem>
              <SelectItem value="dispatched">DISPATCHED</SelectItem>
              <SelectItem value="enroute">ENROUTE</SelectItem>
              <SelectItem value="on_scene">ON SCENE</SelectItem>
              <SelectItem value="completed">COMPLETED</SelectItem>
            </SelectContent>
          </Select>
          <Select value={filterType} onValueChange={setFilterType}>
            <SelectTrigger className="w-32 font-mono text-xs">
              <SelectValue placeholder="TYPE" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">ALL</SelectItem>
              <SelectItem value="911">911</SelectItem>
              <SelectItem value="traffic">TRAFFIC</SelectItem>
              <SelectItem value="crime">CRIME</SelectItem>
              <SelectItem value="medical">MEDICAL</SelectItem>
              <SelectItem value="fire">FIRE</SelectItem>
            </SelectContent>
          </Select>
          <Tabs
            value={activeTab}
            onValueChange={setActiveTab}
            className="ml-auto"
          >
            <TabsList className="font-mono text-xs h-8">
              <TabsTrigger value="calls" className="text-xs px-3">
                CALLS
              </TabsTrigger>
              <TabsTrigger value="units" className="text-xs px-3">
                UNITS
              </TabsTrigger>
              <TabsTrigger value="map" className="text-xs px-3">
                MAP
              </TabsTrigger>
              <TabsTrigger value="civilians" className="text-xs px-3">
                CIV
              </TabsTrigger>
              <TabsTrigger value="stats" className="text-xs px-3">
                STATS
              </TabsTrigger>
            </TabsList>
          </Tabs>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsContent value="calls" className="mt-0">
            <div className="flex items-center gap-2 mb-2 p-2 bg-muted/30 rounded font-mono text-xs">
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">911:</span>
                <span className="text-red-500 font-bold">
                  {calls.filter((c) => c.type === "911").length}
                </span>
              </div>
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">TRAFFIC:</span>
                <span className="text-yellow-500 font-bold">
                  {calls.filter((c) => c.type === "traffic").length}
                </span>
              </div>
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">CRIME:</span>
                <span className="text-purple-500 font-bold">
                  {calls.filter((c) => c.type === "crime").length}
                </span>
              </div>
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">MEDICAL:</span>
                <span className="text-red-400 font-bold">
                  {calls.filter((c) => c.type === "medical").length}
                </span>
              </div>
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">FIRE:</span>
                <span className="text-orange-500 font-bold">
                  {calls.filter((c) => c.type === "fire").length}
                </span>
              </div>
              <div className="ml-auto flex items-center gap-1">
                <span className="text-muted-foreground">AVL:</span>
                <span className="text-green-500 font-bold">
                  {
                    units.filter((u) => u.onDuty && u.status === "available")
                      .length
                  }
                </span>
              </div>
              <div className="flex items-center gap-1">
                <span className="text-muted-foreground">BUSY:</span>
                <span className="text-yellow-500 font-bold">
                  {
                    units.filter((u) => u.onDuty && u.status !== "available")
                      .length
                  }
                </span>
              </div>
            </div>
            <div className="grid gap-3 lg:grid-cols-3">
              <div className="lg:col-span-2 space-y-2">
                <ScrollArea className="h-[calc(100vh-180px)] pr-3">
                  <div className="space-y-1">
                    {calls
                      .filter(
                        (c) =>
                          c.status !== "completed" && c.status !== "cancelled",
                      )
                      .map((call) => {
                        const TypeIcon = typeIcons[call.type] || Siren;
                        const isSelected = selectedCall?.id === call.id;
                        return (
                          <div
                            key={call.id}
                            className={`p-2 rounded cursor-pointer transition-all border-l-3 text-xs font-mono ${
                              isSelected
                                ? "bg-primary/20 border-l-primary"
                                : call.priority === "critical"
                                  ? "bg-red-500/10 border-l-red-500 hover:bg-red-500/20"
                                  : call.priority === "high"
                                    ? "bg-orange-500/10 border-l-orange-500 hover:bg-orange-500/20"
                                    : "bg-muted/30 border-l-muted-foreground hover:bg-muted/50"
                            }`}
                            onClick={() => setSelectedCall(call)}
                          >
                            <div className="flex items-center justify-between">
                              <div className="flex items-center gap-2">
                                <TypeIcon
                                  className={`h-3 w-3 ${call.type === "911" ? "text-red-500" : "text-muted-foreground"}`}
                                />
                                <span
                                  className={
                                    call.priority === "critical"
                                      ? "text-red-500 font-bold"
                                      : ""
                                  }
                                >
                                  {call.type === "911"
                                    ? "911"
                                    : call.type.toUpperCase()}
                                </span>
                                <Badge
                                  className={`${priorityColors[call.priority]} text-[10px] py-0 h-4`}
                                >
                                  {call.priority.toUpperCase()}
                                </Badge>
                                <Badge
                                  className={`${statusColors[call.status]} text-[10px] py-0 h-4`}
                                >
                                  {call.status.toUpperCase()}
                                </Badge>
                              </div>
                              <span className="text-muted-foreground">
                                {formatTime(call.createdAt)}
                              </span>
                            </div>
                            <p className="mt-1 line-clamp-1">
                              {call.description}
                            </p>
                            <div className="flex items-center gap-2 mt-1 text-muted-foreground">
                              <MapPin className="h-3 w-3" />
                              <span className="truncate">{call.location}</span>
                            </div>
                            {call.assignedUnits.length > 0 && (
                              <div className="flex flex-wrap gap-1 mt-1">
                                {call.assignedUnits.map((unitId, idx) => {
                                  const unit = units.find(
                                    (u) => u.id === unitId,
                                  );
                                  return (
                                    <Badge
                                      key={idx}
                                      variant="outline"
                                      className="text-[10px] py-0 h-4"
                                    >
                                      {unit?.callsign || "UNK"}
                                    </Badge>
                                  );
                                })}
                              </div>
                            )}
                          </div>
                        );
                      })}
                    {calls.filter(
                      (c) =>
                        c.status !== "completed" && c.status !== "cancelled",
                    ).length === 0 && (
                      <p className="text-center text-muted-foreground py-8 font-mono text-xs">
                        NO ACTIVE CALLS
                      </p>
                    )}
                  </div>
                </ScrollArea>
              </div>

              <div className="space-y-2">
                {selectedCall ? (
                  <div className="bg-muted/30 rounded-lg p-3 space-y-3 text-xs font-mono">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <span className="font-bold">
                          {selectedCall.type === "911" ? (
                            <>
                              <AlertCircle className="h-4 w-4 inline text-red-500" />{" "}
                              911
                            </>
                          ) : (
                            selectedCall.type.toUpperCase()
                          )}
                        </span>
                        <Badge
                          className={`${priorityColors[selectedCall.priority]} text-[10px] py-0 h-4`}
                        >
                          {selectedCall.priority.toUpperCase()}
                        </Badge>
                        <Badge
                          className={`${statusColors[selectedCall.status]} text-[10px] py-0 h-4`}
                        >
                          {selectedCall.status.toUpperCase()}
                        </Badge>
                      </div>
                      <span className="text-muted-foreground">
                        {formatTime(selectedCall.createdAt)}
                      </span>
                    </div>

                    <div className="flex items-center gap-2">
                      <MapPin className="h-3 w-3 text-muted-foreground" />
                      <span className="font-medium">
                        {selectedCall.location}
                      </span>
                    </div>

                    <div className="bg-background rounded p-2">
                      <p className="text-muted-foreground mb-1">DESC</p>
                      <p>{selectedCall.description}</p>
                    </div>

                    {(selectedCall.callerName || selectedCall.callerPhone) && (
                      <div className="flex items-center gap-2">
                        <User className="h-3 w-3 text-muted-foreground" />
                        <span>
                          {selectedCall.callerName}{" "}
                          {selectedCall.callerPhone &&
                            `(${selectedCall.callerPhone})`}
                        </span>
                      </div>
                    )}

                    <div>
                      <p className="text-muted-foreground mb-1">
                        UNITS: {selectedCall.assignedUnits.length}
                      </p>
                      <div className="flex flex-wrap gap-1">
                        {selectedCall.assignedUnits.length > 0 ? (
                          selectedCall.assignedUnits.map((unitId, idx) => {
                            const unit = units.find((u) => u.id === unitId);
                            return (
                              <Badge
                                key={idx}
                                variant="outline"
                                className="text-[10px] py-0 h-4"
                              >
                                {unit?.callsign || "UNK"}
                              </Badge>
                            );
                          })
                        ) : (
                          <span className="text-muted-foreground">
                            NO UNITS
                          </span>
                        )}
                      </div>
                    </div>

                    <div className="pt-2 border-t">
                      <p className="text-muted-foreground mb-1">ASSIGN</p>
                      <div className="flex flex-wrap gap-1">
                        {availableUnits.map((unit) => (
                          <Button
                            key={unit.id}
                            variant="outline"
                            size="sm"
                            className="text-[10px] h-5"
                            onClick={() =>
                              handleAssignUnit(selectedCall.id, unit.id)
                            }
                          >
                            {unit.callsign}
                          </Button>
                        ))}
                        {availableUnits.length === 0 && (
                          <span className="text-muted-foreground text-[10px]">
                            NO AVAILABLE
                          </span>
                        )}
                      </div>
                    </div>

                    <div className="pt-2 border-t">
                      <p className="text-muted-foreground mb-1">STATUS</p>
                      <div className="flex flex-wrap gap-1">
                        {[
                          "pending",
                          "dispatched",
                          "enroute",
                          "on_scene",
                          "completed",
                        ].map((status) => (
                          <Button
                            key={status}
                            variant={
                              selectedCall.status === status
                                ? "default"
                                : "outline"
                            }
                            size="sm"
                            className="text-[10px] h-5"
                            onClick={() =>
                              handleUpdateCallStatus(selectedCall.id, status)
                            }
                          >
                            {status.toUpperCase()}
                          </Button>
                        ))}
                      </div>
                    </div>
                  </div>
                ) : (
                  <div className="bg-muted/30 rounded-lg p-8 text-center text-muted-foreground font-mono text-xs">
                    SELECT CALL
                  </div>
                )}

                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="flex items-center gap-2 text-sm font-mono">
                      <Radio className="h-4 w-4" />
                      RADIO CONTROL
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-3 text-xs font-mono">
                    <div className="flex items-center justify-between gap-2">
                      <div className="flex items-center gap-2">
                        <span className="text-muted-foreground">STATUS</span>
                        <Badge
                          variant={radioError ? "destructive" : "default"}
                          className="text-[10px] py-0 h-4"
                        >
                          {radioError ? "OFFLINE" : "READY"}
                        </Badge>
                      </div>
                      <Button
                        variant="outline"
                        size="sm"
                        className="h-6 text-[10px]"
                        onClick={refreshRadio}
                        disabled={radioLoading}
                      >
                        REFRESH
                      </Button>
                    </div>

                    <div className="grid gap-2 md:grid-cols-2">
                      <div>
                        <Label className="text-[10px] text-muted-foreground">
                          FREQUENCY
                        </Label>
                        <Input
                          value={radioFrequency}
                          onChange={(e) => setRadioFrequency(e.target.value)}
                          placeholder="154.755"
                          className="h-7 text-xs font-mono"
                        />
                      </div>
                      <div>
                        <Label className="text-[10px] text-muted-foreground">
                          CHANNEL
                        </Label>
                        <Select
                          value={radioFrequency}
                          onValueChange={setRadioFrequency}
                        >
                          <SelectTrigger className="h-7 text-xs font-mono">
                            <SelectValue placeholder="Select channel" />
                          </SelectTrigger>
                          <SelectContent>
                            {radioChannels.length === 0 ? (
                              <SelectItem value="no-channels" disabled>
                                No channels available
                              </SelectItem>
                            ) : (
                              radioChannels.map((channel) => (
                                <SelectItem
                                  key={`${channel.zone}-${channel.frequency}`}
                                  value={channel.frequency}
                                >
                                  {channel.label}
                                </SelectItem>
                              ))
                            )}
                          </SelectContent>
                        </Select>
                      </div>
                    </div>

                    <div className="rounded-lg border bg-muted/20 p-2 space-y-2">
                      <div className="flex items-center justify-between gap-2">
                        <span className="text-muted-foreground">BROADCAST</span>
                        <Button
                          size="sm"
                          className="h-6 text-[10px]"
                          onClick={handleRadioBroadcast}
                          disabled={radioAction !== null}
                        >
                          SEND
                        </Button>
                      </div>
                      <div className="grid gap-2 md:grid-cols-2">
                        <Select
                          value={radioBroadcastType}
                          onValueChange={setRadioBroadcastType}
                        >
                          <SelectTrigger className="h-7 text-xs font-mono">
                            <SelectValue placeholder="Type" />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="Information">
                              INFORMATION
                            </SelectItem>
                            <SelectItem value="Warning">WARNING</SelectItem>
                            <SelectItem value="Emergency">EMERGENCY</SelectItem>
                          </SelectContent>
                        </Select>
                        <Select
                          value={radioBroadcastTone}
                          onValueChange={setRadioBroadcastTone}
                        >
                          <SelectTrigger className="h-7 text-xs font-mono">
                            <SelectValue placeholder="Tone" />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="NONE">NO TONE</SelectItem>
                            {toneOptions.map((tone) => (
                              <SelectItem key={tone} value={tone}>
                                {tone}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                      </div>
                      <Textarea
                        value={radioBroadcastMessage}
                        onChange={(e) =>
                          setRadioBroadcastMessage(e.target.value)
                        }
                        placeholder="Broadcast message..."
                        className="min-h-[70px] text-xs font-mono"
                      />
                    </div>

                    <div className="rounded-lg border bg-muted/20 p-2 space-y-2">
                      <div className="flex items-center justify-between gap-2">
                        <span className="text-muted-foreground">TONE</span>
                        <Button
                          size="sm"
                          className="h-6 text-[10px]"
                          onClick={handleRadioTone}
                          disabled={radioAction !== null}
                        >
                          PLAY
                        </Button>
                      </div>
                      <Select value={radioTone} onValueChange={setRadioTone}>
                        <SelectTrigger className="h-7 text-xs font-mono">
                          <SelectValue placeholder="Tone" />
                        </SelectTrigger>
                        <SelectContent>
                          {toneOptions.map((tone) => (
                            <SelectItem key={tone} value={tone}>
                              {tone}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="rounded-lg border bg-muted/20 p-2 space-y-2">
                      <div className="flex items-center justify-between gap-2">
                        <span className="text-muted-foreground">ALERTS</span>
                        <div className="flex items-center gap-1">
                          <Button
                            size="sm"
                            className="h-6 text-[10px]"
                            onClick={() => handleRadioAlertTrigger(false)}
                            disabled={radioAction !== null}
                          >
                            TRIGGER
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            className="h-6 text-[10px]"
                            onClick={() => handleRadioAlertTrigger(true)}
                            disabled={radioAction !== null}
                          >
                            ONESHOT
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            className="h-6 text-[10px]"
                            onClick={handleRadioAlertClear}
                            disabled={radioAction !== null}
                          >
                            CLEAR
                          </Button>
                        </div>
                      </div>
                      <Select
                        value={radioAlertId}
                        onValueChange={setRadioAlertId}
                      >
                        <SelectTrigger className="h-7 text-xs font-mono">
                          <SelectValue placeholder="Alert type" />
                        </SelectTrigger>
                          <SelectContent>
                            {radioAlerts.length === 0 ? (
                              <SelectItem value="no-alerts" disabled>
                                No alerts available
                              </SelectItem>
                            ) : (
                              radioAlerts.map((alert) => (
                                <SelectItem key={alert.id} value={alert.id}>
                                  {alert.name || alert.id}
                                </SelectItem>
                              ))
                            )}
                          </SelectContent>
                      </Select>
                    </div>

                    <div className="rounded-lg border bg-muted/20 p-2 space-y-2">
                      <div className="flex items-center justify-between gap-2">
                        <span className="text-muted-foreground">USER</span>
                        <div className="flex items-center gap-1">
                          <Button
                            size="sm"
                            variant="outline"
                            className="h-6 text-[10px]"
                            onClick={handleRadioSwitchChannel}
                            disabled={radioAction !== null}
                          >
                            MOVE
                          </Button>
                          <Button
                            size="sm"
                            className="h-6 text-[10px]"
                            onClick={handleRadioUserAlert}
                            disabled={radioAction !== null}
                          >
                            ALERT
                          </Button>
                          <Button
                            size="sm"
                            variant="destructive"
                            className="h-6 text-[10px]"
                            onClick={handleRadioUserDisconnect}
                            disabled={radioAction !== null}
                          >
                            KICK
                          </Button>
                        </div>
                      </div>
                      <Select
                        value={radioUserId}
                        onValueChange={setRadioUserId}
                      >
                        <SelectTrigger className="h-7 text-xs font-mono">
                          <SelectValue placeholder="Select user" />
                        </SelectTrigger>
                          <SelectContent>
                            {radioUsers.length === 0 ? (
                              <SelectItem value="no-users" disabled>
                                No users available
                              </SelectItem>
                            ) : (
                              radioUsers.map((user) => (
                                <SelectItem key={user.id} value={user.id}>
                                  {user.name || "USER"} #{user.id}
                                </SelectItem>
                              ))
                            )}
                          </SelectContent>
                      </Select>
                      <Input
                        value={radioUserMessage}
                        onChange={(e) => setRadioUserMessage(e.target.value)}
                        placeholder="User alert message..."
                        className="h-7 text-xs font-mono"
                      />
                    </div>
                  </CardContent>
                </Card>

                <RadioPanel />
              </div>
            </div>
          </TabsContent>

          <TabsContent value="units" className="space-y-4 mt-4">
            <div className="grid gap-4 lg:grid-cols-3">
              <Card>
                <CardHeader>
                  <CardTitle>
                    Полиция (
                    {
                      units.filter((u) => u.type === "police" && u.onDuty)
                        .length
                    }
                    /{units.filter((u) => u.type === "police").length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[500px] pr-4">
                    <div className="space-y-2">
                      {units
                        .filter((u) => u.type === "police")
                        .map((unit) => (
                          <div
                            key={unit.id}
                            className={`flex items-center justify-between p-3 rounded-lg border ${unit.onDuty ? "bg-green-500/5 border-green-500/30" : "opacity-50"}`}
                          >
                            <div className="flex items-center gap-3">
                              <Shield className="h-5 w-5" />
                              <div>
                                <p className="font-bold text-primary">
                                  {unit.callsign}
                                </p>
                                <p className="text-sm font-medium">
                                  {unit.firstName} {unit.lastName}
                                </p>
                                <p className="text-xs text-muted-foreground">
                                  {unit.rank && (
                                    <span className="mr-1">{unit.rank}</span>
                                  )}
                                  {unit.department?.shortName && (
                                    <span className="text-blue-400">
                                      [{unit.department.shortName}]
                                    </span>
                                  )}
                                </p>
                              </div>
                            </div>
                            <div className="flex items-center gap-2 flex-col">
                              {unit.onDuty && (
                                <div className="flex gap-1">
                                  {[
                                    "available",
                                    "busy",
                                    "enroute",
                                    "on_scene",
                                  ].map((status) => (
                                    <Button
                                      key={status}
                                      size="sm"
                                      variant={
                                        unit.status === status
                                          ? "default"
                                          : "outline"
                                      }
                                      className="text-[10px] px-1 h-5"
                                      onClick={() =>
                                        handleUpdateUnitStatus(unit.id, status)
                                      }
                                    >
                                      {status === "available"
                                        ? "AVL"
                                        : status === "busy"
                                          ? "BUSY"
                                          : status === "enroute"
                                            ? "RTE"
                                            : "SCN"}
                                    </Button>
                                  ))}
                                </div>
                              )}
                              {!unit.onDuty && (
                                <span className="text-xs text-muted-foreground">
                                  OFF DUTY
                                </span>
                              )}
                            </div>
                          </div>
                        ))}
                    </div>
                  </ScrollArea>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>
                    EMS (
                    {units.filter((u) => u.type === "ems" && u.onDuty).length}/
                    {units.filter((u) => u.type === "ems").length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[500px] pr-4">
                    <div className="space-y-2">
                      {units
                        .filter((u) => u.type === "ems")
                        .map((unit) => (
                          <div
                            key={unit.id}
                            className={`flex items-center justify-between p-3 rounded-lg border ${unit.onDuty ? "bg-green-500/5 border-green-500/30" : "opacity-50"}`}
                          >
                            <div className="flex items-center gap-3">
                              <Stethoscope className="h-5 w-5 text-red-500" />
                              <div>
                                <p className="font-bold text-primary">
                                  {unit.callsign}
                                </p>
                                <p className="text-sm font-medium">
                                  {unit.firstName} {unit.lastName}
                                </p>
                                <p className="text-xs text-muted-foreground">
                                  {unit.rank && (
                                    <span className="mr-1">{unit.rank}</span>
                                  )}
                                  {unit.department?.shortName && (
                                    <span className="text-red-400">
                                      [{unit.department.shortName}]
                                    </span>
                                  )}
                                </p>
                              </div>
                            </div>
                            <div className="flex items-center gap-2 flex-col">
                              {unit.onDuty && (
                                <div className="flex gap-1">
                                  {[
                                    "available",
                                    "busy",
                                    "enroute",
                                    "on_scene",
                                  ].map((status) => (
                                    <Button
                                      key={status}
                                      size="sm"
                                      variant={
                                        unit.status === status
                                          ? "default"
                                          : "outline"
                                      }
                                      className="text-[10px] px-1 h-5"
                                      onClick={() =>
                                        handleUpdateUnitStatus(unit.id, status)
                                      }
                                    >
                                      {status === "available"
                                        ? "AVL"
                                        : status === "busy"
                                          ? "BUSY"
                                          : status === "enroute"
                                            ? "RTE"
                                            : "SCN"}
                                    </Button>
                                  ))}
                                </div>
                              )}
                              {!unit.onDuty && (
                                <span className="text-xs text-muted-foreground">
                                  OFF DUTY
                                </span>
                              )}
                            </div>
                          </div>
                        ))}
                    </div>
                  </ScrollArea>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>
                    Пожарные (
                    {units.filter((u) => u.type === "fire" && u.onDuty).length}/
                    {units.filter((u) => u.type === "fire").length})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[500px] pr-4">
                    <div className="space-y-2">
                      {units
                        .filter((u) => u.type === "fire")
                        .map((unit) => (
                          <div
                            key={unit.id}
                            className={`flex items-center justify-between p-3 rounded-lg border ${unit.onDuty ? "bg-green-500/5 border-green-500/30" : "opacity-50"}`}
                          >
                            <div className="flex items-center gap-3">
                              <Flame className="h-5 w-5 text-orange-500" />
                              <div>
                                <p className="font-bold text-primary">
                                  {unit.callsign}
                                </p>
                                <p className="text-sm font-medium">
                                  {unit.firstName} {unit.lastName}
                                </p>
                                <p className="text-xs text-muted-foreground">
                                  {unit.rank && (
                                    <span className="mr-1">{unit.rank}</span>
                                  )}
                                  {unit.department?.shortName && (
                                    <span className="text-orange-400">
                                      [{unit.department.shortName}]
                                    </span>
                                  )}
                                </p>
                              </div>
                            </div>
                            <div className="flex items-center gap-2 flex-col">
                              {unit.onDuty && (
                                <div className="flex gap-1">
                                  {[
                                    "available",
                                    "busy",
                                    "enroute",
                                    "on_scene",
                                  ].map((status) => (
                                    <Button
                                      key={status}
                                      size="sm"
                                      variant={
                                        unit.status === status
                                          ? "default"
                                          : "outline"
                                      }
                                      className="text-[10px] px-1 h-5"
                                      onClick={() =>
                                        handleUpdateUnitStatus(unit.id, status)
                                      }
                                    >
                                      {status === "available"
                                        ? "AVL"
                                        : status === "busy"
                                          ? "BUSY"
                                          : status === "enroute"
                                            ? "RTE"
                                            : "SCN"}
                                    </Button>
                                  ))}
                                </div>
                              )}
                              {!unit.onDuty && (
                                <span className="text-xs text-muted-foreground">
                                  OFF DUTY
                                </span>
                              )}
                            </div>
                          </div>
                        ))}
                    </div>
                  </ScrollArea>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="map" className="mt-4">
            <LiveMap height="calc(100vh - 300px)" />
          </TabsContent>

          <TabsContent value="civilians" className="space-y-4 mt-4">
            <Card>
              <CardHeader>
                <CardTitle>Поиск гражданских</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex gap-4 mb-4">
                  <div className="flex-1">
                    <div className="flex gap-2">
                      <Input
                        placeholder="Поиск..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                      />
                      <Select
                        value={searchBy}
                        onValueChange={(v) => setSearchBy(v as any)}
                      >
                        <SelectTrigger className="w-40">
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="name">По имени</SelectItem>
                          <SelectItem value="phone">По телефону</SelectItem>
                          <SelectItem value="address">По адресу</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>
                </div>

                <ScrollArea className="h-[500px] pr-4">
                  <div className="space-y-3">
                    {civilians.map((civilian) => (
                      <div
                        key={civilian.id}
                        className="p-4 rounded-lg border cursor-pointer hover:border-primary/50"
                        onClick={() => setSelectedCivilian(civilian)}
                      >
                        <div className="flex items-center justify-between">
                          <div>
                            <p className="font-bold">
                              {civilian.firstName} {civilian.lastName}
                            </p>
                            <p className="text-sm text-muted-foreground">
                              ID: {civilian.id}
                            </p>
                          </div>
                          <ChevronRight className="h-5 w-5 text-muted-foreground" />
                        </div>
                        {civilian.warrants && civilian.warrants.length > 0 && (
                          <Badge variant="destructive" className="mt-2">
                            Ордеры: {civilian.warrants.length}
                          </Badge>
                        )}
                      </div>
                    ))}
                    {civilians.length === 0 && searchTerm.length >= 2 && (
                      <p className="text-center text-muted-foreground py-8">
                        Гражданские не найдены
                      </p>
                    )}
                  </div>
                </ScrollArea>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="schedules" className="space-y-4 mt-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Calendar className="h-5 w-5" />
                  Графики смен
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ScrollArea className="h-[500px] pr-4">
                  <div className="grid gap-4">
                    {Array.from(new Set(schedules.map((s) => s.unitId))).map(
                      (unitId) => {
                        const unitSchedules = schedules.filter(
                          (s) => s.unitId === unitId,
                        );
                        const unit = units.find((u) => u.id === unitId);
                        return (
                          <div key={unitId} className="p-4 rounded-lg border">
                            <div className="flex items-center justify-between mb-3">
                              <div className="flex items-center gap-2">
                                <Shield className="h-5 w-5" />
                                <span className="font-bold">
                                  {unit?.callsign || unitId}
                                </span>
                                <span className="text-muted-foreground">
                                  - {unit?.name}
                                </span>
                              </div>
                            </div>
                            <div className="grid grid-cols-7 gap-2">
                              {[0, 1, 2, 3, 4, 5, 6].map((day) => {
                                const daySchedule = unitSchedules.filter(
                                  (s) => s.dayOfWeek === day,
                                );
                                return (
                                  <div
                                    key={day}
                                    className={`p-2 rounded text-center min-h-[60px] ${
                                      daySchedule.length > 0
                                        ? "bg-primary/10 border border-primary/30"
                                        : "bg-muted/30"
                                    }`}
                                  >
                                    <div className="text-[10px] text-muted-foreground mb-1">
                                      {getDayName(day).slice(0, 3)}
                                    </div>
                                    {daySchedule.map((schedule, idx) => (
                                      <div
                                        key={idx}
                                        className={`text-[10px] px-1 py-0.5 rounded text-white mb-0.5 ${getShiftTypeColor(schedule.shiftType)}`}
                                      >
                                        {schedule.startTime}-{schedule.endTime}
                                      </div>
                                    ))}
                                  </div>
                                );
                              })}
                            </div>
                          </div>
                        );
                      },
                    )}
                    {schedules.length === 0 && (
                      <p className="text-center text-muted-foreground py-8">
                        Нет запланированных смен
                      </p>
                    )}
                  </div>
                </ScrollArea>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="stats" className="space-y-4 mt-4">
            <div className="grid gap-4 md:grid-cols-4">
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm font-mono">
                    TOTAL CALLS
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold font-mono">
                    {calls.length}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    +{activity?.totalCalls || 0} за 24ч
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm font-mono">
                    AVG RESPONSE
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold font-mono">
                    {formatResponseTime(activity?.avgResponseTime || 0)}
                  </div>
                  <p className="text-xs text-muted-foreground">среднее время</p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm font-mono">
                    UNITS ON DUTY
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold font-mono">
                    {stats?.units.onDuty || 0}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    {stats?.units.available || 0} available
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm font-mono">COMPLETED</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold font-mono">
                    {stats?.calls.completed || 0}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    {Math.round(
                      ((stats?.calls.completed || 0) /
                        Math.max(calls.length, 1)) *
                        100,
                    )}
                    % от общего
                  </p>
                </CardContent>
              </Card>
            </div>

            <div className="grid gap-4 lg:grid-cols-3">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-sm font-mono">
                    <AlertTriangle className="h-4 w-4" />
                    BY TYPE
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    {[
                      "911",
                      "traffic",
                      "crime",
                      "medical",
                      "fire",
                      "other",
                    ].map((type) => {
                      const count = calls.filter((c) => c.type === type).length;
                      const total = calls.length || 1;
                      return (
                        <div
                          key={type}
                          className="flex items-center justify-between"
                        >
                          <div className="flex items-center gap-2">
                            {type === "911" && (
                              <AlertTriangle className="h-3 w-3 text-red-500" />
                            )}
                            {type === "traffic" && (
                              <Car className="h-3 w-3 text-yellow-500" />
                            )}
                            {type === "crime" && (
                              <Shield className="h-3 w-3 text-purple-500" />
                            )}
                            {type === "medical" && (
                              <Stethoscope className="h-3 w-3 text-red-400" />
                            )}
                            {type === "fire" && (
                              <Flame className="h-3 w-3 text-orange-500" />
                            )}
                            {type === "other" && (
                              <Siren className="h-3 w-3 text-muted-foreground" />
                            )}
                            <span className="text-xs font-mono uppercase">
                              {type}
                            </span>
                          </div>
                          <div className="flex items-center gap-2">
                            <div className="w-20 h-2 bg-muted rounded-full overflow-hidden">
                              <div
                                className="h-full bg-primary"
                                style={{ width: `${(count / total) * 100}%` }}
                              />
                            </div>
                            <span className="text-xs font-mono w-8 text-right">
                              {count}
                            </span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-sm font-mono">
                    <Target className="h-4 w-4" />
                    BY PRIORITY
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    {["critical", "high", "medium", "low"].map((priority) => {
                      const count = calls.filter(
                        (c) => c.priority === priority,
                      ).length;
                      const total = calls.length || 1;
                      const colors: Record<string, string> = {
                        critical: "bg-red-500",
                        high: "bg-orange-500",
                        medium: "bg-yellow-500",
                        low: "bg-blue-500",
                      };
                      return (
                        <div
                          key={priority}
                          className="flex items-center justify-between"
                        >
                          <span className="text-xs font-mono uppercase">
                            {priority}
                          </span>
                          <div className="flex items-center gap-2">
                            <div className="w-20 h-2 bg-muted rounded-full overflow-hidden">
                              <div
                                className={`h-full ${colors[priority]}`}
                                style={{ width: `${(count / total) * 100}%` }}
                              />
                            </div>
                            <span className="text-xs font-mono w-8 text-right">
                              {count}
                            </span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-sm font-mono">
                    <Activity className="h-4 w-4" />
                    BY STATUS
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    {[
                      "pending",
                      "dispatched",
                      "enroute",
                      "on_scene",
                      "completed",
                      "cancelled",
                    ].map((status) => {
                      const count = calls.filter(
                        (c) => c.status === status,
                      ).length;
                      const total = calls.length || 1;
                      const colors: Record<string, string> = {
                        pending: "bg-yellow-500",
                        dispatched: "bg-blue-500",
                        enroute: "bg-purple-500",
                        on_scene: "bg-green-500",
                        completed: "bg-gray-500",
                        cancelled: "bg-red-500",
                      };
                      return (
                        <div
                          key={status}
                          className="flex items-center justify-between"
                        >
                          <span className="text-xs font-mono uppercase">
                            {status.replace("_", " ")}
                          </span>
                          <div className="flex items-center gap-2">
                            <div className="w-20 h-2 bg-muted rounded-full overflow-hidden">
                              <div
                                className={`h-full ${colors[status]}`}
                                style={{ width: `${(count / total) * 100}%` }}
                              />
                            </div>
                            <span className="text-xs font-mono w-8 text-right">
                              {count}
                            </span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </CardContent>
              </Card>
            </div>

            <div className="grid gap-4 lg:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-sm font-mono">
                    <TrendingUp className="h-4 w-4" />
                    RESPONSE TIME BY HOUR
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  {responseTimes && responseTimes.length > 0 ? (
                    <div className="space-y-2">
                      <div className="flex items-end gap-[2px] h-48">
                        {Array.from({ length: 24 }, (_, hour) => {
                          const hourData = responseTimes.find(
                            (rt) => rt.hour === hour,
                          );
                          const avgTime = hourData?.avgTime || 0;
                          const maxTime = Math.max(
                            ...responseTimes.map((rt) => rt.avgTime),
                            1,
                          );
                          const color =
                            avgTime > 400
                              ? "bg-red-500"
                              : avgTime > 300
                                ? "bg-yellow-500"
                                : avgTime > 0
                                  ? "bg-green-500"
                                  : "bg-muted";
                          return (
                            <div
                              key={hour}
                              className="flex-1 flex flex-col items-center"
                            >
                              <span className="text-[8px] font-mono text-muted-foreground mb-1">
                                {avgTime > 0
                                  ? formatResponseTime(avgTime)
                                  : "-"}
                              </span>
                              <div
                                className={`w-full rounded-sm ${color}`}
                                style={{
                                  height: `${Math.max(4, (avgTime / maxTime) * 100)}%`,
                                }}
                                title={`${hour}:00 - ${formatResponseTime(avgTime)}`}
                              />
                            </div>
                          );
                        })}
                      </div>
                      <div className="flex justify-between text-[10px] text-muted-foreground font-mono">
                        {Array.from({ length: 8 }, (_, i) => (
                          <span key={i}>
                            {String(i * 3).padStart(2, "0")}:00
                          </span>
                        ))}
                      </div>
                    </div>
                  ) : (
                    <div className="h-48 flex items-center justify-center text-muted-foreground text-sm font-mono">
                      NO DATA
                    </div>
                  )}
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-sm font-mono">
                    <Activity className="h-4 w-4" />
                    CALLS BY HOUR (24H)
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  {activity?.callsByHour && activity.callsByHour.length > 0 ? (
                    <div className="space-y-2">
                      <div className="flex items-end gap-[2px] h-48">
                        {Array.from({ length: 24 }, (_, hour) => {
                          const hourData = activity.callsByHour.find(
                            (c) => c.hour === hour,
                          );
                          const count = hourData?.count || 0;
                          const maxCount = Math.max(
                            ...activity.callsByHour.map((c) => c.count),
                            1,
                          );
                          return (
                            <div
                              key={hour}
                              className="flex-1 flex flex-col items-center"
                            >
                              <span className="text-[8px] font-mono text-muted-foreground mb-1">
                                {count}
                              </span>
                              <div
                                className={`w-full rounded-sm ${count > 0 ? "bg-primary" : "bg-muted"}`}
                                style={{
                                  height: `${Math.max(4, (count / maxCount) * 100)}%`,
                                }}
                                title={`${hour}:00 - ${count} calls`}
                              />
                            </div>
                          );
                        })}
                      </div>
                      <div className="flex justify-between text-[10px] text-muted-foreground font-mono">
                        {Array.from({ length: 8 }, (_, i) => (
                          <span key={i}>
                            {String(i * 3).padStart(2, "0")}:00
                          </span>
                        ))}
                      </div>
                    </div>
                  ) : (
                    <div className="h-48 flex items-center justify-center text-muted-foreground text-sm font-mono">
                      NO DATA
                    </div>
                  )}
                </CardContent>
              </Card>
            </div>

            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-sm font-mono">
                  <Users className="h-4 w-4" />
                  UNITS STATUS
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid gap-4 md:grid-cols-3">
                  {["police", "ems", "fire"].map((type) => {
                    const typeUnits = units.filter((u) => u.type === type);
                    const onDuty = typeUnits.filter((u) => u.onDuty).length;
                    const available = typeUnits.filter(
                      (u) => u.onDuty && u.status === "available",
                    ).length;
                    const busy = typeUnits.filter(
                      (u) => u.onDuty && u.status !== "available",
                    ).length;
                    return (
                      <div key={type} className="p-3 rounded-lg border">
                        <div className="flex items-center gap-2 mb-2">
                          {type === "police" && (
                            <Shield className="h-4 w-4 text-blue-500" />
                          )}
                          {type === "ems" && (
                            <Stethoscope className="h-4 w-4 text-red-500" />
                          )}
                          {type === "fire" && (
                            <Flame className="h-4 w-4 text-orange-500" />
                          )}
                          <span className="font-mono uppercase text-sm">
                            {type}
                          </span>
                        </div>
                        <div className="grid grid-cols-3 gap-2 text-center text-xs font-mono">
                          <div>
                            <div className="text-green-500 font-bold">
                              {available}
                            </div>
                            <div className="text-muted-foreground">AVL</div>
                          </div>
                          <div>
                            <div className="text-yellow-500 font-bold">
                              {busy}
                            </div>
                            <div className="text-muted-foreground">BUSY</div>
                          </div>
                          <div>
                            <div className="text-muted-foreground font-bold">
                              {onDuty}/{typeUnits.length}
                            </div>
                            <div className="text-muted-foreground">DUTY</div>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>

      <Dialog open={showNewCallDialog} onOpenChange={setShowNewCallDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Создать новый вызов</DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>Тип</Label>
                <Select
                  value={newCall.type}
                  onValueChange={(v) => setNewCall({ ...newCall, type: v })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="911">911</SelectItem>
                    <SelectItem value="traffic">ДТП</SelectItem>
                    <SelectItem value="crime">Преступление</SelectItem>
                    <SelectItem value="medical">Медицинский</SelectItem>
                    <SelectItem value="fire">Пожар</SelectItem>
                    <SelectItem value="other">Другое</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label>Приоритет</Label>
                <Select
                  value={newCall.priority}
                  onValueChange={(v) => setNewCall({ ...newCall, priority: v })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="low">Низкий</SelectItem>
                    <SelectItem value="medium">Средний</SelectItem>
                    <SelectItem value="high">Высокий</SelectItem>
                    <SelectItem value="critical">Критический</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div>
              <Label>Адрес</Label>
              <Input
                value={newCall.location}
                onChange={(e) =>
                  setNewCall({ ...newCall, location: e.target.value })
                }
                placeholder="Введите адрес..."
              />
            </div>
            <div>
              <Label>Описание</Label>
              <Textarea
                value={newCall.description}
                onChange={(e) =>
                  setNewCall({ ...newCall, description: e.target.value })
                }
                placeholder="Опишите ситуацию..."
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>Имя заявителя</Label>
                <Input
                  value={newCall.callerName}
                  onChange={(e) =>
                    setNewCall({ ...newCall, callerName: e.target.value })
                  }
                  placeholder="Имя..."
                />
              </div>
              <div>
                <Label>Телефон</Label>
                <Input
                  value={newCall.callerPhone}
                  onChange={(e) =>
                    setNewCall({ ...newCall, callerPhone: e.target.value })
                  }
                  placeholder="+1 555-..."
                />
              </div>
            </div>
          </div>
          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setShowNewCallDialog(false)}
            >
              Отмена
            </Button>
            <Button onClick={handleCreateCall}>Создать вызов</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <CivilianModal
        open={!!selectedCivilian}
        onOpenChange={() => setSelectedCivilian(null)}
        civilian={selectedCivilian}
        mode="view"
      />
    </div>
  );
}
