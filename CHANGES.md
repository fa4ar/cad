# Изменения в структуре ролей и рангов

## Что изменилось:

### Backend (Prisma Schema):
1. **User модель**:
   - Убрано поле `rank` 
   - Убрано поле `departmentRank`
   - Поле `roles` теперь массив системных ролей: `["USER"]`, `["ADMIN"]`, `["MODERATOR"]`

2. **Character модель**:
   - Добавлено поле `departmentRank` (маппится в БД как `department_rank`) - ранг персонажа в департаменте (Officer, Sergeant, Lieutenant, Captain и т.д.)

3. **Officer модель**:
   - Поле `rank` переименовано в `officerRank` (маппится в БД как `officer_rank`) - ранг офицера

4. **Department модель**:
   - Убрано поле `minRank`

### Backend (Controllers & Utils):
1. **UserUtils**:
   - Метод `hasRole()` теперь работает с массивом ролей
   - Убрана логика проверки рангов департамента
   - Добавлен deprecated метод `hasroles()` для обратной совместимости

2. **UserController**:
   - Обновлены все методы для работы с массивом ролей
   - В профиле пользователя теперь возвращается `departmentRank` персонажей

3. **DepartmentController**:
   - Обновлены проверки прав доступа

### Frontend:
1. **auth.ts**:
   - Тип `User.roles` изменен с строки на массив строк
   - Метод `hasRole()` обновлен для работы с массивом ролей

## Логика:
- **Роли (roles)** - системные роли пользователя: USER, MODERATOR, ADMIN
- **Ранги персонажей (departmentRank)** - ранги персонажей в департаментах: Officer, Sergeant, Lieutenant, Captain и т.д.
- **Ранги офицеров (officerRank)** - ранги офицеров: Officer, Sergeant, Lieutenant, Captain и т.д.

## Миграция:
Выполните SQL из файла `backend/migration.sql` для обновления базы данных.