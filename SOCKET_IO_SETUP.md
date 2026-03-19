# Socket.IO Application

Чистое приложение с Socket.IO подключением.

## Запуск

### Backend:
```bash
cd backend
npm run start:dev
```

### Frontend:
```bash
cd frontend
npm run dev
```

## Структура

### Backend:
- Realtime система для обработки запросов через Socket.IO
- Декораторы для автоматической регистрации endpoints
- WebSocket Gateway для обработки соединений

### Frontend:
- Автоматическое подключение к Socket.IO серверу
- Простой сервис для работы с сокетами
- Минимальный интерфейс с индикатором подключения

## Использование

Frontend готов для добавления любой функциональности через Socket.IO:

```typescript
import { socketService } from '@/lib/socket-service';

// Отправка события
socketService.emit('my-event', { data: 'hello' });

// Подписка на события
socketService.on('server-event', (data) => {
  console.log('Received:', data);
});
```

Backend готов для добавления новых endpoints:

```typescript
@Injectable()
@RealtimeController()
export class MyController {
  @RealtimeEndpoint('GET', '/my-data')
  async getData() {
    return { message: 'Hello from realtime endpoint' };
  }
}
```