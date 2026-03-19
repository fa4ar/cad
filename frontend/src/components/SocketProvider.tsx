'use client';

import { useEffect, useState } from 'react';
import { socket, connectSocket } from '@/app/socket';

interface SocketProviderProps {
  children: React.ReactNode;
}

export function SocketProvider({ children }: SocketProviderProps) {
  const [isConnected, setIsConnected] = useState(false);

  useEffect(() => {
    if (!socket) return;

    // Обработчики подключения
    const handleConnect = () => {
      console.log('🟢 Socket connected:', socket?.id);
      setIsConnected(true);
    };

    const handleDisconnect = (reason: string) => {
      console.log('🔴 Socket disconnected:', reason);
      setIsConnected(false);
    };

    const handleConnectError = (error: any) => {
      console.error('🔥 Socket connection error:', error);
      setIsConnected(false);
    };

    const handleReconnect = (attemptNumber: number) => {
      console.log('🔄 Socket reconnected after', attemptNumber, 'attempts');
      setIsConnected(true);
    };

    // Обработчики событий от сервера
    const handleUserConnected = (data: any) => {
      console.log('👤 User connected:', data);
    };

    const handleUserDisconnected = (data: any) => {
      console.log('👤 User disconnected:', data);
    };

    const handlePrivateMessage = (data: any) => {
      console.log('💬 Private message:', data);
    };

    const handleOnlineUsers = (users: any[]) => {
      console.log('👥 Online users:', users);
    };

    const handleError = (error: string) => {
      console.error('❌ Socket error:', error);
    };

    // Подписываемся на события подключения
    socket.on('connect', handleConnect);
    socket.on('disconnect', handleDisconnect);
    socket.on('connect_error', handleConnectError);
    socket.on('reconnect', handleReconnect);

    // Подписываемся на события от сервера
    socket.on('user-connected', handleUserConnected);
    socket.on('user-disconnected', handleUserDisconnected);
    socket.on('private-message', handlePrivateMessage);
    socket.on('online-users', handleOnlineUsers);
    socket.on('error', handleError);

    // Подключаемся к сокету
    connectSocket();

    // Проверяем начальное состояние
    if (socket.connected) {
      handleConnect();
    }

    // Cleanup при размонтировании
    return () => {
      if (socket) {
        socket.off('connect', handleConnect);
        socket.off('disconnect', handleDisconnect);
        socket.off('connect_error', handleConnectError);
        socket.off('reconnect', handleReconnect);
        socket.off('user-connected', handleUserConnected);
        socket.off('user-disconnected', handleUserDisconnected);
        socket.off('private-message', handlePrivateMessage);
        socket.off('online-users', handleOnlineUsers);
        socket.off('error', handleError);
      }
    };
  }, []);

  return (
    <>
      {children}
      
      {/* Глобальный индикатор подключения */}
      <div className="fixed top-4 right-4 z-50">
        <div className={`px-3 py-1 rounded-full text-xs font-medium transition-all duration-300 ${
          isConnected 
            ? 'bg-green-100 text-green-800 border border-green-200' 
            : 'bg-red-100 text-red-800 border border-red-200'
        }`}>
          <div className={`inline-block w-2 h-2 rounded-full mr-2 ${
            isConnected ? 'bg-green-500' : 'bg-red-500'
          }`} />
          {isConnected ? 'Online' : 'Offline'}
        </div>
      </div>
    </>
  );
}