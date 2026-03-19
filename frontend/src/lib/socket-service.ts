import { socket } from '@/app/socket';

type EventCallback = (...args: any[]) => void;

class SocketService {
  // Подписка на события
  on(event: string, callback: EventCallback) {
    if (!socket) return;
    socket.on(event, callback);
  }

  // Отписка от события
  off(event: string, callback?: EventCallback) {
    if (!socket) return;
    if (callback) {
      socket.off(event, callback);
    } else {
      socket.off(event);
    }
  }

  // Отправка события
  emit(event: string, data?: any) {
    if (!socket?.connected) {
      console.warn('Socket not connected, cannot emit:', event);
      return false;
    }
    socket.emit(event, data);
    return true;
  }

  // Проверка подключения
  get isConnected() {
    return socket?.connected || false;
  }

  // Получение Socket ID
  get socketId() {
    return socket?.id || null;
  }
}

// Экспортируем единственный экземпляр
export const socketService = new SocketService();