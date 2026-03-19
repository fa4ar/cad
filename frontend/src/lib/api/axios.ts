import axios from 'axios';

const rawBaseUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030';

const api = axios.create({
    baseURL: rawBaseUrl.endsWith('/api') ? rawBaseUrl : rawBaseUrl + '/api',
    timeout: 10000,
    headers: {
        'Content-Type': 'application/json',
    },
    withCredentials: true,
});

// Интерцептор для отладки
api.interceptors.request.use(
    (config) => {
        let token = localStorage.getItem('auth_token');
        if (!token && typeof document !== 'undefined') {
            const match = document.cookie.match(/auth-token=([^;]+)/);
            if (match) token = match[1];
        }
        
        console.log('[Request]', config.method?.toUpperCase(), config.baseURL + (config.url || ''));
        console.log('[Token]', token ? 'exists' : 'missing');
        
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    }
);

// Интерцептор для обработки ошибок
api.interceptors.response.use(
    (response) => {
        console.log('[Response Success]', {
            status: response.status,
            url: response.config?.url,
            method: response.config?.method?.toUpperCase(),
            data: response.data
        });
        return response;
    },
    (error) => {
        console.log('[Response Error]', {
            status: error.response?.status,
            url: error.config?.url,
            method: error.config?.method?.toUpperCase(),
            data: error.response?.data,
            headers: error.config?.headers
        });
        
        if (error.response?.status === 401) {
            console.log('[401] Unauthorized - removing token');
            localStorage.removeItem('auth_token');
            // Не редиректим сразу, даем увидеть ошибку
        }
        
        return Promise.reject(error);
    }
);

export default api;