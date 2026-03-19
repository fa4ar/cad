"use client";

import { useRouter } from "next/navigation";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useUser } from "../hooks/getUseMangr";
import { Skeleton } from "@/components/ui/skeleton";
import { useState } from "react";

export function UserDepartmentSelect() {
  const router = useRouter();
  const { user, loading } = useUser();
  const [selectedValue, setSelectedValue] = useState("");

  // Обработчик изменения выбора
  const handleValueChange = (value: string) => {
    setSelectedValue(value);

    // Перенаправляем на страницу департамента в зависимости от типа
    if (value === "department") {
      const deptType = user?.department?.type;
      switch (deptType) {
        case "LEO":
          router.push("/police");
          break;
        case "FD":
          router.push("/fire");
          break;
        case "EMS":
          router.push("/fire");
          break;
        case "CIVIL":
          router.push("/pages/citizen");
          break;
        case "DISPATCH":
          router.push("/dispatch");
          break;
        default:
          if (user?.department?.id) {
            router.push(`/departments/${user.department.id}`);
          }
      }
    }
  };

  const isAdmin = Array.isArray(user?.roles) && user.roles.includes("ADMIN");

  if (loading) {
    return (
      <div className="w-full max-w-48">
        <Skeleton className="h-10 w-full" />
      </div>
    );
  }

  // Если нет пользователя
  if (!user) {
    return (
      <Select disabled>
        <SelectTrigger className="w-full max-w-48">
          <SelectValue placeholder="Нет данных" />
        </SelectTrigger>
      </Select>
    );
  }

  // Если у пользователя нет департамента и он не админ
  if (!user.department && !isAdmin) {
    return (
      <Select disabled>
        <SelectTrigger className="w-full max-w-48">
          <SelectValue placeholder="Нет департамента" />
        </SelectTrigger>
      </Select>
    );
  }

  const department = user.department;

  // Если ADMIN - показываем все департаменты
  if (isAdmin) {
    const handleAdminSelect = (value: string) => {
      switch (value) {
        case "leo":
          router.push("/police");
          break;
        case "detective":
          router.push("/police/detective");
          break;
        case "fd":
          router.push("/fire");
          break;
        case "ems":
          router.push("/fire");
          break;
        case "dispatch":
          router.push("/dispatch");
          break;
        case "citizen":
          router.push("/pages/citizen");
          break;
      }
    };

    return (
      <Select value={selectedValue} onValueChange={handleAdminSelect}>
        <SelectTrigger className="w-full max-w-48">
          <SelectValue placeholder="Департаменты">
            {!selectedValue ? (
              <span>{department ? department.name : "Все разделы"}</span>
            ) : (
              "Департаменты"
            )}
          </SelectValue>
        </SelectTrigger>
        <SelectContent>
          <SelectGroup>
            <SelectLabel>Департаменты</SelectLabel>
            <SelectItem value="leo">
              <div className="flex items-center gap-2">
                <span>Полиция</span>
              </div>
            </SelectItem>
            <SelectItem value="fd">
              <div className="flex items-center gap-2">
                <span>Пожарная</span>
              </div>
            </SelectItem>
            <SelectItem value="dispatch">
              <div className="flex items-center gap-2">
                <span>Диспетчер</span>
              </div>
            </SelectItem>
            <SelectItem value="citizen">
              <div className="flex items-center gap-2">
                <span>Гражданин</span>
              </div>
            </SelectItem>
          </SelectGroup>
        </SelectContent>
      </Select>
    );
  }

  return (
    <Select value={selectedValue} onValueChange={handleValueChange}>
      <SelectTrigger className="w-full max-w-48 ">
        <SelectValue placeholder="Департамент">
          {selectedValue === "department" || !selectedValue ? (
            <div className="flex items-center gap-2">
              <span className="font-medium">{department?.name || 'Нет'}</span>
            </div>
          ) : (
            "Департамент"
          )}
        </SelectValue>
      </SelectTrigger>
      <SelectContent>
        <SelectGroup>
          <SelectLabel>Ваш департамент</SelectLabel>
          <SelectItem value="department">
            <div className="flex items-center gap-2 cursor-pointer">
              {department?.color && (
                <div
                  className="w-3 h-3 rounded-full"
                  style={{ backgroundColor: department?.color }}
                />
              )}
              <div className="flex flex-col">
                <span className="font-medium">{department?.name || 'Нет'}</span>
                <span className="text-xs text-muted-foreground">
                  Перейти к департаменту →
                </span>
              </div>
            </div>
          </SelectItem>
        </SelectGroup>
      </SelectContent>
    </Select>
  );
}
