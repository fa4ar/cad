import Head from "next/head";
import * as React from "react";
import { Layout } from "components/Layout";
import { useAuth } from "context/AuthContext";
import { getSessionUser } from "lib/auth";
import { getTranslations } from "lib/getTranslation";
import { requestAll } from "lib/utils";
import type { GetServerSideProps } from "next";
import { useDispatchState } from "state/dispatch/dispatch-state";
import { Title } from "components/shared/Title";
import { Permissions } from "@snailycad/permissions";
import type { DispatchPageProps } from ".";
import { ValueType } from "@snailycad/types";
import { useLoadValuesClientSide } from "hooks/useLoadValuesClientSide";
import { useCall911State } from "state/dispatch/call-911-state";
import { LiveMap } from "components/LiveMap";
import { ScrollArea } from "components/ui/scroll-area";
import { Badge } from "components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "components/ui/card";

type Props = Pick<DispatchPageProps, "bolos" | "calls" | "activeDeputies" | "activeOfficers">;

const statusColors: Record<string, string> = {
  available: "bg-green-500",
  busy: "bg-yellow-500",
  enroute: "bg-purple-500",
  on_scene: "bg-blue-500",
  off_duty: "bg-gray-500",
};

const statusLabels: Record<string, string> = {
  available: "Свободен",
  busy: "Занят",
  enroute: "В пути",
  on_scene: "На месте",
  off_duty: "Не на дежурстве",
};

const priorityColors: Record<string, string> = {
  low: "bg-gray-500",
  medium: "bg-yellow-500",
  high: "bg-orange-500",
  critical: "bg-red-500",
};

const priorityLabels: Record<string, string> = {
  low: "Низкий",
  medium: "Средний",
  high: "Высокий",
  critical: "Критический",
};

const callTypeLabels: Record<string, string> = {
  911: "911",
  traffic: "ДТП",
  crime: "Преступление",
  medical: "Медицинский",
  fire: "Пожар",
  other: "Другое",
};

function UnitsList({ officers }: { officers: any[] }) {
  return (
    <Card className="h-full">
      <CardHeader className="pb-2">
        <CardTitle className="text-lg">Юниты на дежурстве</CardTitle>
      </CardHeader>
      <CardContent className="p-0">
        <ScrollArea className="h-[calc(50vh-100px)]">
          <div className="px-4 space-y-2">
            {officers.length === 0 ? (
              <p className="text-muted-foreground text-center py-8">Нет юнитов на дежурстве</p>
            ) : (
              officers.map((officer) => (
                <div
                  key={officer.id}
                  className="p-3 rounded-lg border bg-card hover:bg-accent/50 transition-colors"
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <Badge variant="outline" className="font-mono">
                        #{officer.badgeNumber || officer.callsign || "—"}
                      </Badge>
                      <span className="text-xs text-muted-foreground">
                        {officer.callsign || "—"}
                      </span>
                    </div>
                    <Badge className={`${statusColors[officer.status] || "bg-gray-500"} text-white text-xs`}>
                      {statusLabels[officer.status] || officer.status}
                    </Badge>
                  </div>
                  <div className="space-y-1">
                    <p className="font-medium text-sm">
                      {officer.firstName} {officer.lastName}
                    </p>
                    <div className="flex items-center gap-2 text-xs text-muted-foreground">
                      {officer.department?.shortName && (
                        <span className="bg-primary/10 px-2 py-0.5 rounded">
                          {officer.department.shortName}
                        </span>
                      )}
                      {officer.division?.name && (
                        <span>{officer.division.name}</span>
                      )}
                    </div>
                  </div>
                  {officer.activeVehicle && (
                    <div className="mt-2 text-xs text-muted-foreground">
                      🚗 {officer.activeVehicle}
                    </div>
                  )}
                </div>
              ))
            )}
          </div>
        </ScrollArea>
      </CardContent>
    </Card>
  );
}

function CallsList({ calls }: { calls: any[] }) {
  return (
    <Card className="h-full">
      <CardHeader className="pb-2">
        <CardTitle className="text-lg">Вызовы 911</CardTitle>
      </CardHeader>
      <CardContent className="p-0">
        <ScrollArea className="h-[calc(50vh-100px)]">
          <div className="px-4 space-y-2">
            {calls.length === 0 ? (
              <p className="text-muted-foreground text-center py-8">Нет активных вызовов</p>
            ) : (
              calls.filter((c: any) => c.status !== 'completed' && c.status !== 'cancelled').map((call: any) => (
                <div
                  key={call.id}
                  className="p-3 rounded-lg border bg-card hover:bg-accent/50 transition-colors"
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <Badge variant="outline">
                        {callTypeLabels[call.type] || call.type}
                      </Badge>
                      <Badge className={`${priorityColors[call.priority] || "bg-gray-500"} text-white text-xs`}>
                        {priorityLabels[call.priority] || call.priority}
                      </Badge>
                    </div>
                    <Badge variant={call.status === 'pending' ? 'destructive' : 'default'} className="text-xs">
                      {call.status === 'pending' ? 'Ожидает' : 
                       call.status === 'dispatched' ? 'Назначен' :
                       call.status === 'enroute' ? 'В пути' :
                       call.status === 'on_scene' ? 'На месте' : call.status}
                    </Badge>
                  </div>
                  <div className="space-y-1">
                    <p className="font-medium text-sm">{call.location || 'Неизвестно'}</p>
                    <p className="text-xs text-muted-foreground line-clamp-2">
                      {call.description || 'Нет описания'}
                    </p>
                    {call.callerName && (
                      <p className="text-xs text-muted-foreground">
                        От: {call.callerName}
                      </p>
                    )}
                  </div>
                  {call.assignedUnits && call.assignedUnits.length > 0 && (
                    <div className="mt-2 flex flex-wrap gap-1">
                      {call.assignedUnits.map((unit: string, idx: number) => (
                        <Badge key={idx} variant="outline" className="text-xs">
                          {unit}
                        </Badge>
                      ))}
                    </div>
                  )}
                </div>
              ))
            )}
          </div>
        </ScrollArea>
      </CardContent>
    </Card>
  );
}

function DataSync({ onUnitsUpdate, onCallsUpdate }: { onUnitsUpdate: (units: any[]) => void, onCallsUpdate: (calls: any[]) => void }) {
  const [units, setUnits] = React.useState<any[]>([]);
  const [calls, setCalls] = React.useState<any[]>([]);
  const [connected, setConnected] = React.useState(false);

  React.useEffect(() => {
    const apiUrl = process.env.NEXT_PUBLIC_BACKEND_URL || 'http://localhost:3030';

    const fetchData = async () => {
      try {
        const [unitsRes, callsRes] = await Promise.all([
          fetch(`${apiUrl}/api/fivem/units`),
          fetch(`${apiUrl}/api/fivem/calls`)
        ]);

        if (unitsRes.ok) {
          const unitsData = await unitsRes.json();
          setUnits(unitsData);
          onUnitsUpdate(unitsData);
        }

        if (callsRes.ok) {
          const callsData = await callsRes.json();
          setCalls(callsData);
          onCallsUpdate(callsData);
        }

        setConnected(true);
      } catch (err) {
        console.error('Sync error:', err);
        setConnected(false);
      }
    };

    fetchData();
    const interval = setInterval(fetchData, 3000);

    return () => clearInterval(interval);
  }, []);

  return null;
}

export default function MapPage(props: Props) {
  useLoadValuesClientSide({
    valueTypes: [
      ValueType.CALL_TYPE,
      ValueType.PENAL_CODE,
      ValueType.DEPARTMENT,
      ValueType.DIVISION,
    ],
  });

  const { cad, user } = useAuth();
  const state = useDispatchState();
  const set911Calls = useCall911State((state) => state.setCalls);
  const [fivemUnits, setFivemUnits] = React.useState<any[]>([]);
  const [fivemCalls, setFivemCalls] = React.useState<any[]>([]);

  React.useEffect(() => {
    set911Calls(props.calls.calls);
    state.setBolos(props.bolos.bolos);
    state.setActiveDeputies(props.activeDeputies);
    state.setActiveOfficers(props.activeOfficers);
  }, [props]);

  const handleUnitsUpdate = React.useCallback((units: any[]) => {
    setFivemUnits(units);
  }, []);

  const handleCallsUpdate = React.useCallback((calls: any[]) => {
    setFivemCalls(calls);
  }, []);

  const allOfficers = React.useMemo(() => {
    const cadOfficers = (props.activeOfficers || []).filter((o: any) => o.onDuty);
    
    const merged = [...cadOfficers];
    
    fivemUnits.forEach((unit: any) => {
      if (!merged.find((o: any) => o.callsign === unit.callsign)) {
        merged.push({
          id: unit.source || unit.identifier,
          callsign: unit.callsign,
          badgeNumber: unit.callsign,
          status: unit.status,
          onDuty: unit.status !== 'off_duty',
          firstName: unit.name || 'Unknown',
          lastName: '',
          department: unit.department ? { shortName: unit.department } : null,
          activeVehicle: unit.vehicle || null,
        });
      }
    });

    return merged;
  }, [props.activeOfficers, fivemUnits]);

  const allCalls = React.useMemo(() => {
    const cadCalls = props.calls?.calls || [];
    const merged = [...cadCalls];
    
    fivemCalls.forEach((call: any) => {
      if (!merged.find((c: any) => c.id === call.id)) {
        merged.push(call);
      }
    });

    return merged;
  }, [props.calls, fivemCalls]);

  if (!user || !cad) {
    return null;
  }

  return (
    <>
      <Head>
        <link
          rel="stylesheet"
          href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
          integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
          crossOrigin=""
        />
      </Head>
      <Title renderLayoutTitle={false}>Dispatch Live Map</Title>

      <DataSync onUnitsUpdate={handleUnitsUpdate} onCallsUpdate={handleCallsUpdate} />

      <Layout
        permissions={{ permissions: [Permissions.LiveMap] }}
        navMaxWidth="none"
        className="relative !px-0 !pb-0 !mt-0 !max-w-none grid grid-cols-4"
      >
        <div className="col-span-1 space-y-2 p-2">
          <UnitsList officers={allOfficers} />
          <CallsList calls={allCalls} />
        </div>
        <div className="col-span-3">
          <LiveMap 
            blipsUrl={process.env.NEXT_PUBLIC_FIVEM_BLIPS_URL || "http://localhost:30121/blips"}
            height="calc(100vh - 100px)"
          />
        </div>
      </Layout>
    </>
  );
}

export const getServerSideProps: GetServerSideProps = async ({ req, locale }) => {
  const user = await getSessionUser(req);
  const [values, calls, bolos, activeOfficers, activeDeputies] = await requestAll(req, [
    ["/admin/values/codes_10", []],
    ["/911-calls", { calls: [], totalCount: 0 }],
    ["/bolos", { bolos: [], totalCount: 0 }],
    ["/leo/active-officers", []],
    ["/ems-fd/active-deputies", []],
  ]);

  return {
    props: {
      session: user,
      calls,
      bolos,
      values,
      activeOfficers,
      activeDeputies,
      messages: {
        ...(await getTranslations(
          ["citizen", "ems-fd", "leo", "calls", "common"],
          user?.locale ?? locale,
        )),
      },
    },
  };
};