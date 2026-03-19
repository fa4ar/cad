"use client"

import { useEffect, useState, useRef, useCallback } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Maximize2, Minimize2, RefreshCw, MapPin } from "lucide-react"

interface Player {
  identifier: string
  name: string
  location?: string
  pos?: { x: number; y: number; z: number }
  icon?: number
  weapon?: string
  vehicle?: string
  licensePlate?: string
  hasSirenEnabled?: boolean
}

interface LiveMapProps {
  blipsUrl?: string
  className?: string
  height?: string
  pollInterval?: number
}

const ICON_COLORS: Record<string, string> = {
  "56": "#3b82f6",
  "68": "#f59e0b",
  "64": "#8b5cf6",
  "225": "#6b7280",
  "6": "#10b981",
  default: "#3b82f6"
}

const ICON_LABELS: Record<string, string> = {
  "56": "Полиция",
  "68": "Эвакуатор",
  "64": "Вертолёт",
  "225": "Транспорт",
  "6": "Пешком",
  default: "Игрок"
}

export function LiveMap({ 
  blipsUrl = "http://localhost:30121/blips",
  className = "",
  height = "500px",
  pollInterval = 2000
}: LiveMapProps) {
  const mapRef = useRef<HTMLDivElement>(null)
  const mapInstanceRef = useRef<any>(null)
  const markersRef = useRef<Map<string, any>>(new Map())
  const [isFullscreen, setIsFullscreen] = useState(false)
  const [isConnected, setIsConnected] = useState(false)
  const [players, setPlayers] = useState<Player[]>([])
  const [blips, setBlips] = useState<any[]>([])
  const [error, setError] = useState<string | null>(null)
  const [settings, setSettings] = useState({
    blipsUrl,
    showLabels: true,
    showWeapons: true,
    showVehicles: true,
    autoCenter: true
  })

  const fetchBlips = useCallback(async () => {
    try {
      const response = await fetch(settings.blipsUrl)
      if (response.ok) {
        const data = await response.json()
        setBlips(data)
        setIsConnected(true)
        setError(null)
      } else {
        setIsConnected(false)
      }
    } catch (err) {
      setIsConnected(false)
      setError("Не удалось подключиться к серверу")
    }
  }, [settings.blipsUrl])

  const initMap = useCallback(async () => {
    if (!mapRef.current || mapInstanceRef.current) return

    const L = (await import("leaflet")).default
    
    const map = L.map(mapRef.current, {
      preferCanvas: true,
      zoomControl: false,
      minZoom: 0,
      maxZoom: 5,
      crs: L.CRS.Simple,
      maxBounds: [[0, 0], [4096, 4096]]
    })

    L.tileLayer('https://cdn.radiant.gta.world/{z}/{x}/{y}.png', {
      attribution: '&copy; GTA Map',
      noWrap: true,
      minZoom: 0,
      maxZoom: 5,
      bounds: [[0, 0], [4096, 4096]]
    }).addTo(map)

    map.fitBounds([[0, 0], [4096, 4096]])

    mapInstanceRef.current = { map, L }
  }, [])

  useEffect(() => {
    initMap()
  }, [initMap])

  useEffect(() => {
    fetchBlips()
    const interval = setInterval(fetchBlips, pollInterval)
    return () => clearInterval(interval)
  }, [fetchBlips, pollInterval])

  useEffect(() => {
    if (!mapInstanceRef.current || !blips.length) return

    const { map, L } = mapInstanceRef.current

    markersRef.current.forEach((marker) => {
      marker.remove()
    })
    markersRef.current.clear()

    blips.forEach((blip: any) => {
      if (blip.x !== undefined && blip.y !== undefined) {
        const color = blip.color ? ICON_COLORS[blip.color] || ICON_COLORS.default : ICON_COLORS.default
        const sprite = blip.sprite ? String(blip.sprite) : "225"
        const label = ICON_LABELS[sprite] || ICON_LABELS.default

        const icon = L.divIcon({
          className: 'custom-player-marker',
          html: `
            <div style="
              background: ${color};
              width: 28px;
              height: 28px;
              border-radius: 50%;
              border: 3px solid white;
              box-shadow: 0 2px 8px rgba(0,0,0,0.5);
              display: flex;
              align-items: center;
              justify-content: center;
              font-size: 12px;
              font-weight: bold;
              color: white;
            ">
              ${blip.name?.charAt(0).toUpperCase() || '?'}
            </div>
          `,
          iconSize: [28, 28],
          iconAnchor: [14, 14]
        })

        const marker = L.marker([blip.x, blip.y], { icon }).addTo(map)

        let tooltipContent = `<strong>${blip.name || 'Unknown'}</strong><br/>`
        tooltipContent += `<span style="color: ${color}">${label}</span>`

        marker.bindTooltip(tooltipContent, {
          direction: 'top',
          html: true
        })

        markersRef.current.set(blip.name || Math.random(), marker)
      }
    })

    if (settings.autoCenter && blips.length > 0) {
      const validBlips = blips.filter((b: any) => b.x !== undefined && b.y !== undefined)
      if (validBlips.length > 0) {
        const avgX = validBlips.reduce((sum: number, b: any) => sum + b.x, 0) / validBlips.length
        const avgY = validBlips.reduce((sum: number, b: any) => sum + b.y, 0) / validBlips.length
        map.setView([avgX, avgY], map.getZoom())
      }
    }
  }, [blips, settings.autoCenter])

  const toggleFullscreen = () => {
    setIsFullscreen(!isFullscreen)
  }

  return (
    <Card className={`${className} ${isFullscreen ? 'fixed inset-0 z-50 rounded-none' : ''}`}>
      <CardHeader className="pb-2">
        <div className="flex items-center justify-between">
          <CardTitle className="flex items-center gap-2 text-lg">
            <MapPin className="h-5 w-5" />
            Live Map
          </CardTitle>
          <div className="flex items-center gap-2">
            <Badge variant={isConnected ? "default" : "destructive"} className="text-xs">
              {isConnected ? "Подключено" : "Отключено"}
            </Badge>
            <Badge variant="outline" className="text-xs">
              {blips.length} игроков
            </Badge>
            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={toggleFullscreen}>
              {isFullscreen ? <Minimize2 className="h-4 w-4" /> : <Maximize2 className="h-4 w-4" />}
            </Button>
            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={fetchBlips}>
              <RefreshCw className="h-4 w-4" />
            </Button>
          </div>
        </div>
      </CardHeader>
      <CardContent className="p-0">
        {error && (
          <div className="p-4 bg-destructive/10 text-destructive text-center text-sm">
            {error}
          </div>
        )}
        <div 
          ref={mapRef} 
          style={{ height: isFullscreen ? 'calc(100vh - 80px)' : height }}
          className="w-full bg-muted"
        />
      </CardContent>
    </Card>
  )
}
