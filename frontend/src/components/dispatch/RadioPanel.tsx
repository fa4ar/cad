"use client";

import { useState, useEffect, useCallback } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { toast } from "sonner";
import { api } from "@/lib/api";
import {
  Radio,
  Radio as RadioIcon,
  Bell,
  BellOff,
  Volume2,
  VolumeX,
  Send,
  Settings,
  RefreshCw,
  Wifi,
  WifiOff,
  AlertTriangle,
  Users,
} from "lucide-react";

interface RadioChannel {
  name: string;
  frequency: number;
  type: string;
}

interface RadioAlert {
  id: string;
  name: string;
  color: string;
  isPersistent: boolean;
}

interface RadioPlayer {
  serverId: number;
  name: string;
  callsign: string;
}

interface RadioPanelProps {
  className?: string;
}

export function RadioPanel({ className }: RadioPanelProps) {
  const [isConnected, setIsConnected] = useState(false);
  const [channels, setChannels] = useState<RadioChannel[]>([]);
  const [alerts, setAlerts] = useState<RadioAlert[]>([]);
  const [selectedChannel, setSelectedChannel] = useState<string>("");
  const [showBroadcastDialog, setShowBroadcastDialog] = useState(false);
  const [showAlertDialog, setShowAlertDialog] = useState(false);
  const [broadcastMessage, setBroadcastMessage] = useState("");
  const [alertMessage, setAlertMessage] = useState("");
  const [selectedAlert, setSelectedAlert] = useState<string>("");
  const [loading, setLoading] = useState(false);
  const [config, setConfig] = useState<any>(null);

  useEffect(() => {
    fetchRadioStatus();
    fetchRadioConfig();

    const interval = setInterval(fetchRadioStatus, 10000);
    return () => clearInterval(interval);
  }, []);

  const fetchRadioStatus = async () => {
    try {
      const res = await api.get("/radio/dispatch/status");
      setIsConnected(res.data?.connected || false);
      setChannels(res.data?.channels || []);
      setAlerts(res.data?.alerts || []);
    } catch (error) {
      console.error("Error fetching radio status:", error);
      setIsConnected(false);
    }
  };

  const fetchRadioConfig = async () => {
    try {
      const res = await api.get("/radio/dispatch/config");
      setConfig(res.data);
      if (res.data?.alerts) {
        setAlerts(res.data.alerts);
      }
    } catch (error) {
      console.error("Error fetching radio config:", error);
    }
  };

  const handleBroadcast = async () => {
    if (!selectedChannel || !broadcastMessage) {
      toast.error("Выберите канал и введите сообщение");
      return;
    }

    setLoading(true);
    try {
      await api.post("/radio/dispatch/broadcast", {
        frequency: parseFloat(selectedChannel),
        message: broadcastMessage,
        type: "Dispatch",
      });
      toast.success("Broadcast отправлен");
      setShowBroadcastDialog(false);
      setBroadcastMessage("");
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Ошибка отправки broadcast");
    } finally {
      setLoading(false);
    }
  };

  const handleTriggerAlert = async () => {
    if (!selectedAlert) {
      toast.error("Выберите оповещение");
      return;
    }

    setLoading(true);
    try {
      await api.post("/radio/dispatch/alert/trigger", {
        alertName: selectedAlert,
        message: alertMessage,
      });
      toast.success("Оповещение активировано");
      setShowAlertDialog(false);
      setAlertMessage("");
      fetchRadioStatus();
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Ошибка активации оповещения");
    } finally {
      setLoading(false);
    }
  };

  const handlePlayTone = async (toneName: string) => {
    if (!selectedChannel) {
      toast.error("Выберите канал");
      return;
    }

    try {
      await api.post("/radio/dispatch/tone", {
        frequency: parseFloat(selectedChannel),
        tone: toneName,
      });
      toast.success("Тон отправлен");
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Ошибка отправки тона");
    }
  };

  const handleClearAlert = async (alertId: string) => {
    try {
      await api.post("/radio/dispatch/alert/clear", { alertId });
      toast.success("Оповещение очищено");
      fetchRadioStatus();
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Ошибка очистки оповещения");
    }
  };

  const handleOneShot = async () => {
    if (!selectedChannel || !selectedAlert) {
      toast.error("Выберите канал и оповещение");
      return;
    }

    setLoading(true);
    try {
      await api.post("/radio/dispatch/alert/oneshot", {
        frequency: parseFloat(selectedChannel),
        alertName: selectedAlert,
      });
      toast.success("One-shot отправлен");
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Ошибка");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className={`bg-[#0a0a0a] border-white/10 ${className}`}>
      <CardHeader className="pb-2">
        <div className="flex items-center justify-between">
          <CardTitle className="text-sm font-medium text-[#e6e6e6] flex items-center gap-2">
            <RadioIcon className="h-4 w-4" />
            Radio Control
          </CardTitle>
          <Badge
            variant={isConnected ? "default" : "destructive"}
            className={isConnected ? "bg-green-600" : "bg-red-600"}
          >
            {isConnected ? (
              <Wifi className="h-3 w-3 mr-1" />
            ) : (
              <WifiOff className="h-3 w-3 mr-1" />
            )}
            {isConnected ? "ONLINE" : "OFFLINE"}
          </Badge>
        </div>
      </CardHeader>
      <CardContent className="space-y-3">
        {!isConnected ? (
          <div className="text-center py-4 text-[#808080]">
            <RadioIcon className="h-8 w-8 mx-auto mb-2 opacity-50" />
            <p className="text-sm">Radio not connected</p>
            <Button
              variant="outline"
              size="sm"
              className="mt-2 border-white/10"
              onClick={fetchRadioStatus}
            >
              <RefreshCw className="h-3 w-3 mr-1" />
              Retry
            </Button>
          </div>
        ) : (
          <>
            <div className="space-y-2">
              <Label className="text-xs text-[#808080]">Channel</Label>
              <Select value={selectedChannel} onValueChange={setSelectedChannel}>
                <SelectTrigger className="bg-[#111111] border-white/10">
                  <SelectValue placeholder="Select channel" />
                </SelectTrigger>
                <SelectContent className="bg-[#111111] border-white/10">
                  {channels.map((channel) => (
                    <SelectItem
                      key={channel.frequency}
                      value={channel.frequency.toString()}
                    >
                      {channel.name} ({channel.frequency} MHz)
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid grid-cols-2 gap-2">
              <Button
                size="sm"
                className="bg-blue-600 hover:bg-blue-700"
                onClick={() => setShowBroadcastDialog(true)}
                disabled={!selectedChannel}
              >
                <Send className="h-3 w-3 mr-1" />
                Broadcast
              </Button>
              <Button
                size="sm"
                className="bg-orange-600 hover:bg-orange-700"
                onClick={() => setShowAlertDialog(true)}
              >
                <Bell className="h-3 w-3 mr-1" />
                Alert
              </Button>
            </div>

            <div className="grid grid-cols-3 gap-1">
              <Button
                size="sm"
                variant="outline"
                className="border-white/10 text-xs"
                onClick={() => handlePlayTone("ALERT_A")}
                disabled={!selectedChannel}
              >
                Alert A
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="border-white/10 text-xs"
                onClick={() => handlePlayTone("ALERT_B")}
                disabled={!selectedChannel}
              >
                Alert B
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="border-white/10 text-xs"
                onClick={handleOneShot}
                disabled={!selectedChannel || !selectedAlert}
              >
                One-Shot
              </Button>
            </div>

            {alerts && alerts.length > 0 && (
              <div className="space-y-1">
                <Label className="text-xs text-[#808080]">Active Alerts</Label>
                <div className="flex flex-wrap gap-1">
                  {alerts.map((alert) => (
                    <Badge
                      key={alert.id}
                      className="cursor-pointer"
                      style={{ backgroundColor: alert.color }}
                      onClick={() => handleClearAlert(alert.id)}
                    >
                      {alert.name}
                    </Badge>
                  ))}
                </div>
              </div>
            )}
          </>
        )}
      </CardContent>

      <Dialog open={showBroadcastDialog} onOpenChange={setShowBroadcastDialog}>
        <DialogContent className="bg-[#111111] border-white/10">
          <DialogHeader>
            <DialogTitle>Radio Broadcast</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="text-[#808080]">Channel</Label>
              <Input
                value={selectedChannel}
                disabled
                className="bg-[#0a0a0a] border-white/10"
              />
            </div>
            <div>
              <Label className="text-[#808080]">Message</Label>
              <Textarea
                value={broadcastMessage}
                onChange={(e) => setBroadcastMessage(e.target.value)}
                placeholder="Enter broadcast message..."
                className="bg-[#0a0a0a] border-white/10"
                rows={3}
              />
            </div>
          </div>
          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setShowBroadcastDialog(false)}
              className="border-white/10"
            >
              Cancel
            </Button>
            <Button
              onClick={handleBroadcast}
              disabled={loading || !broadcastMessage}
              className="bg-blue-600"
            >
              <Send className="h-4 w-4 mr-1" />
              Send
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={showAlertDialog} onOpenChange={setShowAlertDialog}>
        <DialogContent className="bg-[#111111] border-white/10">
          <DialogHeader>
            <DialogTitle>Trigger Alert</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="text-[#808080]">Alert Type</Label>
              <Select value={selectedAlert} onValueChange={setSelectedAlert}>
                <SelectTrigger className="bg-[#0a0a0a] border-white/10">
                  <SelectValue placeholder="Select alert" />
                </SelectTrigger>
                <SelectContent className="bg-[#111111] border-white/10">
                  {config?.alerts?.map((alert: any) => (
                    <SelectItem key={alert.name} value={alert.name}>
                      <div className="flex items-center gap-2">
                        <div
                          className="w-3 h-3 rounded-full"
                          style={{ backgroundColor: alert.color }}
                        />
                        {alert.name}
                      </div>
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label className="text-[#808080]">Message (optional)</Label>
              <Input
                value={alertMessage}
                onChange={(e) => setAlertMessage(e.target.value)}
                placeholder="Alert message..."
                className="bg-[#0a0a0a] border-white/10"
              />
            </div>
          </div>
          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setShowAlertDialog(false)}
              className="border-white/10"
            >
              Cancel
            </Button>
            <Button
              onClick={handleTriggerAlert}
              disabled={loading || !selectedAlert}
              className="bg-orange-600"
            >
              <Bell className="h-4 w-4 mr-1" />
              Trigger
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </Card>
  );
}

export default RadioPanel;
