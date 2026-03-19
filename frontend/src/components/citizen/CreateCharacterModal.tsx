'use client';

import { useState, useRef, useEffect } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Upload, X } from 'lucide-react';
import api from '@/lib/api/axios';

interface CreateCharacterModalProps {
    open: boolean;
    onOpenChange: (open: boolean) => void;
    onSubmit: (data: CharacterFormData) => Promise<void>;
}

export interface CharacterFormData {
    firstName: string;
    lastName: string;
    dateOfBirth: string;
    gender: string;
    nationality?: string;
    phone?: string;
    address?: string;
    ssn?: string;
    occupation?: string;
    weaponLicense: boolean;
    driverLicense: boolean;
    driverLicenseStatus: string;
    description?: string;
    mugshot?: string;
}

function generateSSN(): string {
    const digit = () => Math.floor(Math.random() * 10);
    return `${digit()}${digit()}${digit()}-${digit()}${digit()}-${digit()}${digit()}${digit()}${digit()}`;
}

export function CreateCharacterModal({ open, onOpenChange, onSubmit }: CreateCharacterModalProps) {
    const [loading, setLoading] = useState(false);
    const [uploading, setUploading] = useState(false);
    const [mugshotPreview, setMugshotPreview] = useState<string | null>(null);
    const fileInputRef = useRef<HTMLInputElement>(null);
    const [generatedSSN, setGeneratedSSN] = useState('');
    
    const [formData, setFormData] = useState<CharacterFormData>({
        firstName: '',
        lastName: '',
        dateOfBirth: '',
        gender: 'male',
        nationality: '',
        phone: '',
        address: '',
        ssn: '',
        occupation: '',
        weaponLicense: false,
        driverLicense: false,
        driverLicenseStatus: 'valid',
        description: ''
    });

    useEffect(() => {
        if (open) {
            const newSSN = generateSSN();
            setGeneratedSSN(newSSN);
            setFormData({
                firstName: '',
                lastName: '',
                dateOfBirth: '',
                gender: 'male',
                nationality: '',
                phone: '',
                address: '',
                ssn: newSSN,
                occupation: '',
                weaponLicense: false,
                driverLicense: false,
                driverLicenseStatus: 'valid',
                description: ''
            });
            setMugshotPreview(null);
            if (fileInputRef.current) {
                fileInputRef.current.value = '';
            }
        }
    }, [open]);

    const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        setUploading(true);
        try {
            const formDataUpload = new FormData();
            formDataUpload.append('file', file);

            const response = await api.post('/upload/character', formDataUpload, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            if (response.data.path) {
                setFormData(prev => ({ ...prev, mugshot: response.data.path }));
                setMugshotPreview(URL.createObjectURL(file));
            }
        } catch (error) {
            console.error('Error uploading file:', error);
        } finally {
            setUploading(false);
        }
    };

    const removeMugshot = () => {
        setFormData(prev => ({ ...prev, mugshot: undefined }));
        setMugshotPreview(null);
        if (fileInputRef.current) {
            fileInputRef.current.value = '';
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        try {
            const submitData = {
                ...formData,
                ssn: generatedSSN
            };
            await onSubmit(submitData);
            setFormData({
                firstName: '',
                lastName: '',
                dateOfBirth: '',
                gender: 'male',
                nationality: '',
                phone: '',
                address: '',
                ssn: '',
                occupation: '',
                weaponLicense: false,
                driverLicense: false,
                driverLicenseStatus: 'valid',
                description: ''
            });
            setMugshotPreview(null);
            setGeneratedSSN(generateSSN());
            onOpenChange(false);
        } catch (error) {
            console.error('Error creating character:', error);
        } finally {
            setLoading(false);
        }
    };

    const driverLicenseStatuses = [
        { value: 'valid', label: 'Valid' },
        { value: 'expired', label: 'Expired' },
        { value: 'suspended', label: 'Suspended' }
    ];

    return (
        <Dialog open={open} onOpenChange={onOpenChange}>
            <DialogContent className="sm:max-w-[600px] max-h-[90vh] overflow-y-auto">
                <DialogHeader>
                    <DialogTitle>Create New Character</DialogTitle>
                </DialogHeader>
                <form onSubmit={handleSubmit} className="space-y-4">
                    {/* Mugshot Upload */}
                    <div className="space-y-2">
                        <Label>Mugshot</Label>
                        <div className="flex items-center gap-4">
                            {mugshotPreview ? (
                                <div className="relative w-20 h-20 rounded-lg overflow-hidden">
                                    <img 
                                        src={mugshotPreview} 
                                        alt="Mugshot preview" 
                                        className="w-full h-full object-cover"
                                    />
                                    <button
                                        type="button"
                                        onClick={removeMugshot}
                                        className="absolute top-0 right-0 bg-red-500 text-white p-1 rounded-bl"
                                    >
                                        <X className="w-3 h-3" />
                                    </button>
                                </div>
                            ) : (
                                <label className="w-20 h-20 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center cursor-pointer hover:border-gray-400 transition-colors">
                                    {uploading ? (
                                        <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-gray-400"></div>
                                    ) : (
                                        <Upload className="w-6 h-6 text-gray-400" />
                                    )}
                                    <input
                                        ref={fileInputRef}
                                        type="file"
                                        accept="image/*"
                                        onChange={handleFileChange}
                                        className="hidden"
                                    />
                                </label>
                            )}
                            <span className="text-sm text-muted-foreground">
                                Click to upload photo
                            </span>
                        </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div className="space-y-2">
                            <Label htmlFor="firstName">First Name</Label>
                            <Input
                                id="firstName"
                                value={formData.firstName}
                                onChange={(e) => setFormData({ ...formData, firstName: e.target.value })}
                                placeholder="John"
                                required
                            />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="lastName">Last Name</Label>
                            <Input
                                id="lastName"
                                value={formData.lastName}
                                onChange={(e) => setFormData({ ...formData, lastName: e.target.value })}
                                placeholder="Smith"
                                required
                            />
                        </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div className="space-y-2">
                            <Label htmlFor="dateOfBirth">Date of Birth</Label>
                            <Input
                                id="dateOfBirth"
                                type="date"
                                value={formData.dateOfBirth}
                                onChange={(e) => setFormData({ ...formData, dateOfBirth: e.target.value })}
                                required
                            />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="nationality">Nationality</Label>
                            <Input
                                id="nationality"
                                value={formData.nationality}
                                onChange={(e) => setFormData({ ...formData, nationality: e.target.value })}
                                placeholder="American"
                            />
                        </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div className="space-y-2">
                            <Label htmlFor="gender">Gender</Label>
                            <Select 
                                value={formData.gender} 
                                onValueChange={(value) => setFormData({ ...formData, gender: value })}
                            >
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="male">Male</SelectItem>
                                    <SelectItem value="female">Female</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="phone">Phone</Label>
                            <Input
                                id="phone"
                                type="tel"
                                value={formData.phone}
                                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                                placeholder="(555) 123-4567"
                            />
                        </div>
                    </div>

                    <div className="space-y-2">
                        <Label htmlFor="address">Address</Label>
                        <Input
                            id="address"
                            value={formData.address}
                            onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                            placeholder="123 Main St, Los Santos, CA 90000"
                        />
                    </div>

                    <div className="space-y-2">
                        <Label>SSN (Auto-generated)</Label>
                        <Input
                            value={generatedSSN}
                            disabled
                            className="flex-1 bg-muted"
                        />
                    </div>

                    <div className="space-y-2">
                        <Label htmlFor="occupation">Occupation</Label>
                        <Input
                            id="occupation"
                            value={formData.occupation}
                            onChange={(e) => setFormData({ ...formData, occupation: e.target.value })}
                            placeholder="Driver, Doctor, Unemployed, etc."
                        />
                    </div>

                    <div className="space-y-2">
                        <Label htmlFor="description">Description</Label>
                        <Input
                            id="description"
                            value={formData.description}
                            onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                            placeholder="Brief character description"
                        />
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div className="flex items-center gap-2">
                            <input
                                id="weaponLicense"
                                type="checkbox"
                                checked={formData.weaponLicense}
                                onChange={(e) => setFormData({ ...formData, weaponLicense: e.target.checked })}
                                className="w-4 h-4"
                            />
                            <Label htmlFor="weaponLicense" className="cursor-pointer">Weapon License</Label>
                        </div>
                        <div className="flex items-center gap-2">
                            <input
                                id="driverLicense"
                                type="checkbox"
                                checked={formData.driverLicense}
                                onChange={(e) => setFormData({ ...formData, driverLicense: e.target.checked })}
                                className="w-4 h-4"
                            />
                            <Label htmlFor="driverLicense" className="cursor-pointer">Driver License</Label>
                        </div>
                    </div>

                    {formData.driverLicense && (
                        <div className="space-y-2">
                            <Label htmlFor="driverLicenseStatus">Driver License Status</Label>
                            <Select 
                                value={formData.driverLicenseStatus} 
                                onValueChange={(value) => setFormData({ ...formData, driverLicenseStatus: value })}
                            >
                                <SelectTrigger>
                                    <SelectValue />
                                </SelectTrigger>
                                <SelectContent>
                                    {driverLicenseStatuses.map((status) => (
                                        <SelectItem key={status.value} value={status.value}>
                                            {status.label}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    )}

                    <DialogFooter>
                        <Button 
                            type="button" 
                            variant="outline" 
                            onClick={() => onOpenChange(false)}
                        >
                            Cancel
                        </Button>
                        <Button 
                            type="submit" 
                            disabled={loading || !formData.firstName || !formData.lastName || !formData.dateOfBirth}
                        >
                            {loading ? 'Creating...' : 'Create Character'}
                        </Button>
                    </DialogFooter>
                </form>
            </DialogContent>
        </Dialog>
    );
}
