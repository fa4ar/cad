'use client';

import { useState, useEffect } from 'react';
import { useAuth } from '@/hooks/useAuth';
import api from '@/lib/api/axios';

interface Priority {
  id: string;
  title: string;
  description: string | null;
  type: string;
  priority: string;
  status: string;
  category: string | null;
  location: string | null;
  requesterName: string | null;
  requesterPhone: string | null;
  assignedToName: string | null;
  department: { name: string } | null;
  createdAt: string;
  updatedAt: string;
}

const priorityColors: Record<string, string> = {
  low: 'bg-blue-500/10 text-blue-500 border-blue-500/30',
  medium: 'bg-yellow-500/10 text-yellow-500 border-yellow-500/30',
  high: 'bg-orange-500/10 text-orange-500 border-orange-500/30',
  critical: 'bg-red-500/10 text-red-500 border-red-500/30',
};

const statusColors: Record<string, string> = {
  pending: 'bg-gray-500/10 text-gray-500 border-gray-500/30',
  in_progress: 'bg-blue-500/10 text-blue-500 border-blue-500/30',
  completed: 'bg-green-500/10 text-green-500 border-green-500/30',
  cancelled: 'bg-red-500/10 text-red-500 border-red-500/30',
};

export default function PrioritiesPage() {
  const { user } = useAuth();
  const [priorities, setPriorities] = useState<Priority[]>([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState({ status: '', priority: '' });
  const [selectedPriority, setSelectedPriority] = useState<Priority | null>(null);

  useEffect(() => {
    fetchPriorities();
  }, [filter]);

  const fetchPriorities = async () => {
    try {
      const params = new URLSearchParams();
      if (filter.status) params.append('status', filter.status);
      if (filter.priority) params.append('priority', filter.priority);
      
      const response = await api.get(`/admin/priorities?${params}`);
      setPriorities(Array.isArray(response.data) ? response.data : []);
    } catch (error) {
      console.error('Error fetching priorities:', error);
      setPriorities([]);
    } finally {
      setLoading(false);
    }
  };

  const updateStatus = async (id: string, status: string) => {
    try {
      await api.patch(
        `/admin/priorities/${id}/status`,
        { status }
      );
      fetchPriorities();
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };

  const deletePriority = async (id: string) => {
    if (!confirm('Вы уверены, что хотите удалить эту заявку?')) return;
    
    try {
      await api.delete(`/admin/priorities/${id}`);
      fetchPriorities();
      setSelectedPriority(null);
    } catch (error) {
      console.error('Error deleting priority:', error);
    }
  };

  const formatDate = (date: string) => {
    return new Date(date).toLocaleString('ru-RU', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold">Заявки и приоритеты</h1>
        
        <div className="flex gap-4">
          <select
            className="px-3 py-2 bg-secondary rounded-md border border-border"
            value={filter.status}
            onChange={(e) => setFilter({ ...filter, status: e.target.value })}
          >
            <option value="">Все статусы</option>
            <option value="pending">Ожидает</option>
            <option value="in_progress">В работе</option>
            <option value="completed">Завершено</option>
            <option value="cancelled">Отменено</option>
          </select>
          
          <select
            className="px-3 py-2 bg-secondary rounded-md border border-border"
            value={filter.priority}
            onChange={(e) => setFilter({ ...filter, priority: e.target.value })}
          >
            <option value="">Все приоритеты</option>
            <option value="low">Низкий</option>
            <option value="medium">Средний</option>
            <option value="high">Высокий</option>
            <option value="critical">Критический</option>
          </select>
        </div>
      </div>

      <div className="bg-card rounded-lg border border-border overflow-hidden">
        <table className="w-full">
          <thead className="bg-muted">
            <tr>
              <th className="px-4 py-3 text-left text-sm font-medium">Приоритет</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Название</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Тип</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Статус</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Заявитель</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Дата</th>
              <th className="px-4 py-3 text-left text-sm font-medium">Действия</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-border">
            {priorities.length === 0 ? (
              <tr>
                <td colSpan={7} className="px-4 py-8 text-center text-muted-foreground">
                  Заявок не найдено
                </td>
              </tr>
            ) : (
              priorities.map((priority) => (
                <tr key={priority.id} className="hover:bg-muted/50">
                  <td className="px-4 py-3">
                    <span className={`px-2 py-1 rounded-full text-xs border ${priorityColors[priority.priority]}`}>
                      {priority.priority}
                    </span>
                  </td>
                  <td className="px-4 py-3 font-medium">{priority.title}</td>
                  <td className="px-4 py-3 text-muted-foreground">{priority.type}</td>
                  <td className="px-4 py-3">
                    <select
                      className="px-2 py-1 bg-secondary rounded border border-border text-sm"
                      value={priority.status}
                      onChange={(e) => updateStatus(priority.id, e.target.value)}
                    >
                      <option value="pending">Ожидает</option>
                      <option value="in_progress">В работе</option>
                      <option value="completed">Завершено</option>
                      <option value="cancelled">Отменено</option>
                    </select>
                  </td>
                  <td className="px-4 py-3 text-muted-foreground">
                    {priority.requesterName || '-'}
                  </td>
                  <td className="px-4 py-3 text-muted-foreground text-sm">
                    {formatDate(priority.createdAt)}
                  </td>
                  <td className="px-4 py-3">
                    <button
                      onClick={() => setSelectedPriority(priority)}
                      className="text-primary hover:underline text-sm mr-2"
                    >
                      Подробнее
                    </button>
                    <button
                      onClick={() => deletePriority(priority.id)}
                      className="text-destructive hover:underline text-sm"
                    >
                      Удалить
                    </button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {selectedPriority && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-card border border-border rounded-lg p-6 max-w-lg w-full mx-4">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold">Детали заявки</h2>
              <button
                onClick={() => setSelectedPriority(null)}
                className="text-muted-foreground hover:text-foreground"
              >
                ✕
              </button>
            </div>
            
            <div className="space-y-4">
              <div>
                <label className="text-sm text-muted-foreground">Название</label>
                <p className="font-medium">{selectedPriority.title}</p>
              </div>
              
              <div>
                <label className="text-sm text-muted-foreground">Описание</label>
                <p className="text-muted-foreground">{selectedPriority.description || 'Нет описания'}</p>
              </div>
              
              <div className="flex gap-4">
                <div>
                  <label className="text-sm text-muted-foreground">Приоритет</label>
                  <span className={`px-2 py-1 rounded-full text-xs border ${priorityColors[selectedPriority.priority]}`}>
                    {selectedPriority.priority}
                  </span>
                </div>
                <div>
                  <label className="text-sm text-muted-foreground">Статус</label>
                  <span className={`px-2 py-1 rounded-full text-xs border ${statusColors[selectedPriority.status]}`}>
                    {selectedPriority.status}
                  </span>
                </div>
              </div>
              
              {selectedPriority.requesterName && (
                <div>
                  <label className="text-sm text-muted-foreground">Заявитель</label>
                  <p>{selectedPriority.requesterName} {selectedPriority.requesterPhone && `(${selectedPriority.requesterPhone})`}</p>
                </div>
              )}
              
              {selectedPriority.location && (
                <div>
                  <label className="text-sm text-muted-foreground">Локация</label>
                  <p>{selectedPriority.location}</p>
                </div>
              )}
              
              <div>
                <label className="text-sm text-muted-foreground">Создано</label>
                <p>{formatDate(selectedPriority.createdAt)}</p>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
