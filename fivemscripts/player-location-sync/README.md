# CAD Map Sync

Скрипт для FiveM - синхронизация местоположения игроков с CAD.

## Установка

1. Скопируйте папку `cad-map-sync` в директорию `resources` сервера

2. Добавьте в `server.cfg`:
```
start cad-map-sync
```

## Использование

Скрипт автоматически:
- Отслеживает позицию всех игроков
- Отправляет данные на сервер каждые 1 секунду
- Создает HTTP сервер на порту 30121

### REST API Endpoints

- `http://localhost:30121/health` - Проверка работы
- `http://localhost:30121/blips` - Список blips (JSON)
- `http://localhost:30121/players` - Список игроков с позициями (JSON)

## CAD Подключение

В CAD добавьте:
- Blips URL: `http://IP_СЕРВЕРА:30121/blips`

Скрипт работает через HTTP polling - CAD периодически запрашивает `/blips` и `/players`.
