"use client"

// @ts-nocheck
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Search, Plus, Users, Settings, Trash2, Edit, User, Check, X, Crown, ChevronsUpDown, Building2 } from "lucide-react"
import React, { useState, useEffect, useRef } from "react"
import { useRouter } from "next/navigation"
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { ScrollArea } from "@/components/ui/scroll-area"
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList } from "@/components/ui/command"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { cn } from "@/lib/utils"
import { useAuth } from "@/lib/auth"
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query"
import { toast } from "sonner"
import api from "@/lib/api/axios"

// Helper function to construct full URL for uploads
const getUploadUrl = (path: string | null) => {
  if (!path) return null;
  let baseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';
  baseUrl = baseUrl.replace('/api', '');
  return path.startsWith('http') ? path : `${baseUrl}${path}`;
};

interface User {
  id: string
  username: string
  email: string
  avatar?: string
  rank?: string
  isActive: boolean
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
  permissions: string[]
  leader?: {
    id: string
    username: string
    avatar?: string
  }
  members?: User[]
  _count?: {
    members: number
    officers: number
    vehicles: number
  }
}

// РўРёРїС‹ РґР»СЏ API Р·Р°РїСЂРѕСЃРѕРІ
interface CreateDepartmentData {
  name: string
  shortCode: string
  type: string
  description?: string
  color?: string
  icon?: string
  maxMembers?: number | null
  permissions: string[]
  leaderId?: string | null
  logoFile?: File | null
}

interface UpdateDepartmentData extends Partial<CreateDepartmentData> {
  isActive?: boolean
  leaderId?: string | null
  logoFile?: File | null
}

// РҐСѓРєРё РґР»СЏ СЂР°Р±РѕС‚С‹ СЃ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°РјРё
const useDepartments = () => {
  return useQuery({
    queryKey: ["departments"],
    queryFn: async () => {
      const { data } = await api.get("/admin/departments")
      console.log('Departments API response:', data);
      
      if (!data.success) {
        throw new Error(data.error || "РћС€РёР±РєР° Р·Р°РіСЂСѓР·РєРё РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ")
      }

      return data.departments?.map((dept: any) => ({
        ...dept,
        _count: dept._count || {
          members: 0,
          officers: 0,
          vehicles: 0,
        },
        members: dept.members || [],
      })) || []
    },
    staleTime: 5 * 60 * 1000, // 5 РјРёРЅСѓС‚
    gcTime: 10 * 60 * 1000, // 10 РјРёРЅСѓС‚
  })
}

const useUsers = () => {
  return useQuery({
    queryKey: ["users"],
    queryFn: async () => {
      const { data } = await api.get("/user/users")
      const usersList = data.data?.users || data.users || []
      return usersList.map((u: any) => ({
        id: u.id,
        username: u.username,
        email: u.email,
        avatar: u.avatarUrl || u.avatar,
        rank: u.rank
      }))
    },
    staleTime: 5 * 60 * 1000,
    gcTime: 10 * 60 * 1000,
  })
}

const useCreateDepartment = () => {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: async (departmentData: CreateDepartmentData) => {
      // If logo file is provided, use FormData
      if (departmentData.logoFile) {
        const form = new FormData()
        form.append('name', departmentData.name)
        form.append('shortCode', departmentData.shortCode)
        form.append('type', departmentData.type)
        if (departmentData.description) form.append('description', departmentData.description)
        if (departmentData.color) form.append('color', departmentData.color)
        if (departmentData.icon) form.append('icon', departmentData.icon)
        if (departmentData.maxMembers != null) form.append('maxMembers', String(departmentData.maxMembers))
        departmentData.permissions.forEach(p => form.append('permissions', p))
        if (departmentData.leaderId) form.append('leaderId', departmentData.leaderId)
        if (departmentData.logoFile) form.append('logo', departmentData.logoFile)
      const { data } = await api.post('/admin/departments', form, { headers: { 'Content-Type': 'multipart/form-data' } })
        if (!data.success) {
          throw new Error(data.error || 'РћС€РёР±РєР° СЃРѕР·РґР°РЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°')
        }
        return data.department
      }
      // Without logo
      const { data } = await api.post('/admin/departments', departmentData)
      if (!data.success) {
        throw new Error(data.error || 'РћС€РёР±РєР° СЃРѕР·РґР°РЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°')
      }
      return data.department
    },
    onSuccess: (newDepartment) => {
      // РћР±РЅРѕРІР»СЏРµРј РєСЌС€, РґРѕР±Р°РІР»СЏСЏ РЅРѕРІС‹Р№ РґРµРїР°СЂС‚Р°РјРµРЅС‚
      queryClient.setQueryData<Department[]>(["departments"], (oldData = []) => {
        const departmentWithCount = {
          ...newDepartment,
          _count: newDepartment._count || {
            members: 0,
            officers: 0,
            vehicles: 0,
          },
          members: newDepartment.members || [],
        }
        return [...oldData, departmentWithCount]
      })

      toast.success("Р”РµРїР°СЂС‚Р°РјРµРЅС‚ СѓСЃРїРµС€РЅРѕ СЃРѕР·РґР°РЅ")
    },
    onError: (error: any) => {
      const errorMessage = error.response?.data?.error || error.message || "РћС€РёР±РєР° СЃРѕР·РґР°РЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°"
      toast.error(errorMessage)
    },
  })
}

  const useUpdateDepartment = () => {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: async ({ id, data }: { id: string; data: UpdateDepartmentData }) => {
      // Update with possible logo file via FormData
      if ((data as any).logoFile) {
        const fd = new FormData()
        Object.entries(data).forEach(([k, v]) => {
          if (k === 'logoFile') {
            if (v) fd.append('logo', v as any)
          } else if (v !== undefined) {
            fd.append(k, v as any)
          }
        })
        const { data: response } = await api.put(`/admin/departments/${id}`, fd, { headers: { 'Content-Type': 'multipart/form-data' } })
        if (!response.success) throw new Error(response.error || 'РћС€РёР±РєР° РѕР±РЅРѕРІР»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°')
        return response.department
      }
      // Р‘РµР· Р»РѕРіРѕ
      const { data: response } = await api.put(`/admin/departments/${id}`, data)
      if (!response.success) {
        throw new Error(response.error || "РћС€РёР±РєР° РѕР±РЅРѕРІР»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°")
      }
      return response.department
    },
    onSuccess: (updatedDepartment) => {
      // РћР±РЅРѕРІР»СЏРµРј РєСЌС€
      queryClient.setQueryData<Department[]>(["departments"], (oldData = []) =>
        oldData.map((dept) => 
          dept.id === updatedDepartment.id 
            ? { ...dept, ...updatedDepartment }
            : dept
        )
      )

      toast.success("Р”РµРїР°СЂС‚Р°РјРµРЅС‚ СѓСЃРїРµС€РЅРѕ РѕР±РЅРѕРІР»РµРЅ")
    },
    onError: (error: any) => {
      const errorMessage = error.response?.data?.error || error.message || "РћС€РёР±РєР° РѕР±РЅРѕРІР»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°"
      toast.error(errorMessage)
    },
  })
}

const useDeleteDepartment = () => {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: async (id: string) => {
      const { data } = await api.delete(`/admin/departments/${id}`)
      if (!data.success) {
        throw new Error(data.error || "РћС€РёР±РєР° СѓРґР°Р»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°")
      }
      return id
    },
    onSuccess: (deletedId) => {
      // РЈРґР°Р»СЏРµРј РґРµРїР°СЂС‚Р°РјРµРЅС‚ РёР· РєСЌС€Р°
      queryClient.setQueryData<Department[]>(["departments"], (oldData = []) =>
        oldData.filter((dept) => dept.id !== deletedId)
      )

      toast.success("Р”РµРїР°СЂС‚Р°РјРµРЅС‚ СѓСЃРїРµС€РЅРѕ СѓРґР°Р»РµРЅ")
    },
    onError: (error: any) => {
      const errorMessage = error.response?.data?.error || error.message || "РћС€РёР±РєР° СѓРґР°Р»РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°"
      toast.error(errorMessage)
    },
  })
}

// Simple Dropzone UI for uploading logos (square with SVG)
 const LogoDropzone: React.FC<{ onFile: (f: File) => void }> = ({ onFile }) => {
  const inputRef = useRef<HTMLInputElement | null>(null)
  const [dragOver, setDragOver] = useState(false)

  return (
    <div
      onClick={() => inputRef.current?.click()}
      onDrop={(e) => { e.preventDefault(); setDragOver(false); const f = e.dataTransfer?.files?.[0]; if (f) onFile(f); }}
      onDragOver={(e) => { e.preventDefault(); setDragOver(true) }}
      onDragLeave={() => setDragOver(false)}
      className={`w-40 h-40 border-2 ${dragOver ? 'border-primary' : 'border-dashed border-muted'} rounded-md flex items-center justify-center cursor-pointer bg-muted`}
      style={{ userSelect: 'none' }}
    >
      <div className="flex flex-col items-center justify-center text-center">
        <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-label="upload-icon">
          <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
          <polyline points="7 10 12 15 17 10"/>
          <line x1="12" y1="3" x2="12" y2="15"/>
        </svg>
        <span className="mt-2 text-sm text-muted-foreground">РџРµСЂРµС‚Р°С‰РёС‚Рµ С„Р°Р№Р» РёР»Рё РєР»РёРєРЅРёС‚Рµ</span>
      </div>
      <input ref={inputRef} type="file" accept="image/*" className="hidden" onChange={(e) => {
        const f = e.currentTarget.files?.[0]; if (f) onFile(f);
      }} />
    </div>
  )
}

export default function DeptPage() {
  const { user } = useAuth()
  const router = useRouter()
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false)
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false)
  const [isDeleteDialogOpen, setIsDeleteDialogOpen] = useState(false)
  const [searchQuery, setSearchQuery] = useState("")
  const [selectedDepartment, setSelectedDepartment] = useState<Department | null>(null)
  const [openLeaderSelect, setOpenLeaderSelect] = useState(false)
  const [leaderSearch, setLeaderSearch] = useState("")
  
  const [createFormData, setCreateFormData] = useState<CreateDepartmentData>({
    name: "",
    shortCode: "",
    type: "LEO",
    description: "",
    color: "#3b82f6",
    icon: "рџЏў",
    maxMembers: null,
    permissions: [],
    leaderId: null,
    logoFile: null,
  })

  const [editFormData, setEditFormData] = useState<UpdateDepartmentData>({
    name: "",
    shortCode: "",
    type: "LEO",
    description: "",
    color: "#3b82f6",
    icon: "рџЏў",
    maxMembers: null,
    permissions: [],
    isActive: true,
    leaderId: null,
    logoFile: null,
  })

  // РСЃРїРѕР»СЊР·СѓРµРј С…СѓРєРё TanStack Query
  const {
    data: departments = [],
    isLoading,
    error,
    refetch,
  } = useDepartments()

  const { data: allUsers = [] } = useUsers()

  const createDepartmentMutation = useCreateDepartment()
  const updateDepartmentMutation = useUpdateDepartment()
  const deleteDepartmentMutation = useDeleteDepartment()

  const departmentTypes = [
    { value: "LEO", label: "РџСЂР°РІРѕРѕС…СЂР°РЅРёС‚РµР»СЊРЅС‹Рµ РѕСЂРіР°РЅС‹" },
    { value: "FIRE", label: "РџРѕР¶Р°СЂРЅР°СЏ СЃР»СѓР¶Р±Р°" },
    { value: "EMS", label: "РЎРєРѕСЂР°СЏ РїРѕРјРѕС‰СЊ" },
    { value: "CIVIL", label: "Р“СЂР°Р¶РґР°РЅСЃРєРёРµ СЃР»СѓР¶Р±С‹" },
    { value: "GOVERNMENT", label: "РџСЂР°РІРёС‚РµР»СЊСЃС‚РІРѕ" },
  ]

  const availablePermissions = [
    "users.view",
    "users.edit",
    "departments.manage",
    "vehicles.manage",
    "reports.create",
    "reports.view",
    "admin.access",
  ]

  const handleCreateDepartment = async () => {
    if (!createFormData.name || !createFormData.shortCode) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    await createDepartmentMutation.mutateAsync({
      ...createFormData,
      maxMembers: createFormData.maxMembers ? Number(createFormData.maxMembers) : null,
    })

    // РЎР±СЂР°СЃС‹РІР°РµРј С„РѕСЂРјСѓ Рё Р·Р°РєСЂС‹РІР°РµРј РґРёР°Р»РѕРі
    setCreateFormData({
      name: "",
      shortCode: "",
      type: "LEO",
      description: "",
      color: "#3b82f6",
      icon: "рџЏў",
      maxMembers: null,
      permissions: [],
      leaderId: null,
    })
    setIsCreateDialogOpen(false)
  }

  const handleEditClick = (department: Department) => {
    setSelectedDepartment(department)
    setEditFormData({
      name: department.name,
      shortCode: department.shortCode,
      type: department.type,
      description: department.description || "",
      color: department.color || "#3b82f6",
      icon: department.icon || "рџЏў",
      maxMembers: department.maxMembers || null,
      permissions: department.permissions || [],
      isActive: department.isActive,
      leaderId: department.leader?.id || null,
      logoFile: null
    })
    setIsEditDialogOpen(true)
  }

  const handleUpdateDepartment = async () => {
    if (!selectedDepartment?.id || !editFormData.name || !editFormData.shortCode) {
      toast.error("Р—Р°РїРѕР»РЅРёС‚Рµ РѕР±СЏР·Р°С‚РµР»СЊРЅС‹Рµ РїРѕР»СЏ")
      return
    }

    const { logoFile, ...dataWithoutLogo } = editFormData

    await updateDepartmentMutation.mutateAsync({
      id: selectedDepartment.id,
      data: {
        ...dataWithoutLogo,
        maxMembers: editFormData.maxMembers ? Number(editFormData.maxMembers) : null,
      },
    })

    setIsEditDialogOpen(false)
    setSelectedDepartment(null)
  }

  const handleDeleteClick = (department: Department) => {
    setSelectedDepartment(department)
    setIsDeleteDialogOpen(true)
  }

  const handleDeleteDepartment = async () => {
    if (!selectedDepartment?.id) return

    await deleteDepartmentMutation.mutateAsync(selectedDepartment.id)
    setIsDeleteDialogOpen(false)
    setSelectedDepartment(null)
  }

  const handlePermissionToggle = (permission: string, isEdit: boolean = false) => {
    if (isEdit) {
      const newPermissions = editFormData.permissions?.includes(permission)
        ? editFormData.permissions.filter((p) => p !== permission)
        : [...(editFormData.permissions || []), permission]

      setEditFormData({ ...editFormData, permissions: newPermissions })
    } else {
      const newPermissions = createFormData.permissions.includes(permission)
        ? createFormData.permissions.filter((p) => p !== permission)
        : [...createFormData.permissions, permission]

      setCreateFormData({ ...createFormData, permissions: newPermissions })
    }
  }

  // РџРѕР»СѓС‡Р°РµРј РІС‹Р±СЂР°РЅРЅРѕРіРѕ Р»РёРґРµСЂР° РёР· СЃРїРёСЃРєР° РїРѕР»СЊР·РѕРІР°С‚РµР»РµР№
  const getSelectedLeader = () => {
    const leaderId = editFormData.leaderId
    if (!leaderId) return null
    return allUsers.find((user: any) => user.id === leaderId)
  }

  // Р¤РёР»СЊС‚СЂР°С†РёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ РїРѕ РїРѕРёСЃРєРѕРІРѕРјСѓ Р·Р°РїСЂРѕСЃСѓ
  const filteredDepartments = departments.filter(
    (dept: any) =>
      dept.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      dept.shortCode.toLowerCase().includes(searchQuery.toLowerCase()) ||
      dept.type.toLowerCase().includes(searchQuery.toLowerCase())
  )

  // Р¤РёР»СЊС‚СЂР°С†РёСЏ РїРѕР»СЊР·РѕРІР°С‚РµР»РµР№ РґР»СЏ РІС‹Р±РѕСЂР° Р»РёРґРµСЂР°
  const filteredUsers = allUsers.filter((user: any) => 
    user.username.toLowerCase().includes(leaderSearch.toLowerCase()) ||
    user.email.toLowerCase().includes(leaderSearch.toLowerCase())
  )

  if (isLoading) {
    return (
      <div className="container mx-auto py-10 px-4 flex items-center justify-center min-h-[60vh]">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Р—Р°РіСЂСѓР·РєР° РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="container mx-auto py-10 px-4">
        <Card className="border-destructive">
          <CardContent className="pt-6">
            <div className="text-center">
              <div className="text-destructive mb-2">
                <Settings size={48} className="mx-auto" />
              </div>
              <h3 className="text-lg font-semibold mb-2">РћС€РёР±РєР° Р·Р°РіСЂСѓР·РєРё</h3>
              <p className="text-muted-foreground mb-4">
                {error.message || "РќРµ СѓРґР°Р»РѕСЃСЊ Р·Р°РіСЂСѓР·РёС‚СЊ РґР°РЅРЅС‹Рµ РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ"}
              </p>
              <Button onClick={() => refetch()} variant="outline">
                РџРѕРІС‚РѕСЂРёС‚СЊ РїРѕРїС‹С‚РєСѓ
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  // Р¤СѓРЅРєС†РёСЏ РґР»СЏ Р±РµР·РѕРїР°СЃРЅРѕРіРѕ РїРѕР»СѓС‡РµРЅРёСЏ РєРѕР»РёС‡РµСЃС‚РІР° С‡Р»РµРЅРѕРІ
  const getMemberCount = (dept: Department) => dept?._count?.members || 0

  // РЎС‚Р°С‚РёСЃС‚РёРєР°
  const totalDepartments = departments.length
  const activeDepartments = departments.filter((d: any) => d.isActive).length
  const totalMembers = departments.reduce(
    (sum: number, dept: any) => sum + getMemberCount(dept),
    0
  )

  return (
    <div className="container mx-auto py-10 px-4">
      <div className="flex flex-col space-y-6">
        {/* Р—Р°РіРѕР»РѕРІРѕРє Рё РєРЅРѕРїРєР° СЃРѕР·РґР°РЅРёСЏ */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold">РЈРїСЂР°РІР»РµРЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°РјРё</h1>
            <p className="text-muted-foreground mt-2">
              РЎРѕР·РґР°РЅРёРµ, СЂРµРґР°РєС‚РёСЂРѕРІР°РЅРёРµ Рё СѓРїСЂР°РІР»РµРЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°РјРё
            </p>
          </div>

          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button className="flex items-center gap-2">
                <Plus size={20} />
                Р”РѕР±Р°РІРёС‚СЊ РґРµРїР°СЂС‚Р°РјРµРЅС‚
              </Button>
            </DialogTrigger>
          <DialogContent className="max-w-3xl md:max-w-4xl lg:max-w-5xl max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle>РЎРѕР·РґР°С‚СЊ РЅРѕРІС‹Р№ РґРµРїР°СЂС‚Р°РјРµРЅС‚</DialogTitle>
              </DialogHeader>

              <div className="space-y-6 py-4">
            <div className="space-y-4">
              <h3 className="font-medium">РћСЃРЅРѕРІРЅР°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2 flex items-center gap-2">
                      <Label htmlFor="name">РќР°Р·РІР°РЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р° *</Label>
                      <Input
                        id="name"
                        placeholder="РќР°РїСЂРёРјРµСЂ: РџРѕР»РёС†РёСЏ"
                        value={createFormData.name}
                        onChange={(e) =>
                          setCreateFormData({ ...createFormData, name: e.target.value })
                        }
                        required
                        disabled={createDepartmentMutation.isPending}
                      />
                      {createFormData.logoFile && (
                        <span className="text-xs text-muted-foreground">Р¤Р°Р№Р»: {createFormData.logoFile.name}</span>
                      )}
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="shortCode">РљРѕСЂРѕС‚РєРёР№ РєРѕРґ *</Label>
                      <Input
                        id="shortCode"
                        placeholder="LSPD"
                        value={createFormData.shortCode}
                        onChange={(e) =>
                          setCreateFormData({ ...createFormData, shortCode: e.target.value })
                        }
                        maxLength={10}
                        disabled={createDepartmentMutation.isPending}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="logo">Р›РѕРіРѕС‚РёРї (РѕРїС†РёРѕРЅР°Р»СЊРЅРѕ)</Label>
                      <LogoDropzone onFile={(f) => setCreateFormData({ ...createFormData, logoFile: f })} />
                      {createFormData.logoFile && (
                        <span className="text-xs text-muted-foreground">Р¤Р°Р№Р»: {createFormData.logoFile.name}</span>
                      )}
                    </div>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label>РўРёРї РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                      <Select
                        value={createFormData.type}
                        onValueChange={(value) =>
                          setCreateFormData({ ...createFormData, type: value })
                        }
                        disabled={createDepartmentMutation.isPending}
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          {departmentTypes.map((type) => (
                            <SelectItem key={type.value} value={type.value}>
                              {type.label}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="maxMembers">РњР°РєСЃРёРјСѓРј СѓС‡Р°СЃС‚РЅРёРєРѕРІ</Label>
                      <Input
                        id="maxMembers"
                        type="number"
                        placeholder="50"
                        value={createFormData.maxMembers || ""}
                        onChange={(e) =>
                          setCreateFormData({
                            ...createFormData,
                            maxMembers: e.target.value ? Number(e.target.value) : null,
                          })
                        }
                        disabled={createDepartmentMutation.isPending}
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="color">Р¦РІРµС‚ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                      <div className="flex items-center gap-2">
                        <Input
                          id="color"
                          type="color"
                          value={createFormData.color}
                          onChange={(e) =>
                            setCreateFormData({ ...createFormData, color: e.target.value })
                          }
                          className="w-12 h-10 p-1"
                          disabled={createDepartmentMutation.isPending}
                        />
                        <Input
                          value={createFormData.color}
                          onChange={(e) =>
                            setCreateFormData({ ...createFormData, color: e.target.value })
                          }
                          disabled={createDepartmentMutation.isPending}
                        />
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="icon">РРєРѕРЅРєР° (СЌРјРѕРґР·Рё)</Label>
                      <Input
                        id="icon"
                        placeholder="рџЏў"
                        value={createFormData.icon}
                        onChange={(e) =>
                          setCreateFormData({ ...createFormData, icon: e.target.value })
                        }
                        maxLength={2}
                        disabled={createDepartmentMutation.isPending}
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="description">РћРїРёСЃР°РЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                    <Textarea
                      id="description"
                      placeholder="РћРїРёС€РёС‚Рµ С„СѓРЅРєС†РёРё Рё Р·Р°РґР°С‡Рё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°..."
                      rows={3}
                      value={createFormData.description}
                      onChange={(e) =>
                        setCreateFormData({ ...createFormData, description: e.target.value })
                      }
                      disabled={createDepartmentMutation.isPending}
                    />
                  </div>
                </div>

                <div className="space-y-4">
                  <h3 className="font-medium">Р Р°Р·СЂРµС€РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</h3>
                  <div className="grid grid-cols-2 gap-2">
                    {availablePermissions.map((permission) => (
                      <Button
                        key={permission}
                        type="button"
                        variant={
                          createFormData.permissions.includes(permission)
                            ? "default"
                            : "outline"
                        }
                        size="sm"
                        onClick={() => handlePermissionToggle(permission)}
                        disabled={createDepartmentMutation.isPending}
                      >
                        {permission}
                      </Button>
                    ))}
                  </div>
                </div>

                <div className="flex gap-3 justify-end pt-4 border-t">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => setIsCreateDialogOpen(false)}
                    disabled={createDepartmentMutation.isPending}
                  >
                    РћС‚РјРµРЅР°
                  </Button>
                  <Button
                    type="button"
                    onClick={handleCreateDepartment}
                    disabled={
                      !createFormData.name ||
                      !createFormData.shortCode ||
                      createDepartmentMutation.isPending
                    }
                  >
                    {createDepartmentMutation.isPending ? (
                      <>
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                        РЎРѕР·РґР°РЅРёРµ...
                      </>
                    ) : (
                      "РЎРѕР·РґР°С‚СЊ РґРµРїР°СЂС‚Р°РјРµРЅС‚"
                    )}
                  </Button>
                </div>
              </div>
          </DialogContent>
          </Dialog>
        </div>

        {/* РџРѕРёСЃРє */}
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground" size={20} />
            <Input
              placeholder="РџРѕРёСЃРє РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°..."
              className="pl-10"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
            {searchQuery && (
              <Button
                variant="ghost"
                size="sm"
                className="absolute right-2 top-1/2 transform -translate-y-1/2 h-6 w-6 p-0"
                onClick={() => setSearchQuery("")}
              >
                <Search size={16} />
              </Button>
            )}
          </div>
        </div>

        {/* РЎС‚Р°С‚РёСЃС‚РёРєР° */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground">Р’СЃРµРіРѕ РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ</p>
                  <p className="text-2xl font-bold mt-1">{totalDepartments}</p>
                </div>
                <Users size={24} className="text-muted-foreground" />
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground">РђРєС‚РёРІРЅС‹Рµ</p>
                  <p className="text-2xl font-bold mt-1">{activeDepartments}</p>
                </div>
                <Settings size={24} className="text-muted-foreground" />
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground">РЎРѕС‚СЂСѓРґРЅРёРєРѕРІ РІСЃРµРіРѕ</p>
                  <p className="text-2xl font-bold mt-1">{totalMembers}</p>
                </div>
                <Users size={24} className="text-muted-foreground" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* РўР°Р±Р»РёС†Р° РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ */}
        <Card>
          <CardHeader>
            <CardTitle>РЎРїРёСЃРѕРє РґРµРїР°СЂС‚Р°РјРµРЅС‚РѕРІ</CardTitle>
          </CardHeader>
          <CardContent>
            {filteredDepartments.length === 0 ? (
              <div className="text-center py-8">
                <Users size={48} className="mx-auto text-muted-foreground mb-4" />
                <h3 className="text-lg font-semibold mb-2">Р”РµРїР°СЂС‚Р°РјРµРЅС‚С‹ РЅРµ РЅР°Р№РґРµРЅС‹</h3>
                <p className="text-muted-foreground">
                  {searchQuery
                    ? "РџРѕРїСЂРѕР±СѓР№С‚Рµ РёР·РјРµРЅРёС‚СЊ РїРѕРёСЃРєРѕРІС‹Р№ Р·Р°РїСЂРѕСЃ"
                    : "РЎРѕР·РґР°Р№С‚Рµ РїРµСЂРІС‹Р№ РґРµРїР°СЂС‚Р°РјРµРЅС‚"}
                </p>
              </div>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="border-b">
                      <th className="text-left py-3 px-4">РќР°Р·РІР°РЅРёРµ</th>
                      <th className="text-left py-3 px-4">РўРёРї</th>
                      <th className="text-left py-3 px-4">Р СѓРєРѕРІРѕРґРёС‚РµР»СЊ</th>
                      <th className="text-left py-3 px-4">РЈС‡Р°СЃС‚РЅРёРєРѕРІ</th>
                      <th className="text-left py-3 px-4">РЎС‚Р°С‚СѓСЃ</th>
                      <th className="text-left py-3 px-4">Р”РµР№СЃС‚РІРёСЏ</th>
                    </tr>
                  </thead>
                  <tbody>
                   {filteredDepartments.map((dept: any) => (
                    <tr key={dept.id} className="border-b hover:bg-muted/50">
                      <td className="py-3 px-4">
                          <div className="flex items-center gap-2">
                            {dept.logoUrl ? (
                              <img 
                                src={getUploadUrl(dept.logoUrl) || ''} 
                                alt="Р»РѕРіРѕС‚РёРї" 
                                width={40} 
                                height={40} 
                                className="rounded object-cover border border-gray-200"
                              />
                            ) : (
                              <div 
                                className="rounded border-2 border-dashed border-gray-300 flex items-center justify-center"
                                style={{ width: 40, height: 40, backgroundColor: '#f9fafb' }}
                                title="РќРµС‚ Р»РѕРіРѕС‚РёРїР°"
                              >
                                <span className="text-gray-400 text-xs">РќРµС‚</span>
                              </div>
                            )}
                            <span
                              className="text-2xl"
                              style={{ color: dept.color }}
                            >
                              {dept.icon}
                            </span>
                            <div>
                              <div className="font-medium">{dept.name}</div>
                              <div className="text-sm text-muted-foreground">
                                {dept.shortCode}
                              </div>
                            </div>
                          </div>
                        </td>
                        <td className="py-3 px-4">
                          <Badge variant="outline">{dept.type}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex items-center gap-2">
                            {dept.leader ? (
                              <>
                                <Avatar className="h-6 w-6">
                                  <AvatarImage src={dept.leader.avatar} />
                                  <AvatarFallback>
                                    {dept.leader.username.charAt(0)}
                                  </AvatarFallback>
                                </Avatar>
                                <span>{dept.leader.username}</span>
                                <Crown size={12} className="text-amber-500" />
                              </>
                            ) : (
                              <span className="text-muted-foreground">РќРµ РЅР°Р·РЅР°С‡РµРЅ</span>
                            )}
                          </div>
                        </td>
                        <td className="py-3 px-4">{getMemberCount(dept)}</td>
                        <td className="py-3 px-4">
                          <Badge
                            variant={dept.isActive ? "default" : "secondary"}
                          >
                            {dept.isActive ? "РђРєС‚РёРІРµРЅ" : "РќРµР°РєС‚РёРІРµРЅ"}
                          </Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex gap-2">
                            <Button 
                              size="sm" 
                              variant="outline"
                              onClick={() => router.push(`/admin/departments/${dept.id}/edit`)}
                              title="Р”РµС‚Р°Р»СЊРЅРѕРµ СЂРµРґР°РєС‚РёСЂРѕРІР°РЅРёРµ"
                            >
                              <Building2 size={16} />
                            </Button>
                            <Button 
                              size="sm" 
                              variant="outline"
                              onClick={() => handleEditClick(dept)}
                            >
                              <Edit size={16} />
                            </Button>
                            <Button
                              size="sm"
                              variant="outline"
                              onClick={() => handleDeleteClick(dept)}
                            >
                              <Trash2 size={16} />
                            </Button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* РњРѕРґР°Р»РєР° СЂРµРґР°РєС‚РёСЂРѕРІР°РЅРёСЏ */}
        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-5xl md:max-w-6xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Р РµРґР°РєС‚РёСЂРѕРІР°С‚СЊ РґРµРїР°СЂС‚Р°РјРµРЅС‚</DialogTitle>
          </DialogHeader>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 py-4">
            {/* Р›РѕРіРѕС‚РёРї СЂРµРґР°РєС‚РёСЂРѕРІР°РЅРёРµ */}
            <div className="lg:col-span-2 space-y-4">
              <div className="space-y-2">
                <Label>Р›РѕРіРѕС‚РёРї РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                <LogoDropzone onFile={(f) => setEditFormData({ ...editFormData, logoFile: f })} />
                {editFormData.logoFile && (
                  <span className="text-xs text-muted-foreground">Р¤Р°Р№Р»: {editFormData.logoFile.name}</span>
                )}
                {selectedDepartment?.logoUrl ? (
                  <img 
                    src={getUploadUrl(selectedDepartment.logoUrl) || ''} 
                    alt="С‚РµРєСѓС‰РёР№ Р»РѕРіРѕС‚РёРї" 
                    className="h-16 w-16 object-cover rounded-lg border-2 border-gray-200 mt-2"
                  />
                ) : (
                  <div className="h-16 w-16 rounded-lg border-2 border-dashed border-gray-300 flex items-center justify-center mt-2 bg-gray-50">
                    <span className="text-gray-400 text-xs">РќРµС‚ Р»РѕРіРѕС‚РёРїР°</span>
                  </div>
                )}
              </div>
            </div>
            {/* Р›РµРІР°СЏ РєРѕР»РѕРЅРєР° - РћСЃРЅРѕРІРЅР°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ */}
            <div className="lg:col-span-2 space-y-6">
              <div className="space-y-4">
                <h3 className="font-medium">РћСЃРЅРѕРІРЅР°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="edit-name">РќР°Р·РІР°РЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р° *</Label>
                    <Input
                      id="edit-name"
                      placeholder="РќР°РїСЂРёРјРµСЂ: РџРѕР»РёС†РёСЏ"
                      value={editFormData.name}
                      onChange={(e) =>
                        setEditFormData({ ...editFormData, name: e.target.value })
                      }
                      required
                      disabled={updateDepartmentMutation.isPending}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="edit-shortCode">РљРѕСЂРѕС‚РєРёР№ РєРѕРґ *</Label>
                    <Input
                      id="edit-shortCode"
                      placeholder="LSPD"
                      value={editFormData.shortCode}
                      onChange={(e) =>
                        setEditFormData({ ...editFormData, shortCode: e.target.value })
                      }
                      maxLength={10}
                      disabled={updateDepartmentMutation.isPending}
                    />
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>РўРёРї РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                    <Select
                      value={editFormData.type}
                      onValueChange={(value) =>
                        setEditFormData({ ...editFormData, type: value })
                      }
                      disabled={updateDepartmentMutation.isPending}
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        {departmentTypes.map((type) => (
                          <SelectItem key={type.value} value={type.value}>
                            {type.label}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="edit-maxMembers">РњР°РєСЃРёРјСѓРј СѓС‡Р°СЃС‚РЅРёРєРѕРІ</Label>
                    <Input
                      id="edit-maxMembers"
                      type="number"
                      placeholder="50"
                      value={editFormData.maxMembers || ""}
                      onChange={(e) =>
                        setEditFormData({
                          ...editFormData,
                          maxMembers: e.target.value ? Number(e.target.value) : null,
                        })
                      }
                      disabled={updateDepartmentMutation.isPending}
                    />
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="edit-color">Р¦РІРµС‚ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                    <div className="flex items-center gap-2">
                      <Input
                        id="edit-color"
                        type="color"
                        value={editFormData.color}
                        onChange={(e) =>
                          setEditFormData({ ...editFormData, color: e.target.value })
                        }
                        className="w-12 h-10 p-1"
                        disabled={updateDepartmentMutation.isPending}
                      />
                      <Input
                        value={editFormData.color}
                        onChange={(e) =>
                          setEditFormData({ ...editFormData, color: e.target.value })
                        }
                        disabled={updateDepartmentMutation.isPending}
                      />
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="edit-icon">РРєРѕРЅРєР° (СЌРјРѕРґР·Рё)</Label>
                    <Input
                      id="edit-icon"
                      placeholder="рџЏў"
                      value={editFormData.icon}
                      onChange={(e) =>
                        setEditFormData({ ...editFormData, icon: e.target.value })
                      }
                      maxLength={2}
                      disabled={updateDepartmentMutation.isPending}
                    />
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>РЎС‚Р°С‚СѓСЃ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                    <Select
                      value={editFormData.isActive ? "active" : "inactive"}
                      onValueChange={(value) =>
                        setEditFormData({ ...editFormData, isActive: value === "active" })
                      }
                      disabled={updateDepartmentMutation.isPending}
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="active">РђРєС‚РёРІРµРЅ</SelectItem>
                        <SelectItem value="inactive">РќРµР°РєС‚РёРІРµРЅ</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  
                  <div className="space-y-2">
                    <Label>РќР°Р·РЅР°С‡РёС‚СЊ Р»РёРґРµСЂР°</Label>
                    <Popover open={openLeaderSelect} onOpenChange={setOpenLeaderSelect}>
                      <PopoverTrigger asChild>
                        <Button
                          variant="outline"
                          role="combobox"
                          aria-expanded={openLeaderSelect}
                          className="w-full justify-between"
                          disabled={updateDepartmentMutation.isPending}
                        >
                          {getSelectedLeader() ? (
                            <div className="flex items-center gap-2">
                              <Avatar className="h-6 w-6">
                                <AvatarImage src={getSelectedLeader()?.avatar} />
                                <AvatarFallback>
                                  {getSelectedLeader()?.username?.charAt(0)}
                                </AvatarFallback>
                              </Avatar>
                              <span>{getSelectedLeader()?.username}</span>
                              <Crown size={12} className="text-amber-500 ml-auto" />
                            </div>
                          ) : (
                            <>
                              <span className="text-muted-foreground">Р’С‹Р±РµСЂРёС‚Рµ Р»РёРґРµСЂР°...</span>
                              <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                            </>
                          )}
                        </Button>
                      </PopoverTrigger>
                      <PopoverContent className="w-[400px] p-0">
                        <Command>
                          <CommandInput 
                            placeholder="РџРѕРёСЃРє РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ РїРѕ РЅРёРєРЅРµР№РјСѓ РёР»Рё email..."
                            value={leaderSearch}
                            onValueChange={setLeaderSearch}
                          />
                          <CommandList>
                            <CommandEmpty>РџРѕР»СЊР·РѕРІР°С‚РµР»СЊ РЅРµ РЅР°Р№РґРµРЅ</CommandEmpty>
                            <CommandGroup>
                              <ScrollArea className="h-[300px]">
                                {filteredUsers.map((user: any) => (
                                  <CommandItem
                                    key={user.id}
                                    value={user.id}
                                    onSelect={() => {
                                      setEditFormData({ 
                                        ...editFormData, 
                                        leaderId: user.id === editFormData.leaderId ? null : user.id 
                                      })
                                      setOpenLeaderSelect(false)
                                      setLeaderSearch("")
                                    }}
                                  >
                                    <div className="flex items-center gap-3 w-full">
                                      <Avatar className="h-8 w-8">
                                        <AvatarImage src={user.avatar} />
                                        <AvatarFallback>
                                          {user.username.charAt(0)}
                                        </AvatarFallback>
                                      </Avatar>
                                      <div className="flex flex-col">
                                        <span className="font-medium">{user.username}</span>
                                        <span className="text-xs text-muted-foreground">{user.email}</span>
                                      </div>
                                      <div className="ml-auto flex items-center gap-2">
                                        {user.rank && (
                                          <Badge variant="outline" className="text-xs">
                                            {user.rank}
                                          </Badge>
                                        )}
                                        {user.id === editFormData.leaderId ? (
                                          <Check className="h-4 w-4 text-green-500" />
                                        ) : null}
                                      </div>
                                    </div>
                                  </CommandItem>
                                ))}
                              </ScrollArea>
                            </CommandGroup>
                          </CommandList>
                        </Command>
                      </PopoverContent>
                    </Popover>
                    
                    {getSelectedLeader() && (
                      <div className="flex items-center justify-between mt-2 p-2 bg-muted rounded-md">
                        <div className="flex items-center gap-2">
                          <Avatar className="h-8 w-8">
                            <AvatarImage src={getSelectedLeader()?.avatar} />
                            <AvatarFallback>
                              {getSelectedLeader()?.username?.charAt(0)}
                            </AvatarFallback>
                          </Avatar>
                          <div>
                            <p className="font-medium">{getSelectedLeader()?.username}</p>
                            <p className="text-xs text-muted-foreground">{getSelectedLeader()?.email}</p>
                          </div>
                        </div>
                        <Button
                          type="button"
                          variant="ghost"
                          size="sm"
                          onClick={() => setEditFormData({ ...editFormData, leaderId: null })}
                        >
                          <X size={16} />
                        </Button>
                      </div>
                    )}
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="edit-description">РћРїРёСЃР°РЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</Label>
                  <Textarea
                    id="edit-description"
                    placeholder="РћРїРёС€РёС‚Рµ С„СѓРЅРєС†РёРё Рё Р·Р°РґР°С‡Рё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°..."
                    rows={3}
                    value={editFormData.description}
                    onChange={(e) =>
                      setEditFormData({ ...editFormData, description: e.target.value })
                    }
                    disabled={updateDepartmentMutation.isPending}
                  />
                </div>
              </div>

              <div className="space-y-4">
                <h3 className="font-medium">Р Р°Р·СЂРµС€РµРЅРёСЏ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</h3>
                <div className="grid grid-cols-2 gap-2">
                  {availablePermissions.map((permission) => (
                    <Button
                      key={permission}
                      type="button"
                      variant={
                        editFormData.permissions?.includes(permission)
                          ? "default"
                          : "outline"
                      }
                      size="sm"
                      onClick={() => handlePermissionToggle(permission, true)}
                      disabled={updateDepartmentMutation.isPending}
                    >
                      {permission}
                    </Button>
                  ))}
                </div>
              </div>
            </div>

            {/* РџСЂР°РІР°СЏ РєРѕР»РѕРЅРєР° - РЈС‡Р°СЃС‚РЅРёРєРё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р° */}
            <div className="lg:col-span-1">
              <div className="space-y-4">
                <h3 className="font-medium">РЈС‡Р°СЃС‚РЅРёРєРё РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</h3>
                <Card>
                  <CardContent className="pt-6">
                    <div className="space-y-4">
                      <div className="flex items-center justify-between">
                        <div>
                          <p className="text-sm text-muted-foreground">Р’СЃРµРіРѕ СѓС‡Р°СЃС‚РЅРёРєРѕРІ</p>
                          <p className="text-2xl font-bold mt-1">
                            {selectedDepartment?._count?.members || 0}
                          </p>
                        </div>
                        <Users size={24} className="text-muted-foreground" />
                      </div>
                      
                      {selectedDepartment?.members && selectedDepartment.members.length > 0 ? (
                        <ScrollArea className="h-[300px]">
                          <div className="space-y-2">
                            {selectedDepartment.members.map((member) => (
                              <div
                                key={member.id}
                                className={cn(
                                  "flex items-center justify-between p-3 rounded-lg border",
                                  member.id === selectedDepartment.leader?.id 
                                    ? "bg-amber-50 border-amber-200" 
                                    : "bg-card"
                                )}
                              >
                                <div className="flex items-center gap-3">
                                  <Avatar className="h-8 w-8">
                                    <AvatarImage src={member.avatar} />
                                    <AvatarFallback>
                                      {member.username.charAt(0)}
                                    </AvatarFallback>
                                  </Avatar>
                                  <div className="flex flex-col">
                                    <div className="flex items-center gap-1">
                                      <span className="font-medium">{member.username}</span>
                                      {member.id === selectedDepartment.leader?.id && (
                                        <Crown size={12} className="text-amber-500" />
                                      )}
                                    </div>
                                    <span className="text-xs text-muted-foreground">{member.email}</span>
                                  </div>
                                </div>
                                <div className="flex flex-col items-end">
                                  {member.rank && (
                                    <Badge variant="outline" className="text-xs mb-1">
                                      {member.rank}
                                    </Badge>
                                  )}
                                  <Badge
                                    variant={member.isActive ? "default" : "secondary"}
                                    className="text-xs"
                                  >
                                    {member.isActive ? "РђРєС‚РёРІРµРЅ" : "РќРµР°РєС‚РёРІРµРЅ"}
                                  </Badge>
                                </div>
                              </div>
                            ))}
                          </div>
                        </ScrollArea>
                      ) : (
                        <div className="text-center py-8">
                          <Users size={32} className="mx-auto text-muted-foreground mb-2" />
                          <p className="text-sm text-muted-foreground">РќРµС‚ СѓС‡Р°СЃС‚РЅРёРєРѕРІ РІ РґРµРїР°СЂС‚Р°РјРµРЅС‚Рµ</p>
                        </div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              </div>
            </div>
          </div>

          <div className="flex gap-3 justify-end pt-4 border-t">
            <Button
              type="button"
              variant="outline"
              onClick={() => setIsEditDialogOpen(false)}
              disabled={updateDepartmentMutation.isPending}
            >
              РћС‚РјРµРЅР°
            </Button>
            <Button
              type="button"
              onClick={handleUpdateDepartment}
              disabled={
                !editFormData.name ||
                !editFormData.shortCode ||
                updateDepartmentMutation.isPending
              }
            >
              {updateDepartmentMutation.isPending ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                  РЎРѕС…СЂР°РЅРµРЅРёРµ...
                </>
              ) : (
                "РЎРѕС…СЂР°РЅРёС‚СЊ РёР·РјРµРЅРµРЅРёСЏ"
              )}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      {/* РњРѕРґР°Р»РєР° СѓРґР°Р»РµРЅРёСЏ */}
      <Dialog open={isDeleteDialogOpen} onOpenChange={setIsDeleteDialogOpen}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>РЈРґР°Р»РµРЅРёРµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°</DialogTitle>
            <DialogDescription>
              Р’С‹ СѓРІРµСЂРµРЅС‹, С‡С‚Рѕ С…РѕС‚РёС‚Рµ СѓРґР°Р»РёС‚СЊ РґРµРїР°СЂС‚Р°РјРµРЅС‚ "{selectedDepartment?.name}"? 
              Р­С‚Рѕ РґРµР№СЃС‚РІРёРµ РЅРµР»СЊР·СЏ РѕС‚РјРµРЅРёС‚СЊ.
            </DialogDescription>
          </DialogHeader>

          <div className="py-4">
            <div className="bg-muted p-4 rounded-lg mb-4">
              <div className="flex items-center gap-3 mb-2">
                <span
                  className="text-2xl"
                  style={{ color: selectedDepartment?.color }}
                >
                  {selectedDepartment?.icon}
                </span>
                <div>
                  <div className="font-medium">{selectedDepartment?.name}</div>
                  <div className="text-sm text-muted-foreground">
                    {selectedDepartment?.shortCode} вЂў {selectedDepartment?.type}
                  </div>
                </div>
              </div>
              <div className="text-sm">
                <p><strong>РЈС‡Р°СЃС‚РЅРёРєРѕРІ:</strong> {selectedDepartment?._count?.members || 0}</p>
                <p><strong>Р СѓРєРѕРІРѕРґРёС‚РµР»СЊ:</strong> {selectedDepartment?.leader?.username || "РќРµ РЅР°Р·РЅР°С‡РµРЅ"}</p>
              </div>
            </div>

            <div className="text-sm text-muted-foreground">
              <p className="font-medium text-destructive mb-1">Р’РЅРёРјР°РЅРёРµ!</p>
              <p>Р’СЃРµ РґР°РЅРЅС‹Рµ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р° Р±СѓРґСѓС‚ СѓРґР°Р»РµРЅС‹, РІРєР»СЋС‡Р°СЏ:</p>
              <ul className="list-disc pl-5 mt-1 space-y-1">
                <li>РРЅС„РѕСЂРјР°С†РёСЋ Рѕ РґРµРїР°СЂС‚Р°РјРµРЅС‚Рµ</li>
                <li>РќР°СЃС‚СЂРѕР№РєРё Рё СЂР°Р·СЂРµС€РµРЅРёСЏ</li>
                <li>РЎРІСЏР·Рё СЃ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏРјРё (СѓС‡Р°СЃС‚РЅРёРєРё Р±СѓРґСѓС‚ СѓРґР°Р»РµРЅС‹ РёР· РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°)</li>
              </ul>
            </div>
          </div>

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => setIsDeleteDialogOpen(false)}
              disabled={deleteDepartmentMutation.isPending}
            >
              РћС‚РјРµРЅР°
            </Button>
            <Button
              type="button"
              variant="destructive"
              onClick={handleDeleteDepartment}
              disabled={deleteDepartmentMutation.isPending}
            >
              {deleteDepartmentMutation.isPending ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                  РЈРґР°Р»РµРЅРёРµ...
                </>
              ) : (
                "РЈРґР°Р»РёС‚СЊ РґРµРїР°СЂС‚Р°РјРµРЅС‚"
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}





