import { useEffect, useState } from 'react';
import { socketService } from '@/lib/socket-service';

// Хук для получения состояния подключения
export function useSocket() {
  const [isConnected, setIsConnected] = useState(socketService.isConnected);

  useEffect(() => {
    const handleConnect = () => setIsConnected(true);
    const handleDisconnect = () => setIsConnected(false);

    socketService.on('connect', handleConnect);
    socketService.on('disconnect', handleDisconnect);

    // Проверяем текущее состояние
    setIsConnected(socketService.isConnected);

    return () => {
      socketService.off('connect', handleConnect);
      socketService.off('disconnect', handleDisconnect);
    };
  }, []);

  return {
    isConnected,
    socketId: socketService.socketId,
    emit: socketService.emit.bind(socketService),
    on: socketService.on.bind(socketService),
    off: socketService.off.bind(socketService),
  };
}

// Хук для подписки на конкретное событие
export function useSocketEvent(event: string, callback: (...args: any[]) => void) {
  useEffect(() => {
    socketService.on(event, callback);
    
    return () => {
      socketService.off(event, callback);
    };
  }, [event, callback]);
}

// Хук для отправки событий
export function useSocketEmit() {
  return {
    emit: socketService.emit.bind(socketService),
    isConnected: socketService.isConnected,
  };
}