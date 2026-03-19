'use client';

import { useState } from 'react';
import { useSocketEvent, useSocketEmit } from '@/hooks/useSocket';

export function EventListener() {
  const [events, setEvents] = useState<string[]>([]);
  const { emit, isConnected } = useSocketEmit();

  // Прослушиваем все события от backend
  useSocketEvent('notification', (data) => {
    setEvents(prev => [...prev, `Notification: ${JSON.stringify(data)}`]);
  });

  useSocketEvent('system-message', (data) => {
    setEvents(prev => [...prev, `🖥System: ${JSON.stringify(data)}`]);
  });

  useSocketEvent('user-created', (data) => {
    setEvents(prev => [...prev, `User created: ${JSON.stringify(data)}`]);
  });

  useSocketEvent('user-updated', (data) => {
    setEvents(prev => [...prev, ` User updated: ${JSON.stringify(data)}`]);
  });

  useSocketEvent('user-deleted', (data) => {
    setEvents(prev => [...prev, `User deleted: ${JSON.stringify(data)}`]);
  });

  const sendTestEvent = () => {
    if (isConnected) {
      emit('test-event', { message: 'Hello from frontend!', timestamp: new Date().toISOString() });
      setEvents(prev => [...prev, `Sent test event`]);
    }
  };

  const clearEvents = () => {
    setEvents([]);
  };

  return (
    <div className="max-w-2xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-xl font-bold">Live Events</h2>
        <div className="space-x-2">
          <button
            onClick={sendTestEvent}
            disabled={!isConnected}
            className="px-3 py-1 text-sm bg-blue-500 text-white rounded hover:bg-blue-600 disabled:bg-gray-300"
          >
            Send Test Event
          </button>
          <button
            onClick={clearEvents}
            className="px-3 py-1 text-sm bg-gray-500 text-white rounded hover:bg-gray-600"
          >
            Clear
          </button>
        </div>
      </div>

      <div className="h-64 overflow-y-auto border border-gray-300 rounded-lg p-3 bg-gray-50">
        {events.length === 0 ? (
          <p className="text-gray-500 text-sm">No events yet. All backend events will appear here automatically.</p>
        ) : (
          events.map((event, index) => (
            <div key={index} className="text-sm mb-1 font-mono">
              <span className="text-gray-500">{new Date().toLocaleTimeString()}</span> {event}
            </div>
          ))
        )}
      </div>

      <p className="text-xs text-gray-500 mt-2">
        This component automatically listens to all backend events through the global SocketProvider.
      </p>
    </div>
  );
}