'use client';

import { useEffect, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import {
    Users,
    Search,
    MoreHorizontal,
    Shield,
    ShieldAlert,
    Clock,
    Mail,
    Filter,
    Pencil,
    Building,
    Plus,
    Save,
    X,
    Check,
    UserPlus,
    UserMinus
} from 'lucide-react';
import { CardDescription, CardFooter } from '@/components/ui/card';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger
} from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';
import { useUserManagement } from '@/hooks/useUserManagement';
import { User } from '@/hooks/getUseMangr';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import {
    Dialog,
    DialogClose,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog"
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { toast } from 'sonner';
import axios from 'axios';
import { ScrollArea } from '@/components/ui/scroll-area';
import api from '@/lib/api/axios';

interface Department {
    id: string;
    name: string;
    shortCode: string;
    color?: string;
    icon?: string;
}

// Хук для получения департаментов
const useDepartments = () => {
    return useQuery({
        queryKey: ["departments"],
        queryFn: async () => {
            const { data } = await api.get("/departments");
            if (!data.success) {
                throw new Error(data.error || "Ошибка загрузки департаментов");
            }
            return data.departments || [];
        },
        staleTime: 5 * 60 * 1000,
    });
};

// Хук для назначения департамента пользователю
const useAssignDepartment = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async ({ userId, departmentId }: { userId: string; departmentId: string }) => {
            const { data } = await api.put(`/admin/users/${userId}/department`, { departmentId });
            if (!data.success) {
                throw new Error(data.error || "Ошибка назначения департамента");
            }
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["users"] });
            toast.success("Департамент успешно назначен");
        },
        onError: (error: any) => {
            const errorMessage = error.response?.data?.error || error.message || "Ошибка назначения департамента";
            toast.error(errorMessage);
        },
    });
};

// Хук для удаления пользователя из департамента
const useRemoveFromDepartment = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async ({ userId, departmentId }: { userId: string; departmentId: string }) => {
            const { data } = await api.delete(`/admin/users/${userId}/department/${departmentId}`);
            if (!data.success) {
                throw new Error(data.error || "Ошибка удаления из департамента");
            }
            return data;
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["users"] });
            toast.success("Пользователь удален из департамента");
        },
        onError: (error: any) => {
            const errorMessage = error.response?.data?.error || error.message || "Ошибка удаления из департамента";
            toast.error(errorMessage);
        },
    });
};

export default function UserManagementPage() {
    const { user } = useAuth();
    const { getUsers, loading, assignRoles, banUser, unbanUser } = useUserManagement();
    
    // Функция проверки роли
    const hasRole = (role: string): boolean => {
        if (!user?.roles) return false;
        const userRoles = Array.isArray(user.roles) ? user.roles : [user.roles];
        return userRoles.includes(role);
    };
    const [users, setUsers] = useState<User[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedUser, setSelectedUser] = useState<User | null>(null);
    const [selectedDepartment, setSelectedDepartment] = useState<string>('');
    const [isAddDepartmentOpen, setIsAddDepartmentOpen] = useState(false);
    const [isEditRolesOpen, setIsEditRolesOpen] = useState(false);
    const [newRole, setNewRole] = useState<string>('');

    // Используем TanStack Query для департаментов
    const { data: departments = [] } = useDepartments();
    const assignDepartmentMutation = useAssignDepartment();
    const removeFromDepartmentMutation = useRemoveFromDepartment();

    useEffect(() => {
        const fetchUsers = async () => {
            const data = await getUsers();
            setUsers(data);
        };
        fetchUsers();
    }, [getUsers]);

    const filteredUsers = users.filter(user =>
        user.username.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.email?.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const handleRoleChange = async (userId: string, currentroles: string[]) => {
        const isAdmin = currentroles?.includes('ADMIN');
        const newroles = isAdmin ? ['USER'] : ['ADMIN'];
        await assignRoles(userId, newroles);
        // Refresh list
        const data = await getUsers();
        setUsers(data);
    };

    const handleBanToggle = async (userId: string, isBanned: boolean) => {
        if (isBanned) {
            await unbanUser(userId);
        } else {
            await banUser(userId, 'Нарушение правил системы');
        }
        // Refresh list
        const data = await getUsers();
        setUsers(data);
    };

    const handleAssignDepartment = async (userId: string) => {
        if (!selectedDepartment) {
            toast.error("Выберите департамент");
            return;
        }

        await assignDepartmentMutation.mutateAsync({ userId, departmentId: selectedDepartment });
        
        // Refresh users
        const data = await getUsers();
        setUsers(data);
        setSelectedDepartment('');
        setIsAddDepartmentOpen(false);
    };

    const handleRemoveFromDepartment = async (userId: string, departmentId: string) => {
        await removeFromDepartmentMutation.mutateAsync({ userId, departmentId });
        
        // Refresh users
        const data = await getUsers();
        setUsers(data);
    };

    const handleEditRoles = (user: User) => {
        setSelectedUser(user);
        setNewRole(user.roles?.[0] || 'USER');
        setIsEditRolesOpen(true);
    };

    const handleSaveRoles = async () => {
        if (!selectedUser) return;

        await assignRoles(selectedUser.id, [newRole]);
        
        // Refresh list
        const data = await getUsers();
        setUsers(data);
        setIsEditRolesOpen(false);
        setSelectedUser(null);
        toast.success("Роль успешно обновлена");
    };

    // Проверяем права доступа
    if (!hasRole('ADMIN')) {
        return (
            <div className="container mx-auto py-10 px-4">
                <div className="flex flex-col items-center justify-center min-h-[400px] space-y-4">
                    <div className="text-6xl">🚫</div>
                    <h1 className="text-2xl font-bold">Доступ запрещен</h1>
                    <p className="text-muted-foreground text-center max-w-md">
                        У вас нет прав для доступа к управлению пользователями. Требуются права администратора.
                    </p>
                    <div className="text-sm text-muted-foreground">
                        <span className="text-muted-foreground">Ваши роли: </span>
                        <span className="font-mono bg-primary/10 text-primary px-2 py-1 rounded">
                            {Array.isArray(user?.roles) ? user.roles.join(', ') : user?.roles || 'Нет ролей'}
                        </span>
                    </div>
                    <div className="text-sm">
                        <span className="text-muted-foreground">Доступ к управлению пользователями: </span>
                        <span className="font-bold text-red-600">
                            ❌ Запрещен
                        </span>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="container mx-auto py-10 px-4">
            <div className="flex flex-col space-y-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-3xl font-bold tracking-tight">Управление пользователями</h1>
                        <p className="text-muted-foreground mt-1">
                            Просмотр и редактирование прав доступа всех пользователей системы.
                        </p>
                    </div>
                </div>
                <Card>
                    <CardHeader className="pb-3">
                        <div className="flex items-center justify-between">
                            <CardTitle>Список пользователей</CardTitle>
                            <div className="flex items-center space-x-2">
                                <div className="relative">
                                    <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                                    <Input
                                        placeholder="Поиск по имени или email..."
                                        className="pl-8 w-[250px]"
                                        value={searchTerm}
                                        onChange={(e) => setSearchTerm(e.target.value)}
                                    />
                                </div>
                                <Button variant="outline" size="icon">
                                    <Filter className="h-4 w-4" />
                                </Button>
                            </div>
                        </div>
                    </CardHeader>
                    <CardContent>
                        <div className="rounded-md border">
                            <table className="w-full text-sm">
                                <thead className="bg-muted/50 text-muted-foreground font-medium border-b">
                                    <tr>
                                        <th className="p-4 text-left">Пользователь</th>
                                        <th className="p-4 text-left">Статус</th>
                                        <th className="p-4 text-left">Роль</th>
                                        <th className="p-4 text-left">Департамент</th>
                                        <th className="p-4 text-left">Последний вход</th>
                                        <th className="p-4 text-right">Действия</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {loading && users.length === 0 ? (
                                        <tr>
                                            <td colSpan={6} className="p-8 text-center text-muted-foreground">
                                                Загрузка пользователей...
                                            </td>
                                        </tr>
                                    ) : filteredUsers.length === 0 ? (
                                        <tr>
                                            <td colSpan={6} className="p-8 text-center text-muted-foreground">
                                                Пользователи не найдены
                                            </td>
                                        </tr>
                                    ) : (
                                        filteredUsers.map((user) => (
                                            <tr key={user.id} className="border-b hover:bg-muted/30 transition-colors">
                                                <td className="p-4">
                                                    <div className="flex items-center space-x-3">
                                                        <Avatar className="h-9 w-9">
                                                            <AvatarImage src={user.avatarUrl} />
                                                            <AvatarFallback>{user.username.substring(0, 2).toUpperCase()}</AvatarFallback>
                                                        </Avatar>
                                                        <div>
                                                            <div className="font-medium">{user.username}</div>
                                                            <div className="text-xs text-muted-foreground flex items-center">
                                                                <Mail className="h-3 w-3 mr-1" />
                                                                {user.email || 'Нет почты'}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td className="p-4">
                                                    {user.isBanned ? (
                                                        <Badge variant="destructive" className="text-xs">
                                                            Забанен
                                                        </Badge>
                                                    ) : (
                                                        <Badge variant="default" className="bg-green-500 text-white text-xs">
                                                            Активен
                                                        </Badge>
                                                    )}
                                                </td>
                                                <td className="p-4">
                                                    <div className="flex items-center capitalize">
                                                        {user.roles?.includes('ADMIN') ? (
                                                            <Shield className="h-3 w-3 mr-1 text-primary" />
                                                        ) : user.roles?.includes('MODERATOR') ? (
                                                            <ShieldAlert className="h-3 w-3 mr-1 text-orange-500" />
                                                        ) : (
                                                            <Users className="h-3 w-3 mr-1 text-muted-foreground" />
                                                        )}
                                                        {user.roles}
                                                    </div>
                                                </td>
                                                <td className="p-4">
                                                    {user.department ? (
                                                        <div className="flex items-center gap-2">
                                                            <div 
                                                                className="w-3 h-3 rounded-full" 
                                                                style={{ backgroundColor: user.department.color || '#3b82f6' }}
                                                            />
                                                            <span className="text-sm">{user.department.name}</span>
                                                            <Badge variant="outline" className="text-xs">
                                                                {user.department.shortCode}
                                                            </Badge>
                                                        </div>
                                                    ) : (
                                                        <span className="text-sm text-muted-foreground">Не назначен</span>
                                                    )}
                                                </td>
                                                <td className="p-4 text-muted-foreground">
                                                    <div className="flex items-center">
                                                        <Clock className="h-3 w-3 mr-1" />
                                                        {user.lastLogin ? new Date(user.lastLogin).toLocaleDateString() : 'Никогда'}
                                                    </div>
                                                </td>
                                                <td className="p-4 text-right">
                                                    <DropdownMenu>
                                                        <DropdownMenuTrigger asChild>
                                                            <Button variant="ghost" className="h-8 w-8 p-0">
                                                                <MoreHorizontal className="h-4 w-4" />
                                                            </Button>
                                                        </DropdownMenuTrigger>
                                                        <DropdownMenuContent align="end" className="w-56">
                                                            <DropdownMenuLabel>Действия с {user.username}</DropdownMenuLabel>
                                                            <DropdownMenuItem onClick={() => handleEditRoles(user)}>
                                                                <Pencil className="mr-2 h-4 w-4" />
                                                                Редактировать роли
                                                            </DropdownMenuItem>
                                                            <DropdownMenuItem onClick={() => {
                                                                setSelectedUser(user);
                                                                setIsAddDepartmentOpen(true);
                                                            }}>
                                                                <UserPlus className="mr-2 h-4 w-4" />
                                                                Назначить департамент
                                                            </DropdownMenuItem>
                                                            {user.department && (
                                                                <DropdownMenuItem 
                                                                    className="text-destructive"
                                                                    onClick={() => handleRemoveFromDepartment(user.id, user.department!.id)}
                                                                >
                                                                    <UserMinus className="mr-2 h-4 w-4" />
                                                                    Удалить из департамента
                                                                </DropdownMenuItem>
                                                            )}
                                                            <DropdownMenuItem onClick={() => handleRoleChange(user.id, user.roles)}>
                                                                <Shield className="mr-2 h-4 w-4" />
                                                                {user.roles?.includes('ADMIN') ? 'Снять админку' : 'Сделать админом'}
                                                            </DropdownMenuItem>
                                                            <DropdownMenuItem 
                                                                className="text-destructive" 
                                                                onClick={() => handleBanToggle(user.id, user.isBanned)}
                                                            >
                                                                <ShieldAlert className="mr-2 h-4 w-4" />
                                                                {user.isBanned ? 'Разбанить' : 'Забанить'}
                                                            </DropdownMenuItem>
                                                            <DropdownMenuSeparator />
                                                            <DropdownMenuItem>Детали профиля</DropdownMenuItem>
                                                        </DropdownMenuContent>
                                                    </DropdownMenu>
                                                </td>
                                            </tr>
                                        ))
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </CardContent>
                </Card>
            </div>

            {/* Диалог назначения департамента */}
            <Dialog open={isAddDepartmentOpen} onOpenChange={setIsAddDepartmentOpen}>
                <DialogContent className="sm:max-w-[500px]">
                    <DialogHeader>
                        <DialogTitle className="text-xl flex items-center gap-2">
                            <Building className="h-5 w-5" />
                            Назначить департамент
                        </DialogTitle>
                        <DialogDescription>
                            Выберите департамент для пользователя {selectedUser?.username}
                        </DialogDescription>
                    </DialogHeader>

                    <div className="space-y-4 py-4">
                        <div className="space-y-2">
                            <Label htmlFor="department">Департамент</Label>
                            <Select value={selectedDepartment} onValueChange={setSelectedDepartment}>
                                <SelectTrigger>
                                    <SelectValue placeholder="Выберите департамент" />
                                </SelectTrigger>
                                <SelectContent>
                                    <ScrollArea className="h-[200px]">
                                        {departments.map((dept: Department) => (
                                            <SelectItem key={dept.id} value={dept.id}>
                                                <div className="flex items-center gap-2">
                                                    <div 
                                                        className="w-3 h-3 rounded-full" 
                                                        style={{ backgroundColor: dept.color || '#3b82f6' }}
                                                    />
                                                    <span>{dept.name}</span>
                                                    <Badge variant="outline" className="ml-auto text-xs">
                                                        {dept.shortCode}
                                                    </Badge>
                                                </div>
                                            </SelectItem>
                                        ))}
                                    </ScrollArea>
                                </SelectContent>
                            </Select>
                        </div>

                        {selectedDepartment && (
                            <Card className="border">
                                <CardContent className="pt-4">
                                    <div className="flex items-center gap-3">
                                        {departments.find((d: any) => d.id === selectedDepartment)?.icon && (
                                            <span className="text-2xl">
                                                {departments.find((d: any) => d.id === selectedDepartment)?.icon}
                                            </span>
                                        )}
                                        <div>
                                            <p className="font-medium">
                                                {departments.find((d: any) => d.id === selectedDepartment)?.name}
                                            </p>
                                            <p className="text-sm text-muted-foreground">
                                                Код: {departments.find((d: any) => d.id === selectedDepartment)?.shortCode}
                                            </p>
                                        </div>
                                    </div>
                                </CardContent>
                            </Card>
                        )}
                    </div>

                    <DialogFooter>
                        <DialogClose asChild>
                            <Button variant="outline">Отмена</Button>
                        </DialogClose>
                        <Button 
                            onClick={() => selectedUser && handleAssignDepartment(selectedUser.id)}
                            disabled={!selectedDepartment || assignDepartmentMutation.isPending}
                        >
                            {assignDepartmentMutation.isPending ? (
                                <>
                                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                                    Назначение...
                                </>
                            ) : (
                                "Назначить"
                            )}
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>

            {/* Диалог редактирования ролей */}
            <Dialog open={isEditRolesOpen} onOpenChange={setIsEditRolesOpen}>
                <DialogContent className="sm:max-w-[600px]">
                    <DialogHeader>
                        <DialogTitle className="text-xl flex items-center gap-2">
                            <Users className="h-5 w-5" />
                            Редактирование ролей: {selectedUser?.username}
                        </DialogTitle>
                        <DialogDescription className="text-base">
                            Управление правами и доступом пользователя
                        </DialogDescription>
                    </DialogHeader>

                    <div className="space-y-6 py-4">
                        {/* Информация о ранге пользователя */}
                        <Card className="border-2">
                            <CardHeader className="pb-3">
                                <div className="flex items-center justify-between">
                                    <CardTitle className="text-lg flex items-center gap-2">
                                        <Shield className="h-5 w-5 text-primary" />
                                        Текущий ранг
                                    </CardTitle>
                                    <Badge
                                        variant={selectedUser?.roles?.includes('ADMIN') ? 'destructive' :
                                            selectedUser?.roles?.includes('MODERATOR') ? 'default' : 'secondary'}
                                        className="text-sm px-3 py-1"
                                    >
                                        {selectedUser?.roles?.[0] || 'USER'}
                                    </Badge>
                                </div>
                                <CardDescription>
                                    {selectedUser?.roles?.includes('ADMIN')
                                        ? 'Полный доступ ко всем функциям системы'
                                        : selectedUser?.roles?.includes('MODERATOR')
                                            ? 'Ограниченные права модератора'
                                            : 'Базовые права пользователя'}
                                </CardDescription>
                            </CardHeader>
                        </Card>

                        {/* Список департаментов */}
                        <Card className="border-2">
                            <CardHeader>
                                <CardTitle className="text-lg flex items-center gap-2">
                                    <Building className="h-5 w-5 text-primary" />
                                    Департаменты участника
                                </CardTitle>
                                <CardDescription>
                                    Департаменты, к которым принадлежит пользователь
                                </CardDescription>
                            </CardHeader>
                            <CardContent>
                                {selectedUser?.department ? (
                                    <div className="space-y-3">
                                        <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-accent/50 transition-colors">
                                            <div className="flex items-center gap-3">
                                                <div 
                                                    className="h-10 w-10 rounded-md flex items-center justify-center"
                                                    style={{ backgroundColor: `${selectedUser.department.color || '#3b82f6'}20` }}
                                                >
                                                    {selectedUser.department.icon && (
                                                        <span className="text-lg">{selectedUser.department.icon}</span>
                                                    )}
                                                </div>
                                                <div>
                                                    <p className="font-medium">{selectedUser.department.name}</p>
                                                    <p className="text-sm text-muted-foreground">
                                                        Код: {selectedUser.department.shortCode}
                                                    </p>
                                                </div>
                                            </div>
                                            <Button
                                                variant="outline"
                                                size="sm"
                                                onClick={() => handleRemoveFromDepartment(selectedUser.id, selectedUser.department!.id)}
                                            >
                                                <UserMinus className="h-4 w-4 mr-2" />
                                                Удалить
                                            </Button>
                                        </div>
                                    </div>
                                ) : (
                                    <div className="text-center py-8 space-y-3">
                                        <div className="h-12 w-12 rounded-full bg-muted flex items-center justify-center mx-auto">
                                            <Building className="h-6 w-6 text-muted-foreground" />
                                        </div>
                                        <p className="text-muted-foreground">Пользователь не состоит ни в одном департаменте</p>
                                        <Button 
                                            variant="outline" 
                                            size="sm"
                                            onClick={() => setIsAddDepartmentOpen(true)}
                                        >
                                            <Plus className="h-4 w-4 mr-2" />
                                            Добавить в департамент
                                        </Button>
                                    </div>
                                )}
                            </CardContent>
                        </Card>

                        {/* Изменение ранга */}
                        <Card className="border-2">
                            <CardHeader>
                                <CardTitle className="text-lg flex items-center gap-2">
                                    <ShieldAlert className="h-5 w-5 text-primary" />
                                    Изменить ранг
                                </CardTitle>
                                <CardDescription>
                                    Изменение ранга повлияет на уровень доступа пользователя
                                </CardDescription>
                            </CardHeader>
                            <CardContent>
                                <RadioGroup 
                                    value={newRole} 
                                    onValueChange={setNewRole}
                                    className="space-y-3"
                                >
                                    <div className="flex items-center space-x-2 rounded-lg border p-4 hover:bg-accent/50">
                                        <RadioGroupItem value="USER" id="user" />
                                        <label htmlFor="user" className="flex-1 cursor-pointer">
                                            <div className="flex items-center justify-between">
                                                <div>
                                                    <p className="font-medium">Пользователь</p>
                                                    <p className="text-sm text-muted-foreground">
                                                        Базовые права, доступ к общей информации
                                                    </p>
                                                </div>
                                                <Badge variant="secondary">Базовый</Badge>
                                            </div>
                                        </label>
                                    </div>

                                    <div className="flex items-center space-x-2 rounded-lg border p-4 hover:bg-accent/50">
                                        <RadioGroupItem value="MODERATOR" id="moderator" />
                                        <label htmlFor="moderator" className="flex-1 cursor-pointer">
                                            <div className="flex items-center justify-between">
                                                <div>
                                                    <p className="font-medium">Модератор</p>
                                                    <p className="text-sm text-muted-foreground">
                                                        Может управлять контентом и пользователями
                                                    </p>
                                                </div>
                                                <Badge variant="default">Продвинутый</Badge>
                                            </div>
                                        </label>
                                    </div>

                                    <div className="flex items-center space-x-2 rounded-lg border p-4 hover:bg-accent/50">
                                        <RadioGroupItem value="ADMIN" id="admin" />
                                        <label htmlFor="admin" className="flex-1 cursor-pointer">
                                            <div className="flex items-center justify-between">
                                                <div>
                                                    <p className="font-medium">Администратор</p>
                                                    <p className="text-sm text-muted-foreground">
                                                        Полный доступ ко всем функциям системы
                                                    </p>
                                                </div>
                                                <Badge variant="destructive">Максимальный</Badge>
                                            </div>
                                        </label>
                                    </div>
                                </RadioGroup>
                            </CardContent>
                        </Card>
                    </div>

                    <DialogFooter>
                        <DialogClose asChild>
                            <Button variant="outline">Отмена</Button>
                        </DialogClose>
                        <Button onClick={handleSaveRoles}>
                            <Save className="mr-2 h-4 w-4" />
                            Сохранить изменения
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </div>
    );
}