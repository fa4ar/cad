"use client";

import { useEffect, useState } from "react";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CivilianModal } from "@/components/CivilianModal";
import { useSocket } from "@/hooks/useSocket";
import { useLanguage } from "@/hooks/useLanguage";
import { toast } from "sonner";
import api from "@/lib/api/axios";
import { Power, LogOut, Wifi, WifiOff, AlertTriangle } from "lucide-react";

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
  type: "police" | "ems" | "fire" | "civilian" | "other";
  status: "available" | "busy" | "enroute" | "on_scene" | "off_duty";
  department?: string;
  currentCallId?: string;
  onDuty: boolean;
}

interface Officer {
  id: string;
  badgeNumber?: string;
  officerRank?: string;
  callsign?: string;
  department: { name: string };
  character: { id: string; firstName: string; lastName: string };
}

const priorityMap: Record<string, string> = {
  critical: "P1-CRIT",
  high: "P2-URG",
  medium: "P3-RPT",
  low: "P4-RPT",
};

const priorityColors: Record<string, string> = {
  critical: "border-red-500 text-red-500 bg-red-500/10",
  high: "border-orange-500 text-orange-500 bg-orange-500/10",
  medium: "border-yellow-500 text-yellow-500 bg-yellow-500/10",
  low: "border-blue-500 text-blue-500 bg-blue-500/10",
};

const statusMap: Record<string, string> = {
  pending: "QUEUED",
  dispatched: "DISPATCHED",
  enroute: "EN ROUTE",
  on_scene: "ON SCENE",
  completed: "CLEARED",
  cancelled: "CANCELLED",
};

const statusColors: Record<string, string> = {
  pending: "text-yellow-500",
  dispatched: "text-red-500",
  enroute: "text-blue-500",
  on_scene: "text-orange-500",
  completed: "text-gray-500",
  cancelled: "text-gray-500",
};

const unitStatusColors: Record<string, string> = {
  available: "bg-green-500",
  busy: "bg-red-500",
  enroute: "bg-yellow-500",
  on_scene: "bg-blue-500",
  off_duty: "bg-gray-500",
};

export default function FirePage() {
  const { t } = useLanguage();
  const [currentTime, setCurrentTime] = useState("");
  const [isOnDuty, setIsOnDuty] = useState(false);
  const [myStatus, setMyStatus] = useState("off_duty");
  const [myUnit, setMyUnit] = useState<Unit | null>(null);
  const [myCallsign, setMyCallsign] = useState("");
  const [myOfficerId, setMyOfficerId] = useState<string | null>(null);
  const [officers, setOfficers] = useState<Officer[]>([]);
  const [calls, setCalls] = useState<Call[]>([]);
  const [units, setUnits] = useState<Unit[]>([]);
  const [myCall, setMyCall] = useState<Call | null>(null);
  const [selectedCall, setSelectedCall] = useState<Call | null>(null);
  const [callLogs, setCallLogs] = useState<CallLog[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const [showCallModal, setShowCallModal] = useState(false);
  const [isRadioOn, setIsRadioOn] = useState(true);
  const [showCallsignDialog, setShowCallsignDialog] = useState(false);
  const [tempCallsign, setTempCallsign] = useState("");
  const [tempOfficerId, setTempOfficerId] = useState("");
  const { isConnected, on, off, emit } = useSocket();
  const [searchQuery, setSearchQuery] = useState({
    firstName: "",
    lastName: "",
    dobDay: "",
    dobMonth: "",
    dobYear: "",
  });
  const [searchResults2, setSearchResults2] = useState<any[]>([]);
  const [isSearching, setIsSearching] = useState(false);
  const [selectedResult, setSelectedResult] = useState<any>(null);
  const [showSearchModal, setShowSearchModal] = useState(false);

  useEffect(() => {
    const updateTime = () => {
      const now = new Date();
      const hours = String(now.getHours()).padStart(2, "0");
      const minutes = String(now.getMinutes()).padStart(2, "0");
      const seconds = String(now.getSeconds()).padStart(2, "0");
      setCurrentTime(`${hours}:${minutes}:${seconds}`);
    };
    updateTime();
    const interval = setInterval(updateTime, 1000);
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    const fetchDutyStatus = async () => {
      try {
        const [dutyRes, officersRes] = await Promise.all([
          api.get("/auth/duty"),
          api.get("/auth/officers"),
        ]);
        setOfficers(officersRes.data);

        if (dutyRes.data && dutyRes.data.type === "fire") {
          setMyCallsign(dutyRes.data.callsign);
          setMyOfficerId(dutyRes.data.officerId);
          setIsOnDuty(true);
          setMyStatus(dutyRes.data.status);
          fetchData();
        }
      } catch (error) {
        console.error("Error fetching duty status:", error);
      }
    };
    fetchDutyStatus();
  }, []);

  const fetchData = async () => {
    try {
      const [callsRes, unitsRes] = await Promise.all([
        api.get("/character/emergency-calls?status=all"),
        api.get("/dispatch/units?type=fire"),
      ]);

      const allCalls = callsRes.data.calls || callsRes.data;
      const filteredCalls = allCalls.filter(
        (c: Call) =>
          c.type === "fire" || c.type === "medical" || c.type === "911",
      );
      setCalls(filteredCalls);
      setUnits(unitsRes.data);

      if (myCallsign) {
        const myUnitData = unitsRes.data.find(
          (u: Unit) => u.callsign === myCallsign,
        );
        if (myUnitData) {
          setMyUnit(myUnitData);
        }
      }
    } catch (error) {
      console.error("Error fetching fire data:", error);
    }
  };

  useEffect(() => {
    if (!isConnected) return;

    if (myUnit?.id) {
      emit("join-fire", myUnit.id);
    }

    on("new-call", (newCall: Call) => {
      if (
        newCall.type === "fire" ||
        newCall.type === "medical" ||
        newCall.type === "911"
      ) {
        setCalls((prev) => [newCall, ...prev]);
      }
    });

    on("call-created", (newCall: Call) => {
      if (
        newCall.type === "fire" ||
        newCall.type === "medical" ||
        newCall.type === "911"
      ) {
        setCalls((prev) => [newCall, ...prev]);
      }
    });

    on("call-updated", (updatedCall: Call) => {
      if (
        updatedCall.type === "fire" ||
        updatedCall.type === "medical" ||
        updatedCall.type === "911"
      ) {
        setCalls((prev) =>
          prev.map((c) => (c.id === updatedCall.id ? updatedCall : c)),
        );
        if (myCall?.id === updatedCall.id) {
          setMyCall(updatedCall);
        }
      }
    });

    on(
      "assigned-call",
      (data: { callId: string; unitId: string; call: Call }) => {
        if (myUnit && data.unitId === myUnit.id) {
          setMyCall(data.call);
          toast.success(`ASSIGNED: ${data.call.type.toUpperCase()}`);
        }
      },
    );

    on("call-log-added", (data: { callId: string; log: CallLog }) => {
      if (selectedCall?.id === data.callId && data.log.logType === "user") {
        setCallLogs((prev) => [...prev, data.log]);
      }
      fetchData();
    });

    on("call-note-added", (data: { callId: string; log: CallLog }) => {
      if (selectedCall?.id === data.callId && data.log.logType === "user") {
        setCallLogs((prev) => [...prev, data.log]);
      }
      fetchData();
    });

    return () => {
      if (myUnit?.id) {
        emit("leave-fire", myUnit.id);
      }
      off("new-call");
      off("call-created");
      off("call-updated");
      off("assigned-call");
      off("call-log-added");
      off("call-note-added");
    };
  }, [
    isConnected,
    on,
    off,
    emit,
    isOnDuty,
    isRadioOn,
    myCall,
    myUnit,
    selectedCall,
  ]);

  const handleStartShiftClick = () => {
    setTempCallsign("");
    setTempOfficerId("");
    setShowCallsignDialog(true);
  };

  const handleOfficerSelect = (officerId: string) => {
    setTempOfficerId(officerId);
    const selectedOfficer = officers.find((o) => o.id === officerId);
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
      toast.warning("Выберите офицера");
      return;
    }
    try {
      const response = await api.post("/auth/duty/start", {
        officerId: tempOfficerId,
        type: "fire",
      });
      setMyCallsign(response.data.callsign);
      setMyOfficerId(tempOfficerId);
      setIsOnDuty(true);
      setMyStatus("available");
      await fetchData();
      setShowCallsignDialog(false);
      setTempCallsign("");
      setTempOfficerId("");
      toast.success(`Смена начата. Позывной: ${response.data.callsign}`);
    } catch (error: any) {
      if (error.response?.data?.error) {
        toast.error(error.response.data.error);
      } else {
        toast.error("Ошибка начала смены");
      }
    }
  };

  const handleEndShift = async () => {
    try {
      await api.post("/auth/duty/end");
      setIsOnDuty(false);
      setMyStatus("off_duty");
      setMyCall(null);
      setMyUnit(null);
      setMyCallsign("");
      fetchData();
      toast.success("Смена завершена");
    } catch (error) {
      toast.error("Ошибка завершения смены");
    }
  };

  const handleStatusChange = async (newStatus: string) => {
    if (!isOnDuty) return;

    try {
      await api.put("/auth/duty/status", { status: newStatus });
      setMyStatus(newStatus);
      if (myUnit) {
        setMyUnit({ ...myUnit, status: newStatus as any });
      }
      fetchData();
      toast.success(`Status: ${newStatus.toUpperCase()}`);
    } catch (error) {
      toast.error("Failed to update status");
    }
  };

  const handleAcceptCall = async (callId: string) => {
    try {
      if (myUnit) {
        await api.post(`/dispatch/calls/${callId}/assign`, {
          unitIds: [myUnit.id],
        });
      }
      fetchData();
      toast.success("Call accepted");
    } catch (error) {
      toast.error("Error accepting call");
    }
  };

  const handleCompleteCall = async () => {
    if (!myCall) return;

    try {
      await api.put(`/dispatch/calls/${myCall.id}`, { status: "completed" });
      if (myUnit) {
        await api.put(`/dispatch/units/${myUnit.id}`, {
          status: "available",
          currentCallId: null,
        });
      }
      setMyCall(null);
      setMyStatus("available");
      fetchData();
      toast.success("Call completed");
    } catch (error) {
      toast.error("Error completing call");
    }
  };

  const fetchCallLogs = async (callId: string) => {
    try {
      const res = await api.get(`/call-logs/${callId}?logType=user`);
      setCallLogs(res.data.logs || []);
    } catch (error) {
      console.error("Error fetching call logs:", error);
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
        authorCallsign: myCallsign,
      });
      setNewMessage("");
      fetchCallLogs(selectedCall.id);
    } catch (error) {
      toast.error("Ошибка отправки");
    }
  };

  const handleSelfAssign = async () => {
    if (!selectedCall || !myUnit) return;

    try {
      const updatedUnits = [...(selectedCall.assignedUnits || []), myUnit.id];
      await api.put(`/character/emergency-calls/${selectedCall.id}`, {
        assignedUnits: updatedUnits,
      });
      fetchCallLogs(selectedCall.id);
      fetchData();
      toast.success("Вы назначены на вызов");
    } catch (error) {
      toast.error("Ошибка назначения");
    }
  };

  const handleSelfUnassign = async () => {
    if (!selectedCall || !myUnit) return;

    try {
      const updatedUnits = (selectedCall.assignedUnits || []).filter(
        (id) => id !== myUnit.id,
      );
      await api.put(`/character/emergency-calls/${selectedCall.id}`, {
        assignedUnits: updatedUnits,
      });
      fetchCallLogs(selectedCall.id);
      fetchData();
      toast.success("Вы сняты с вызова");
    } catch (error) {
      toast.error("Ошибка");
    }
  };

  const formatTime = (dateStr: string) => {
    const date = new Date(dateStr);
    const hours = String(date.getHours()).padStart(2, "0");
    const minutes = String(date.getMinutes()).padStart(2, "0");
    return `${hours}:${minutes}`;
  };

  const handleSearch = async () => {
    setIsSearching(true);
    setSearchResults2([]);
    setShowSearchModal(false);
    setSelectedResult(null);

    const hasSearchField = () => {
      return (
        searchQuery.firstName ||
        searchQuery.lastName ||
        (searchQuery.dobDay && searchQuery.dobMonth && searchQuery.dobYear)
      );
    };

    if (!hasSearchField()) {
      toast.error("Заполните хотя бы одно поле для поиска");
      setIsSearching(false);
      return;
    }

    try {
      const params = new URLSearchParams();

      if (searchQuery.firstName)
        params.append("firstName", searchQuery.firstName);
      if (searchQuery.lastName) params.append("lastName", searchQuery.lastName);
      if (searchQuery.dobDay && searchQuery.dobMonth && searchQuery.dobYear) {
        params.append("dobDay", searchQuery.dobDay);
        params.append("dobMonth", searchQuery.dobMonth);
        params.append("dobYear", searchQuery.dobYear);
      }

      const res = await api.get(`/leo/search/citizens?${params.toString()}`);
      const results = res.data.citizens || [];
      setSearchResults2(results);

      if (results.length === 1) {
        const res = await api.get(`/leo/search/citizens/${results[0].id}`);
        setSelectedResult(res.data.citizen || res.data);
        setShowSearchModal(true);
      } else if (results.length === 0) {
        toast.info("Персонажи не найдены");
      }
    } catch (error) {
      console.error("Search error:", error);
      toast.error("Ошибка поиска");
    } finally {
      setIsSearching(false);
    }
  };

  const handleViewDetails = async (result: any) => {
    try {
      const res = await api.get(`/leo/search/citizens/${result.id}`);
      setSelectedResult(res.data.citizen || res.data);
      setShowSearchModal(true);
    } catch (error) {
      console.error("Error fetching details:", error);
      toast.error("Ошибка загрузки данных");
    }
  };

  const activeCalls = calls.filter(
    (c) =>
      c.status !== "completed" &&
      c.status !== "cancelled" &&
      (c.type === "fire" || c.type === "medical" || c.type === "911"),
  );
  const fireUnits = units.filter((u) => u.onDuty);
  const availableUnits = fireUnits.filter(
    (u) => u.status === "available",
  ).length;

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="bg-card border-b">
        <div className="container mx-auto px-4 py-1 flex items-center justify-between text-xs font-mono">
          <div className="flex items-center gap-4">
            <span className="text-muted-foreground">// FIRE DEPARTMENT</span>
            <Badge
              variant={isConnected ? "default" : "destructive"}
              className="gap-1"
            >
              {isConnected ? (
                <Wifi className="h-3 w-3" />
              ) : (
                <WifiOff className="h-3 w-3" />
              )}
              {isConnected ? "ONLINE" : "OFFLINE"}
            </Badge>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-primary">{currentTime}</span>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-4">
        {/* Top Cards */}
        <div className="grid gap-4 lg:grid-cols-3 mb-4">
          {/* Status Control Card */}
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-3">
                // STATUS CONTROL
              </div>
              <div className="space-y-2 mb-4">
                <div className="flex gap-2 text-xs font-mono">
                  <span className="text-muted-foreground">UNIT:</span>
                  <span>{myCallsign || "N/A"}</span>
                </div>
                <div className="flex gap-2 text-xs font-mono">
                  <span className="text-muted-foreground">SHIFT:</span>
                  <span
                    className={
                      isOnDuty ? "text-green-500" : "text-muted-foreground"
                    }
                  >
                    {isOnDuty ? "ON DUTY" : "OFF DUTY"}
                  </span>
                </div>
                {myCall && (
                  <div className="flex gap-2 text-xs font-mono mt-2 p-2 bg-orange-500/10 border border-orange-500/30 rounded">
                    <span className="text-orange-500">CURRENT CALL:</span>
                    <span className="text-orange-400 truncate">
                      {myCall.description}
                    </span>
                  </div>
                )}
              </div>

              {!isOnDuty ? (
                <Button
                  className="w-full font-mono text-xs bg-red-600 hover:bg-red-700"
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
                      variant={myStatus === "available" ? "default" : "outline"}
                      className="text-xs font-mono bg-green-600 hover:bg-green-700 flex-1"
                      onClick={() => handleStatusChange("available")}
                    >
                      AVAILABLE
                    </Button>
                    <Button
                      size="sm"
                      variant={myStatus === "busy" ? "default" : "outline"}
                      className="text-xs font-mono flex-1"
                      onClick={() => handleStatusChange("busy")}
                    >
                      BUSY
                    </Button>
                  </div>
                  <div className="flex gap-2 flex-wrap">
                    <Button
                      size="sm"
                      variant={myStatus === "enroute" ? "default" : "outline"}
                      className="text-xs font-mono bg-yellow-600 hover:bg-yellow-700 flex-1"
                      onClick={() => handleStatusChange("enroute")}
                    >
                      EN ROUTE
                    </Button>
                    <Button
                      size="sm"
                      variant={myStatus === "on_scene" ? "default" : "outline"}
                      className="text-xs font-mono bg-blue-600 hover:bg-blue-700 flex-1"
                      onClick={() => handleStatusChange("on_scene")}
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

          {/* Search Card */}
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-2">
                // SEARCH
              </div>
              <div className="space-y-2">
                <div className="space-y-1">
                  <Input
                    placeholder="First Name"
                    value={searchQuery.firstName}
                    onChange={(e) =>
                      setSearchQuery({
                        ...searchQuery,
                        firstName: e.target.value,
                      })
                    }
                    className="font-mono text-xs"
                  />
                  <Input
                    placeholder="Last Name"
                    value={searchQuery.lastName}
                    onChange={(e) =>
                      setSearchQuery({
                        ...searchQuery,
                        lastName: e.target.value,
                      })
                    }
                    className="font-mono text-xs"
                  />
                  <div className="grid grid-cols-3 gap-1">
                    <Input
                      placeholder="DD"
                      value={searchQuery.dobDay}
                      onChange={(e) =>
                        setSearchQuery({
                          ...searchQuery,
                          dobDay: e.target.value,
                        })
                      }
                      className="font-mono text-xs"
                      maxLength={2}
                    />
                    <Input
                      placeholder="MM"
                      value={searchQuery.dobMonth}
                      onChange={(e) =>
                        setSearchQuery({
                          ...searchQuery,
                          dobMonth: e.target.value,
                        })
                      }
                      className="font-mono text-xs"
                      maxLength={2}
                    />
                    <Input
                      placeholder="YYYY"
                      value={searchQuery.dobYear}
                      onChange={(e) =>
                        setSearchQuery({
                          ...searchQuery,
                          dobYear: e.target.value,
                        })
                      }
                      className="font-mono text-xs"
                      maxLength={4}
                    />
                  </div>
                </div>

                <Button
                  onClick={handleSearch}
                  disabled={isSearching}
                  className="w-full font-mono text-xs"
                  size="sm"
                >
                  {isSearching ? "SEARCHING..." : "SEARCH"}
                </Button>

                {searchResults2.length > 0 && (
                  <ScrollArea className="h-[200px] mt-2">
                    <div className="space-y-1">
                      {searchResults2.slice(0, 10).map((result, idx) => (
                        <div
                          key={idx}
                          className="p-2 border rounded text-xs cursor-pointer hover:bg-accent"
                          onClick={() => handleViewDetails(result)}
                        >
                          <div className="flex justify-between items-center">
                            <span className="font-bold">
                              {result.firstName} {result.lastName}
                            </span>
                            <div className="flex gap-1">
                              {result.isDead && (
                                <Badge className="bg-gray-500 text-[10px]">
                                  D
                                </Badge>
                              )}
                              {result.isMissing && (
                                <Badge className="bg-yellow-500 text-[10px]">
                                  M
                                </Badge>
                              )}
                              {result.isWanted && (
                                <Badge className="bg-red-500 text-[10px]">
                                  W
                                </Badge>
                              )}
                              {result.isArrested && (
                                <Badge className="bg-orange-500 text-[10px]">
                                  A
                                </Badge>
                              )}
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </ScrollArea>
                )}
              </div>
            </CardContent>
          </Card>

          {/* Active Calls Card */}
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="text-xs uppercase tracking-wide text-muted-foreground font-mono mb-3">
                // ACTIVE CALLS
              </div>
              <div className="space-y-2 text-xs font-mono">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">FIRE</span>
                  <span className="text-red-500">
                    {activeCalls.filter((c) => c.type === "fire").length}
                  </span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">MEDICAL</span>
                  <span className="text-blue-500">
                    {activeCalls.filter((c) => c.type === "medical").length}
                  </span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">911</span>
                  <span className="text-yellow-500">
                    {activeCalls.filter((c) => c.type === "911").length}
                  </span>
                </div>
                <div className="flex justify-between border-t pt-2 mt-2">
                  <span className="text-muted-foreground">TOTAL</span>
                  <span>{activeCalls.length}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Bottom Grid */}
        <div className="grid gap-4 lg:grid-cols-3">
          {/* Incidents Table */}
          <div className="lg:col-span-2">
            <Card className="bg-card border-border">
              <CardHeader className="py-3 px-4 border-b">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-red-500 animate-pulse" />
                    <span className="text-sm font-bold uppercase tracking-wide">
                      Active Incidents
                    </span>
                  </div>
                  <span className="text-xs font-mono text-red-500">
                    LIVE FEED_
                  </span>
                </div>
              </CardHeader>
              <CardContent className="p-0">
                <ScrollArea className="h-[350px]">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b">
                        <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">
                          Priority
                        </th>
                        <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">
                          Time
                        </th>
                        <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">
                          Type
                        </th>
                        <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">
                          Location
                        </th>
                        <th className="text-left p-3 text-xs font-mono text-muted-foreground uppercase">
                          Status
                        </th>
                      </tr>
                    </thead>
                    <tbody className="font-mono text-xs">
                      {activeCalls.map((call) => (
                        <tr
                          key={call.id}
                          className="border-b hover:bg-muted/50 cursor-pointer"
                          onClick={() => handleOpenCallModal(call)}
                        >
                          <td className="p-3">
                            <span
                              className={`inline-block px-2 py-1 text-[10px] font-bold border ${priorityColors[call.priority]}`}
                            >
                              {priorityMap[call.priority]}
                            </span>
                          </td>
                          <td className="p-3">{formatTime(call.createdAt)}</td>
                          <td className="p-3">{call.type.toUpperCase()}</td>
                          <td className="p-3 max-w-[150px] truncate">
                            {call.location}
                          </td>
                          <td className={`p-3 ${statusColors[call.status]}`}>
                            {statusMap[call.status]}
                          </td>
                        </tr>
                      ))}
                      {activeCalls.length === 0 && (
                        <tr>
                          <td
                            colSpan={5}
                            className="p-8 text-center text-muted-foreground"
                          >
                            NO ACTIVE INCIDENTS
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </ScrollArea>
              </CardContent>
            </Card>

            {/* My Call Card */}
            {myCall && (
              <Card className="bg-card border-orange-500 mt-4">
                <CardHeader className="py-3 px-4 border-b bg-orange-500/10">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-bold uppercase tracking-wide text-orange-500">
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
                      <span className="ml-2">
                        {priorityMap[myCall.priority]}
                      </span>
                    </div>
                    <div className="col-span-2">
                      <span className="text-muted-foreground">LOCATION:</span>
                      <span className="ml-2">{myCall.location}</span>
                    </div>
                    <div className="col-span-2">
                      <span className="text-muted-foreground">
                        DESCRIPTION:
                      </span>
                      <span className="ml-2">{myCall.description}</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            )}
          </div>

          {/* Right Sidebar */}
          <div className="space-y-4">
            {/* Unit Status Card */}
            <Card className="bg-card border-border">
              <CardHeader className="py-3 px-4 border-b">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-green-500" />
                    <span className="text-sm font-bold uppercase tracking-wide">
                      Unit Status
                    </span>
                  </div>
                  <span className="text-xs font-mono text-muted-foreground">
                    {availableUnits}/{fireUnits.length} AVAIL
                  </span>
                </div>
              </CardHeader>
              <CardContent className="p-2">
                <div className="grid grid-cols-2 gap-2">
                  {fireUnits.map((unit) => (
                    <div
                      key={unit.id}
                      className={`p-3 rounded border ${
                        unit.status === "available"
                          ? "border-green-500/50 bg-green-500/5"
                          : unit.status === "enroute"
                            ? "border-yellow-500/50 bg-yellow-500/5"
                            : myUnit && unit.id === myUnit.id
                              ? "border-primary bg-primary/10"
                              : "border-border bg-muted/30"
                      }`}
                    >
                      <div className="flex items-center justify-between mb-1">
                        <span className="font-mono text-xs font-bold">
                          {unit.callsign}
                          {myUnit && unit.id === myUnit.id && " *"}
                        </span>
                        <div
                          className={`w-2 h-2 rounded-full ${unitStatusColors[unit.status]}`}
                        />
                      </div>
                      <div
                        className={`text-[10px] font-mono ${
                          unit.status === "available"
                            ? "text-green-500"
                            : unit.status === "enroute"
                              ? "text-yellow-500"
                              : unit.status === "on_scene"
                                ? "text-blue-500"
                                : "text-muted-foreground"
                        }`}
                      >
                        {unit.status.toUpperCase()}
                      </div>
                    </div>
                  ))}
                  {fireUnits.length === 0 && (
                    <div className="col-span-2 text-center text-muted-foreground py-4 text-xs font-mono">
                      NO UNITS ON DUTY
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* My Shift Card */}
            <Card className="bg-card border-border">
              <CardHeader className="py-3 px-4 border-b">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-bold uppercase tracking-wide">
                    My Shift
                  </span>
                </div>
              </CardHeader>
              <CardContent className="p-4">
                <div className="space-y-2 text-xs font-mono">
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">STATUS</span>
                    <span
                      className={
                        isOnDuty ? "text-green-500" : "text-muted-foreground"
                      }
                    >
                      {isOnDuty ? "ACTIVE" : "INACTIVE"}
                    </span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">
                      CURRENT STATUS
                    </span>
                    <span>{myStatus.toUpperCase()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">TOTAL CALLS</span>
                    <span>{activeCalls.length}</span>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* Callsign Selection Dialog */}
      <Dialog open={showCallsignDialog} onOpenChange={setShowCallsignDialog}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>Начать смену</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <Label>Выберите офицера</Label>
              <Select onValueChange={handleOfficerSelect} value={tempOfficerId}>
                <SelectTrigger>
                  <SelectValue placeholder="Выберите офицера" />
                </SelectTrigger>
                <SelectContent>
                  {officers.map((officer) => (
                    <SelectItem key={officer.id} value={officer.id}>
                      {officer.character.firstName} {officer.character.lastName}
                      {officer.callsign && ` (${officer.callsign})`}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setShowCallsignDialog(false)}
            >
              Отмена
            </Button>
            <Button onClick={handleConfirmCallsign} disabled={!tempOfficerId}>
              Начать смену
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Call Details Dialog */}
      <Dialog open={showCallModal} onOpenChange={setShowCallModal}>
        <DialogContent className="sm:max-w-2xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Детали вызова</DialogTitle>
          </DialogHeader>
          {selectedCall && (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label>Тип</Label>
                  <div className="font-mono">
                    {selectedCall.type.toUpperCase()}
                  </div>
                </div>
                <div>
                  <Label>Приоритет</Label>
                  <div className="font-mono">
                    {priorityMap[selectedCall.priority]}
                  </div>
                </div>
                <div>
                  <Label>Статус</Label>
                  <div className="font-mono">
                    {statusMap[selectedCall.status]}
                  </div>
                </div>
                <div>
                  <Label>Время</Label>
                  <div className="font-mono">
                    {new Date(selectedCall.createdAt).toLocaleString()}
                  </div>
                </div>
                <div className="col-span-2">
                  <Label>Местоположение</Label>
                  <div className="font-mono">{selectedCall.location}</div>
                </div>
                <div className="col-span-2">
                  <Label>Описание</Label>
                  <div className="font-mono">{selectedCall.description}</div>
                </div>
                {selectedCall.callerName && (
                  <div>
                    <Label>Звонивший</Label>
                    <div className="font-mono">{selectedCall.callerName}</div>
                  </div>
                )}
                {selectedCall.callerPhone && (
                  <div>
                    <Label>Телефон</Label>
                    <div className="font-mono">{selectedCall.callerPhone}</div>
                  </div>
                )}
              </div>

              <div className="border-t pt-4">
                <div className="flex justify-between items-center mb-2">
                  <Label>Назначенные юниты</Label>
                  <div className="space-x-2">
                    {myUnit &&
                      !selectedCall.assignedUnits?.includes(myUnit.id) && (
                        <Button size="sm" onClick={handleSelfAssign}>
                          Назначить себя
                        </Button>
                      )}
                    {myUnit &&
                      selectedCall.assignedUnits?.includes(myUnit.id) && (
                        <Button
                          size="sm"
                          variant="destructive"
                          onClick={handleSelfUnassign}
                        >
                          Снять себя
                        </Button>
                      )}
                  </div>
                </div>
                <div className="flex flex-wrap gap-2">
                  {selectedCall.assignedUnits?.map((unitId) => {
                    const unit = units.find((u) => u.id === unitId);
                    return (
                      <Badge key={unitId} variant="outline">
                        {unit?.callsign || unitId}
                      </Badge>
                    );
                  })}
                  {(!selectedCall.assignedUnits ||
                    selectedCall.assignedUnits.length === 0) && (
                    <span className="text-sm text-muted-foreground">
                      Нет назначенных юнитов
                    </span>
                  )}
                </div>
              </div>

              <div className="border-t pt-4">
                <Label>Логи вызова</Label>
                <ScrollArea className="h-[200px] border rounded-md p-2 mt-2">
                  {callLogs.map((log) => (
                    <div key={log.id} className="mb-2 text-sm border-b pb-1">
                      <div className="flex justify-between">
                        <span className="font-mono text-xs text-muted-foreground">
                          {new Date(log.createdAt).toLocaleTimeString()} -{" "}
                          {log.authorCallsign || "System"}
                        </span>
                      </div>
                      <div className="mt-1">{log.content}</div>
                    </div>
                  ))}
                  {callLogs.length === 0 && (
                    <div className="text-center text-muted-foreground py-4">
                      Нет логов
                    </div>
                  )}
                </ScrollArea>
                <div className="flex gap-2 mt-2">
                  <Input
                    placeholder="Введите сообщение..."
                    value={newMessage}
                    onChange={(e) => setNewMessage(e.target.value)}
                    onKeyDown={(e) => e.key === "Enter" && handleSendMessage()}
                  />
                  <Button onClick={handleSendMessage}>Отправить</Button>
                </div>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Civilian Modal */}
      <CivilianModal
        open={showSearchModal}
        onOpenChange={setShowSearchModal}
        civilian={selectedResult}
        mode="view"
        extraActions={
          !selectedResult?.isDead && (
            <Button
              variant="destructive"
              onClick={async () => {
                if (!selectedResult) return;
                if (
                  !confirm(
                    `Объявить ${selectedResult.firstName} ${selectedResult.lastName} мёртвым?`,
                  )
                )
                  return;
                try {
                  await api.put(`/character/characters/${selectedResult.id}`, {
                    isDead: true,
                  });
                  toast.success("Персонаж объявлен мёртвым");
                  setSelectedResult({ ...selectedResult, isDead: true });
                  setSearchResults2((prev) =>
                    prev.map((c) =>
                      c.id === selectedResult.id ? { ...c, isDead: true } : c,
                    ),
                  );
                } catch (error) {
                  console.error("Error marking as dead:", error);
                  toast.error("Ошибка при объявлении мёртвым");
                }
              }}
            >
              <AlertTriangle className="h-4 w-4 mr-2" />
              ОБЪЯВИТЬ МЁРТВЫМ
            </Button>
          )
        }
      />
    </div>
  );
}
