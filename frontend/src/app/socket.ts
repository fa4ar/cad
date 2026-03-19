import { io } from "socket.io-client";

// Создаем экземпляр socket.io только на клиенте
export const socket = typeof window !== 'undefined'
    ? io(process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:3030", {
        transports: ["websocket", "polling"],
        autoConnect: false, // Не подключаемся автоматически
        timeout: 20000,
        forceNew: false,
        auth: {
            token: typeof window !== 'undefined' ? localStorage.getItem('auth_token') : null
        }
    })
    : null;

// Функция для подключения с токеном
export const connectSocket = () => {
    if (socket && typeof window !== 'undefined') {
        const token = localStorage.getItem('auth_token');
        socket.auth = { token };
        socket.connect();
    }
};

// Функция для отключения
export const disconnectSocket = () => {
    if (socket) {
        socket.disconnect();
    }
};