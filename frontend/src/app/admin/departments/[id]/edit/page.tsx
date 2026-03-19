"use client"

import { useState, useEffect, useRef } from "react"
import { useParams, useRouter } from "next/navigation"
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"
import { Separator } from "@/components/ui/separator"
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from "@/components/ui/command"
import { ChevronLeft, Plus, Trash2, Edit, Save, User, Users, Building2, Award, Crown, X, Check, ChevronsUpDown } from "lucide-react"
import { cn } from "@/lib/utils"
import { toast } from "sonner"
import api from "@/lib/api/axios"

interface Division {
  id: string
  name: string
  code: string
  description?: string
  color?: string
  isDetective?: boolean
  supervisorId?: string
  supervisor?: {
    id: string
    username: string
    avatar?: string
  }
}

interface DepartmentRank {
  id: string
  name: string
  code: string
  description?: string
  color?: string
  icon?: string
  weight: number
  isSupervisor?: boolean
  permissions: string[]
  salary?: number
}

interface Department {
  id: string
  name: string
  shortCode: string
  type: string
  description?: string
  color?: string
  icon?: string
  isActive: boolean
  maxMembers?: number
  logoUrl?: string
  leader?: {
    id: string
    username: string
    avatar?: string
  }
  divisions?: Division[]
  ranks?: DepartmentRank[]
}

interface User {
  id: string
  username: string
  email: string
  avatar?: string
}

export default function EditDepartmentPage() {
  const params = useParams()
  const router = useRouter()
  const departmentId = params.id as string

  const [department, setDepartment] = useState<Department | null>(null)
  const [users, setUsers] = useState<User[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [isSaving, setIsSaving] = useState(false)

  const [divisions, setDivisions] = useState<Division[]>([])
  const [ranks, setRanks] = useState<DepartmentRank[]>([])

  const [isCreateDivisionOpen, setIsCreateDivisionOpen] = useState(false)
  const [isCreateRankOpen, setIsCreateRankOpen] = useState(false)

  const [divisionForm, setDivisionForm] = useState({
    name: "",
    code: "",
    description: "",
    color: "#3b82f6",
    isDetective: false,
    supervisorId: null as string | null,
  })

  const [departmentSettings, setDepartmentSettings] = useState({
  })

  const [rankForm, setRankForm] = useState({
    name: "",
    code: "",
    description: "",
    color: "#3b82f6",
    icon: "в­ђ",
    weight: 0,
    isSupervisor: false,
    salary: null as number | null,
  })

  const [editingDivision, setEditingDivision] = useState<Division | null>(null)
  const [editingRank, setEditingRank] = useState<DepartmentRank | null>(null)

  const [openSupervisorSelect, setOpenSupervisorSelect] = useState(false)
  const [supervisorSearch, setSupervisorSearch] = useState("")

  useEffect(() => {
    fetchDepartment()
    fetchUsers()
  }, [departmentId])

  const fetchDepartment = async () => {
    try {
      const { data } = await api.get(`/admin/departments/${departmentId}`)
      if (data.success) {
        setDepartment(data.department)
        setDivisions(data.department.divisions || [])
        setRanks(data.department.ranks || [])
      }
    } catch (error) {
      toast.error("РћС€РёР±РєР° Р·Р°РіСЂСѓР·РєРё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°")
    } finally {
      setIsLoading(false)
    }
  }

  const fetchUsers = async () => {
    try {
      const { data } = await api.get("/user/users")
      const usersList = data.data?.users || data.users || []
      setUsers(usersList.map((u: any) => ({
        id: u.id,
        username: u.username,
        email: u.email,
        avatar: u.avatarUrl || u.avatar
      })))
    } catch (error) {
      console.error("Error fetching users:", error)
    }
  }

  const handleCreateDivision = async () => {
    if (!divisionForm.name || !divisionForm.code) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    try {
      const { data } = await api.post(`/admin/departments/${departmentId}/divisions`, divisionForm)
      if (data.success) {
        setDivisions([...divisions, data.division])
        setIsCreateDivisionOpen(false)
        setDivisionForm({ name: "", code: "", description: "", color: "#3b82f6", isDetective: false, supervisorId: null })
        toast.success("РџРѕРґСЂР°Р·РґРµР»РµРЅРёРµ СЃРѕР·РґР°РЅРѕ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° СЃРѕР·РґР°РЅРёСЏ РїРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ")
    }
  }

  const handleUpdateDivision = async () => {
    if (!editingDivision || !divisionForm.name || !divisionForm.code) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    try {
      const { data } = await api.put(`/admin/departments/${departmentId}/divisions/${editingDivision.id}`, divisionForm)
      if (data.success) {
        setDivisions(divisions.map(d => d.id === editingDivision.id ? data.division : d))
        setEditingDivision(null)
        setDivisionForm({ name: "", code: "", description: "", color: "#3b82f6", isDetective: false, supervisorId: null })
        toast.success("РџРѕРґСЂР°Р·РґРµР»РµРЅРёРµ РѕР±РЅРѕРІР»РµРЅРѕ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° РѕР±РЅРѕРІР»РµРЅРёСЏ РїРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ")
    }
  }

  const handleDeleteDivision = async (id: string) => {
    if (!confirm("Р’С‹ СѓРІРµСЂРµРЅС‹, С‡С‚Рѕ С…РѕС‚РёС‚Рµ СѓРґР°Р»РёС‚СЊ СЌС‚Рѕ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ?")) return

    try {
      const { data } = await api.delete(`/admin/departments/${departmentId}/divisions/${id}`)
      if (data.success) {
        setDivisions(divisions.filter(d => d.id !== id))
        toast.success("РџРѕРґСЂР°Р·РґРµР»РµРЅРёРµ СѓРґР°Р»РµРЅРѕ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° СѓРґР°Р»РµРЅРёСЏ РїРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ")
    }
  }

  const handleCreateRank = async () => {
    if (!rankForm.name || !rankForm.code) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    try {
      const { data } = await api.post(`/admin/departments/${departmentId}/ranks`, rankForm)
      if (data.success) {
        setRanks([...ranks, data.rank])
        setIsCreateRankOpen(false)
        setRankForm({ name: "", code: "", description: "", color: "#3b82f6", icon: "в­ђ", weight: 0, isSupervisor: false, salary: null })
        toast.success("Р Р°РЅРі СЃРѕР·РґР°РЅ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° СЃРѕР·РґР°РЅРёСЏ СЂР°РЅРіР°")
    }
  }

  const handleUpdateRank = async () => {
    if (!editingRank || !rankForm.name || !rankForm.code) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    try {
      const { data } = await api.put(`/admin/departments/${departmentId}/ranks/${editingRank.id}`, rankForm)
      if (data.success) {
        setRanks(ranks.map(r => r.id === editingRank.id ? data.rank : r))
        setEditingRank(null)
        setRankForm({ name: "", code: "", description: "", color: "#3b82f6", icon: "в­ђ", weight: 0, isSupervisor: false, salary: null })
        toast.success("Р Р°РЅРі РѕР±РЅРѕРІР»РµРЅ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° РѕР±РЅРѕРІР»РµРЅРёСЏ СЂР°РЅРіР°")
    }
  }

  const handleDeleteRank = async (id: string) => {
    if (!confirm("Р’С‹ СѓРІРµСЂРµРЅС‹, С‡С‚Рѕ С…РѕС‚РёС‚Рµ СѓРґР°Р»РёС‚СЊ СЌС‚РѕС‚ СЂР°РЅРі?")) return

    try {
      const { data } = await api.delete(`/admin/departments/${departmentId}/ranks/${id}`)
      if (data.success) {
        setRanks(ranks.filter(r => r.id !== id))
        toast.success("Р Р°РЅРі СѓРґР°Р»РµРЅ")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° СѓРґР°Р»РµРЅРёСЏ СЂР°РЅРіР°")
    }
  }

  const handleSaveSettings = async () => {
    setIsSaving(true)
    try {
      const { data } = await api.put(`/admin/departments/${departmentId}`, departmentSettings)
      if (data.success) {
        setDepartment({ ...department, ...departmentSettings } as Department)
        toast.success("РќР°СЃС‚СЂРѕР№РєРё СЃРѕС…СЂР°РЅРµРЅС‹")
      }
    } catch (error: any) {
      toast.error(error.response?.data?.error || "РћС€РёР±РєР° СЃРѕС…СЂР°РЅРµРЅРёСЏ")
    } finally {
      setIsSaving(false)
    }
  }

  const openEditDivision = (division: Division) => {
    setEditingDivision(division)
    setDivisionForm({
      name: division.name,
      code: division.code,
      description: division.description || "",
      color: division.color || "#3b82f6",
      isDetective: division.isDetective || false,
      supervisorId: division.supervisorId || null,
    })
  }

  const openEditRank = (rank: DepartmentRank) => {
    setEditingRank(rank)
    setRankForm({
      name: rank.name,
      code: rank.code,
      description: rank.description || "",
      color: rank.color || "#3b82f6",
      icon: rank.icon || "в­ђ",
      weight: rank.weight,
      isSupervisor: rank.isSupervisor || false,
      salary: rank.salary || null,
    })
  }

  const getSupervisor = (supervisorId: string | null | undefined) => {
    if (!supervisorId) return null
    return users.find(u => u.id === supervisorId)
  }

  const filteredUsers = users.filter(u => 
    u.username.toLowerCase().includes(supervisorSearch.toLowerCase()) ||
    u.email?.toLowerCase().includes(supervisorSearch.toLowerCase())
  )

  if (isLoading) {
    return (
      <div className="container mx-auto py-10 px-4 flex items-center justify-center min-h-[60vh]">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Р—Р°РіСЂСѓР·РєР°...</p>
        </div>
      </div>
    )
  }

  if (!department) {
    return (
      <div className="container mx-auto py-10 px-4">
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <h3 className="text-lg font-semibold mb-2">Р”РµРїР°СЂС‚Р°РјРµРЅС‚ РЅРµ РЅР°Р№РґРµРЅ</h3>
              <Button onClick={() => router.push("/admin/departments")}>РќР°Р·Р°Рґ Рє СЃРїРёСЃРєСѓ</Button>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="container mx-auto py-6 px-4">
      <div className="flex items-center gap-4 mb-6">
        <Button variant="ghost" size="icon" onClick={() => router.push("/admin/departments")}>
          <ChevronLeft className="h-5 w-5" />
        </Button>
        <div>
          <h1 className="text-2xl font-bold">Р РµРґР°РєС‚РёСЂРѕРІР°РЅРёРµ: {department.name}</h1>
          <p className="text-muted-foreground">{department.shortCode}</p>
        </div>
        <Badge variant={department.isActive ? "default" : "secondary"} className="ml-auto">
          {department.isActive ? "РђРєС‚РёРІРµРЅ" : "РќРµР°РєС‚РёРІРµРЅ"}
        </Badge>
      </div>

      <Tabs defaultValue="divisions" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="divisions" className="flex items-center gap-2">
            <Building2 className="h-4 w-4" />
            РџРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ
          </TabsTrigger>
          <TabsTrigger value="ranks" className="flex items-center gap-2">
            <Award className="h-4 w-4" />
            Р—РІР°РЅРёСЏ
          </TabsTrigger>
          <TabsTrigger value="settings" className="flex items-center gap-2">
            <Save className="h-4 w-4" />
            РќР°СЃС‚СЂРѕР№РєРё
          </TabsTrigger>
        </TabsList>

        <TabsContent value="divisions" className="mt-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle className="flex items-center gap-2">
                <Building2 className="h-5 w-5" />
                РџРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°
              </CardTitle>
              <Dialog open={isCreateDivisionOpen} onOpenChange={setIsCreateDivisionOpen}>
                <DialogTrigger asChild>
                  <Button>
                    <Plus className="h-4 w-4 mr-2" />
                    Р”РѕР±Р°РІРёС‚СЊ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ
                  </Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>РќРѕРІРѕРµ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ</DialogTitle>
                    <DialogDescription>РЎРѕР·РґР°Р№С‚Рµ РЅРѕРІРѕРµ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ РІ СЃРѕСЃС‚Р°РІРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4 py-4">
                    <div className="space-y-2">
                      <Label>РќР°Р·РІР°РЅРёРµ *</Label>
                      <Input
                        value={divisionForm.name}
                        onChange={(e) => setDivisionForm({ ...divisionForm, name: e.target.value })}
                        placeholder="РџР°С‚СЂСѓР»СЊРЅС‹Р№ РѕС‚РґРµР»"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>РљРѕРґ *</Label>
                      <Input
                        value={divisionForm.code}
                        onChange={(e) => setDivisionForm({ ...divisionForm, code: e.target.value })}
                        placeholder="PATROL"
                        maxLength={10}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>РћРїРёСЃР°РЅРёРµ</Label>
                      <Textarea
                        value={divisionForm.description}
                        onChange={(e) => setDivisionForm({ ...divisionForm, description: e.target.value })}
                        placeholder="РћРїРёСЃР°РЅРёРµ РїРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ..."
                      />
                    </div>
                    <div className="flex items-center justify-between p-4 border rounded-lg">
                      <div>
                        <Label className="text-base">Р”РµС‚РµРєС‚РёРІРЅС‹Р№ РѕС‚РґРµР»</Label>
                        <p className="text-sm text-muted-foreground">РћС‚РґРµР» РёРјРµРµС‚ РґРѕСЃС‚СѓРї Рє С„СѓРЅРєС†РёСЏРј СЂР°СЃСЃР»РµРґРѕРІР°РЅРёР№</p>
                      </div>
                      <input
                        type="checkbox"
                        checked={divisionForm.isDetective}
                        onChange={(e) => setDivisionForm({ ...divisionForm, isDetective: e.target.checked })}
                        className="h-5 w-5"
                      />
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label>Р¦РІРµС‚</Label>
                        <div className="flex items-center gap-2">
                          <Input
                            type="color"
                            value={divisionForm.color}
                            onChange={(e) => setDivisionForm({ ...divisionForm, color: e.target.value })}
                            className="w-12 h-10 p-1"
                          />
                          <Input
                            value={divisionForm.color}
                            onChange={(e) => setDivisionForm({ ...divisionForm, color: e.target.value })}
                          />
                        </div>
                      </div>
                      <div className="space-y-2">
                        <Label>РЎСѓРїРµСЂРІР°Р№Р·РµСЂ</Label>
                        <Popover open={openSupervisorSelect} onOpenChange={setOpenSupervisorSelect}>
                          <PopoverTrigger asChild>
                            <Button variant="outline" className="w-full justify-between">
                              {getSupervisor(divisionForm.supervisorId) ? (
                                <span className="flex items-center gap-2">
                                  <Avatar className="h-6 w-6">
                                    <AvatarImage src={getSupervisor(divisionForm.supervisorId)?.avatar} />
                                    <AvatarFallback>{getSupervisor(divisionForm.supervisorId)?.username.charAt(0)}</AvatarFallback>
                                  </Avatar>
                                  {getSupervisor(divisionForm.supervisorId)?.username}
                                </span>
                              ) : (
                                <span className="text-muted-foreground">Р’С‹Р±РµСЂРёС‚Рµ...</span>
                              )}
                              <ChevronsUpDown className="ml-2 h-4 w-4 opacity-50" />
                            </Button>
                          </PopoverTrigger>
                          <PopoverContent className="w-[300px] p-0">
                            <Command>
                              <CommandInput placeholder="РџРѕРёСЃРє..." value={supervisorSearch} onValueChange={setSupervisorSearch} />
                              <CommandList>
                                <CommandEmpty>РќРµ РЅР°Р№РґРµРЅРѕ</CommandEmpty>
                                <CommandGroup>
                                  {filteredUsers.map(user => (
                                    <CommandItem
                                      key={user.id}
                                      value={user.id}
                                      onSelect={() => {
                                        setDivisionForm({ ...divisionForm, supervisorId: user.id === divisionForm.supervisorId ? null : user.id })
                                        setOpenSupervisorSelect(false)
                                      }}
                                    >
                                      <Avatar className="h-6 w-6 mr-2">
                                        <AvatarImage src={user.avatar} />
                                        <AvatarFallback>{user.username.charAt(0)}</AvatarFallback>
                                      </Avatar>
                                      <span>{user.username}</span>
                                      {user.id === divisionForm.supervisorId && <Check className="ml-auto h-4 w-4" />}
                                    </CommandItem>
                                  ))}
                                </CommandGroup>
                              </CommandList>
                            </Command>
                          </PopoverContent>
                        </Popover>
                      </div>
                    </div>
                  </div>
                  <DialogFooter>
                    <Button variant="outline" onClick={() => setIsCreateDivisionOpen(false)}>РћС‚РјРµРЅР°</Button>
                    <Button onClick={handleCreateDivision}>РЎРѕР·РґР°С‚СЊ</Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </CardHeader>
            <CardContent>
              {divisions.length === 0 ? (
                <div className="text-center py-8">
                  <Building2 className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                  <h3 className="text-lg font-semibold mb-2">РџРѕРґСЂР°Р·РґРµР»РµРЅРёСЏ РЅРµ СЃРѕР·РґР°РЅС‹</h3>
                  <p className="text-muted-foreground mb-4">Р”РѕР±Р°РІСЊС‚Рµ РїРµСЂРІРѕРµ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ</p>
                </div>
              ) : (
                <div className="grid gap-4">
                  {divisions.map(division => (
                    <div key={division.id} className="flex items-center justify-between p-4 border rounded-lg">
                      <div className="flex items-center gap-4">
                        <div className="w-4 h-4 rounded-full" style={{ backgroundColor: division.color || '#3b82f6' }} />
                        <div>
                          <div className="font-medium flex items-center gap-2">
                            {division.name}
                            <Badge variant="outline" className="text-xs">{division.code}</Badge>
                            {division.isDetective && <Badge className="bg-purple-500 text-white text-xs">Р”РµС‚РµРєС‚РёРІРЅС‹Р№</Badge>}
                          </div>
                          {division.description && (
                            <p className="text-sm text-muted-foreground">{division.description}</p>
                          )}
                          {division.supervisor && (
                            <div className="flex items-center gap-2 mt-1 text-sm text-muted-foreground">
                              <Crown className="h-3 w-3 text-amber-500" />
                              <span>РЎСѓРїРµСЂРІР°Р№Р·РµСЂ: {division.supervisor.username}</span>
                            </div>
                          )}
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <Button variant="outline" size="sm" onClick={() => openEditDivision(division)}>
                          <Edit className="h-4 w-4" />
                        </Button>
                        <Button variant="outline" size="sm" onClick={() => handleDeleteDivision(division.id)}>
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="ranks" className="mt-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle className="flex items-center gap-2">
                <Award className="h-5 w-5" />
                Р—РІР°РЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°
              </CardTitle>
              <Dialog open={isCreateRankOpen} onOpenChange={setIsCreateRankOpen}>
                <DialogTrigger asChild>
                  <Button>
                    <Plus className="h-4 w-4 mr-2" />
                    Р”РѕР±Р°РІРёС‚СЊ Р·РІР°РЅРёРµ
                  </Button>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <DialogTitle>РќРѕРІРѕРµ Р·РІР°РЅРёРµ</DialogTitle>
                    <DialogDescription>РЎРѕР·РґР°Р№С‚Рµ РЅРѕРІРѕРµ Р·РІР°РЅРёРµ РґР»СЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4 py-4">
                    <div className="space-y-2">
                      <Label>РќР°Р·РІР°РЅРёРµ *</Label>
                      <Input
                        value={rankForm.name}
                        onChange={(e) => setRankForm({ ...rankForm, name: e.target.value })}
                        placeholder="Р СЏРґРѕРІРѕР№"
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>РљРѕРґ *</Label>
                      <Input
                        value={rankForm.code}
                        onChange={(e) => setRankForm({ ...rankForm, code: e.target.value })}
                        placeholder="ROOKIE"
                        maxLength={20}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>РћРїРёСЃР°РЅРёРµ</Label>
                      <Textarea
                        value={rankForm.description}
                        onChange={(e) => setRankForm({ ...rankForm, description: e.target.value })}
                        placeholder="РћРїРёСЃР°РЅРёРµ Р·РІР°РЅРёСЏ..."
                      />
                    </div>
                    <div className="flex items-center justify-between p-4 border rounded-lg">
                      <div>
                        <Label className="text-base">РЎСѓРїРµСЂРІР°Р№Р·РµСЂ</Label>
                        <p className="text-sm text-muted-foreground">Р Р°РЅРі РјРѕР¶РµС‚ СЃРѕР·РґР°РІР°С‚СЊ РѕСЂРґРµСЂР°</p>
                      </div>
                      <input
                        type="checkbox"
                        checked={rankForm.isSupervisor}
                        onChange={(e) => setRankForm({ ...rankForm, isSupervisor: e.target.checked })}
                        className="h-5 w-5"
                      />
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label>Р¦РІРµС‚</Label>
                        <div className="flex items-center gap-2">
                          <Input
                            type="color"
                            value={rankForm.color}
                            onChange={(e) => setRankForm({ ...rankForm, color: e.target.value })}
                            className="w-12 h-10 p-1"
                          />
                          <Input
                            value={rankForm.color}
                            onChange={(e) => setRankForm({ ...rankForm, color: e.target.value })}
                          />
                        </div>
                      </div>
                      <div className="space-y-2">
                        <Label>РРєРѕРЅРєР°</Label>
                        <Input
                          value={rankForm.icon}
                          onChange={(e) => setRankForm({ ...rankForm, icon: e.target.value })}
                          placeholder="в­ђ"
                          maxLength={2}
                        />
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label>Р’РµСЃ (СЃРѕСЂС‚РёСЂРѕРІРєР°)</Label>
                        <Input
                          type="number"
                          value={rankForm.weight}
                          onChange={(e) => setRankForm({ ...rankForm, weight: parseInt(e.target.value) || 0 })}
                        />
                      </div>
                      <div className="space-y-2">
                        <Label>Р—Р°СЂРїР»Р°С‚Р°</Label>
                        <Input
                          type="number"
                          value={rankForm.salary || ""}
                          onChange={(e) => setRankForm({ ...rankForm, salary: e.target.value ? parseInt(e.target.value) : null })}
                          placeholder="0"
                        />
                      </div>
                    </div>
                  </div>
                  <DialogFooter>
                    <Button variant="outline" onClick={() => setIsCreateRankOpen(false)}>РћС‚РјРµРЅР°</Button>
                    <Button onClick={handleCreateRank}>РЎРѕР·РґР°С‚СЊ</Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </CardHeader>
            <CardContent>
              {ranks.length === 0 ? (
                <div className="text-center py-8">
                  <Award className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                  <h3 className="text-lg font-semibold mb-2">Р—РІР°РЅРёСЏ РЅРµ СЃРѕР·РґР°РЅС‹</h3>
                  <p className="text-muted-foreground mb-4">Р”РѕР±Р°РІСЊС‚Рµ РїРµСЂРІРѕРµ Р·РІР°РЅРёРµ</p>
                </div>
              ) : (
                <div className="grid gap-4">
                  {ranks.sort((a, b) => a.weight - b.weight).map(rank => (
                    <div key={rank.id} className="flex items-center justify-between p-4 border rounded-lg">
                      <div className="flex items-center gap-4">
                        <span className="text-2xl">{rank.icon}</span>
                        <div>
                          <div className="font-medium flex items-center gap-2">
                            {rank.name}
                            <Badge variant="outline" className="text-xs">{rank.code}</Badge>
                            <Badge style={{ backgroundColor: rank.color, color: '#fff' }} className="text-xs">{rank.weight}</Badge>
                            {rank.isSupervisor && <Badge className="bg-amber-500 text-white text-xs">РЎСѓРїРµСЂРІР°Р№Р·РµСЂ</Badge>}
                          </div>
                          {rank.description && (
                            <p className="text-sm text-muted-foreground">{rank.description}</p>
                          )}
                          {rank.salary && (
                            <p className="text-sm text-muted-foreground">Р—Р°СЂРїР»Р°С‚Р°: ${rank.salary}</p>
                          )}
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <Button variant="outline" size="sm" onClick={() => openEditRank(rank)}>
                          <Edit className="h-4 w-4" />
                        </Button>
                        <Button variant="outline" size="sm" onClick={() => handleDeleteRank(rank.id)}>
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="settings" className="mt-6">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Save className="h-5 w-5" />
                РќР°СЃС‚СЂРѕР№РєРё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="text-center py-8">
                <Save className="h-12 w-12 mx-auto text-muted-foreground mb-4" />
                <h3 className="text-lg font-semibold mb-2">РќР°СЃС‚СЂРѕР№РєРё РїРµСЂРµРЅРµСЃРµРЅС‹</h3>
                <p className="text-muted-foreground">
                  "Р”РµС‚РµРєС‚РёРІРЅС‹Р№ РѕС‚РґРµР»" С‚РµРїРµСЂСЊ РЅР°С…РѕРґРёС‚СЃСЏ РІ РїРѕРґСЂР°Р·РґРµР»РµРЅРёСЏС…<br />
                  "РЎСѓРїРµСЂРІР°Р№Р·РµСЂ" С‚РµРїРµСЂСЊ РЅР°С…РѕРґРёС‚СЃСЏ РІ Р·РІР°РЅРёСЏС…
                </p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      <Dialog open={!!editingDivision} onOpenChange={(open) => !open && setEditingDivision(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Р РµРґР°РєС‚РёСЂРѕРІР°С‚СЊ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРµ</DialogTitle>
            <DialogDescription>РР·РјРµРЅРёС‚Рµ РёРЅС„РѕСЂРјР°С†РёСЋ Рѕ РїРѕРґСЂР°Р·РґРµР»РµРЅРёРё</DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <Label>РќР°Р·РІР°РЅРёРµ *</Label>
              <Input
                value={divisionForm.name}
                onChange={(e) => setDivisionForm({ ...divisionForm, name: e.target.value })}
              />
            </div>
            <div className="space-y-2">
              <Label>РљРѕРґ *</Label>
              <Input
                value={divisionForm.code}
                onChange={(e) => setDivisionForm({ ...divisionForm, code: e.target.value })}
                maxLength={10}
              />
            </div>
              <div className="space-y-2">
              <Label>РћРїРёСЃР°РЅРёРµ</Label>
              <Textarea
                value={divisionForm.description}
                onChange={(e) => setDivisionForm({ ...divisionForm, description: e.target.value })}
              />
            </div>
            <div className="flex items-center justify-between p-4 border rounded-lg">
              <div>
                <Label className="text-base">Р”РµС‚РµРєС‚РёРІРЅС‹Р№ РѕС‚РґРµР»</Label>
                <p className="text-sm text-muted-foreground">РћС‚РґРµР» РёРјРµРµС‚ РґРѕСЃС‚СѓРї Рє С„СѓРЅРєС†РёСЏРј СЂР°СЃСЃР»РµРґРѕРІР°РЅРёР№</p>
              </div>
              <input
                type="checkbox"
                checked={divisionForm.isDetective}
                onChange={(e) => setDivisionForm({ ...divisionForm, isDetective: e.target.checked })}
                className="h-5 w-5"
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Р¦РІРµС‚</Label>
                <div className="flex items-center gap-2">
                  <Input
                    type="color"
                    value={divisionForm.color}
                    onChange={(e) => setDivisionForm({ ...divisionForm, color: e.target.value })}
                    className="w-12 h-10 p-1"
                  />
                  <Input
                    value={divisionForm.color}
                    onChange={(e) => setDivisionForm({ ...divisionForm, color: e.target.value })}
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label>РЎСѓРїРµСЂРІР°Р№Р·РµСЂ</Label>
                <Popover open={openSupervisorSelect} onOpenChange={setOpenSupervisorSelect}>
                  <PopoverTrigger asChild>
                    <Button variant="outline" className="w-full justify-between">
                      {getSupervisor(divisionForm.supervisorId) ? (
                        <span className="flex items-center gap-2">
                          <Avatar className="h-6 w-6">
                            <AvatarImage src={getSupervisor(divisionForm.supervisorId)?.avatar} />
                            <AvatarFallback>{getSupervisor(divisionForm.supervisorId)?.username.charAt(0)}</AvatarFallback>
                          </Avatar>
                          {getSupervisor(divisionForm.supervisorId)?.username}
                        </span>
                      ) : (
                        <span className="text-muted-foreground">Р’С‹Р±РµСЂРёС‚Рµ...</span>
                      )}
                      <ChevronsUpDown className="ml-2 h-4 w-4 opacity-50" />
                    </Button>
                  </PopoverTrigger>
                  <PopoverContent className="w-[300px] p-0">
                    <Command>
                      <CommandInput placeholder="РџРѕРёСЃРє..." value={supervisorSearch} onValueChange={setSupervisorSearch} />
                      <CommandList>
                        <CommandEmpty>РќРµ РЅР°Р№РґРµРЅРѕ</CommandEmpty>
                        <CommandGroup>
                          {filteredUsers.map(user => (
                            <CommandItem
                              key={user.id}
                              value={user.id}
                              onSelect={() => {
                                setDivisionForm({ ...divisionForm, supervisorId: user.id === divisionForm.supervisorId ? null : user.id })
                                setOpenSupervisorSelect(false)
                              }}
                            >
                              <Avatar className="h-6 w-6 mr-2">
                                <AvatarImage src={user.avatar} />
                                <AvatarFallback>{user.username.charAt(0)}</AvatarFallback>
                              </Avatar>
                              <span>{user.username}</span>
                              {user.id === divisionForm.supervisorId && <Check className="ml-auto h-4 w-4" />}
                            </CommandItem>
                          ))}
                        </CommandGroup>
                      </CommandList>
                    </Command>
                  </PopoverContent>
                </Popover>
              </div>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setEditingDivision(null)}>РћС‚РјРµРЅР°</Button>
            <Button onClick={handleUpdateDivision}>РЎРѕС…СЂР°РЅРёС‚СЊ</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!editingRank} onOpenChange={(open) => !open && setEditingRank(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Р РµРґР°РєС‚РёСЂРѕРІР°С‚СЊ Р·РІР°РЅРёРµ</DialogTitle>
            <DialogDescription>РР·РјРµРЅРёС‚Рµ РёРЅС„РѕСЂРјР°С†РёСЋ Рѕ Р·РІР°РЅРёРё</DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <Label>РќР°Р·РІР°РЅРёРµ *</Label>
              <Input
                value={rankForm.name}
                onChange={(e) => setRankForm({ ...rankForm, name: e.target.value })}
              />
            </div>
            <div className="space-y-2">
              <Label>РљРѕРґ *</Label>
              <Input
                value={rankForm.code}
                onChange={(e) => setRankForm({ ...rankForm, code: e.target.value })}
                maxLength={20}
              />
            </div>
            <div className="space-y-2">
              <Label>РћРїРёСЃР°РЅРёРµ</Label>
              <Textarea
                value={rankForm.description}
                onChange={(e) => setRankForm({ ...rankForm, description: e.target.value })}
              />
            </div>
            <div className="flex items-center justify-between p-4 border rounded-lg">
              <div>
                <Label className="text-base">РЎСѓРїРµСЂРІР°Р№Р·РµСЂ</Label>
                <p className="text-sm text-muted-foreground">Р Р°РЅРі РјРѕР¶РµС‚ СЃРѕР·РґР°РІР°С‚СЊ РѕСЂРґРµСЂР°</p>
              </div>
              <input
                type="checkbox"
                checked={rankForm.isSupervisor}
                onChange={(e) => setRankForm({ ...rankForm, isSupervisor: e.target.checked })}
                className="h-5 w-5"
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Р¦РІРµС‚</Label>
                <div className="flex items-center gap-2">
                  <Input
                    type="color"
                    value={rankForm.color}
                    onChange={(e) => setRankForm({ ...rankForm, color: e.target.value })}
                    className="w-12 h-10 p-1"
                  />
                  <Input
                    value={rankForm.color}
                    onChange={(e) => setRankForm({ ...rankForm, color: e.target.value })}
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label>РРєРѕРЅРєР°</Label>
                <Input
                  value={rankForm.icon}
                  onChange={(e) => setRankForm({ ...rankForm, icon: e.target.value })}
                  maxLength={2}
                />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Р’РµСЃ (СЃРѕСЂС‚РёСЂРѕРІРєР°)</Label>
                <Input
                  type="number"
                  value={rankForm.weight}
                  onChange={(e) => setRankForm({ ...rankForm, weight: parseInt(e.target.value) || 0 })}
                />
              </div>
              <div className="space-y-2">
                <Label>Р—Р°СЂРїР»Р°С‚Р°</Label>
                <Input
                  type="number"
                  value={rankForm.salary || ""}
                  onChange={(e) => setRankForm({ ...rankForm, salary: e.target.value ? parseInt(e.target.value) : null })}
                />
              </div>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setEditingRank(null)}>РћС‚РјРµРЅР°</Button>
            <Button onClick={handleUpdateRank}>РЎРѕС…СЂР°РЅРёС‚СЊ</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}


