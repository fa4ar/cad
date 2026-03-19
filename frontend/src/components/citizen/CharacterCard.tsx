'use client';

import { User, Car, Home } from 'lucide-react';

interface CharacterDataPoints {
    label: string;
    value: string;
    highlight?: boolean;
}

interface CharacterCardProps {
    id: string;
    title: string;
    subtitle: string;
    status: string;
    tag: string;
    dataPoints: CharacterDataPoints[];
    type?: 'person' | 'vehicle' | 'property';
    onClick?: () => void;
}

export function CharacterCard({ title, subtitle, status, tag, dataPoints, type = 'person', onClick }: CharacterCardProps) {
    const isActive = status === 'Active Citizen' || status === 'active';
    
    return (
        <div 
            className="bg-card rounded-xl h-[140px] relative flex flex-col p-5 px-6 transition-all duration-200 cursor-pointer hover:bg-accent border"
            onClick={onClick}
        >
            <div
                className={`absolute top-3 bottom-3 right-0 w-[3px] rounded-l-sm ${isActive ? 'bg-green-500' : 'bg-muted-foreground'}`}
            ></div>
            
            <div className="flex justify-between items-start mb-auto pr-3">
                <div>
                    <div className="text-base font-semibold mb-1">{title}</div>
                    <div className="text-xs text-muted-foreground flex items-center gap-1.5">
                        {!['vehicle', 'property'].includes(type) && (
                            <div className={`w-1.5 h-1.5 rounded-full ${isActive ? 'bg-green-500' : 'bg-muted-foreground'}`}></div>
                        )}
                        {type === 'vehicle' && <Car className="w-3 h-3" />}
                        {type === 'property' && <Home className="w-3 h-3" />}
                        {subtitle}
                    </div>
                </div>
                <div className="bg-muted px-2 py-1 rounded text-xs text-muted-foreground">
                    {tag}
                </div>
            </div>
            
            <div className="flex gap-6 pr-3">
                {dataPoints.map((point, idx) => (
                    <div key={idx} className="flex flex-col gap-1">
                        <span className="text-[10px] uppercase tracking-wider text-muted-foreground">{point.label}</span>
                        <span className={`text-sm font-mono ${point.highlight ? 'text-green-500' : 'text-muted-foreground'}`}>
                            {point.value}
                        </span>
                    </div>
                ))}
            </div>
        </div>
    );
}

export function LoadMoreCard({ onClick }: { onClick?: () => void }) {
    return (
        <div 
            className="border border-dashed rounded-xl h-[140px] flex items-center justify-center text-muted-foreground text-sm cursor-pointer hover:bg-accent transition-colors duration-200"
            onClick={onClick}
        >
            + Загрузить ещё
        </div>
    );
}
