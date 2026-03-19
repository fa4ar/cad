'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

type Language = 'en' | 'ru';

interface Translations {
  [key: string]: string;
}

const translations: Translations = {
  // Nav
  'Compass': 'Compass',
  'Characters': 'Персонажи',
  'Vehicles': 'Транспорт', 
  'Properties': 'Недвижимость',
  'Documents': 'Документы',
  'Records': 'Записи',
  
  // Common
  'New Entry': 'Новый персонаж',
  'Filter': 'Фильтр',
  'Info': 'Информация',
  'Save': 'Сохранить',
  'Cancel': 'Отмена',
  'Delete': 'Удалить',
  'Edit': 'Редактировать',
  'Create': 'Создать',
  'Search': 'Поиск',
  'Searching...': 'Поиск...',
  'SEARCH': 'ПОИСК',
  'Loading': 'Загрузка...',
  'Plate': 'Номер',
  'Serial Number': 'Серийный номер',
  'N/A': 'Н/Д',
  'None': 'Нет',
  'Yes': 'Да',
  'No': 'Нет',
  'Active': 'Активный',
  'Inactive': 'Неактивный',
  'Plate Number': 'Гос. номер',
  'Model': 'Модель',
  'Owner': 'Владелец',
  'Status': 'Статус',
  'Type': 'Тип',
  'Description': 'Описание',
  'Location': 'Место',
  'Priority': 'Приоритет',
  'Caller Name': 'Имя звонящего',
  'Caller Phone': 'Телефон звонящего',
  'Notes': 'Заметки',
  'Address': 'Адрес',
  'Date': 'Дата',
  'Time': 'Время',
  
  // Citizen
  'Civilian Database': 'База граждан',
  'Active Citizen': 'Гражданин',
  'Arrested': 'Арестован',
  'Wanted': 'В розыске',
  'SSN': 'СНИЛС',
  'Age': 'Возраст',
  'Occupation': 'Профессия',
  'Full Name': 'Имя',
  'Date of Birth': 'Дата рождения',
  'Phone': 'Телефон',
  'Department': 'Департамент',
  'Rank': 'Звание',
  'Callsign': 'Позывной',
  'Badge Number': 'Номер значка',
  'Quick Actions': 'Действия',
  'Clear Wanted': 'Снять розыск',
  'Set Wanted': 'Объявить в розыск',
  'Release': 'Освободить',
  'Arrest': 'Арестовать',
  'Officer Management': 'Управление сотрудником',
  'Create Officer': 'Создать сотрудника',
  'Edit Officer': 'Редактировать сотрудника',
  'fines': 'штрафов',
  'warrants': 'ордеров',
  'arrests': 'арестов',
  'Fines': 'Штрафы',
  'Warrants': 'Ордера',
  'Arrests': 'Аресты',
  
  // Police
  'CAD System': 'Система CAD',
  'Dispatch': 'Диспетчер',
  'My Unit': 'Мое подразделение',
  'My Call': 'Мой вызов',
  'Request Warrant': 'Запросить ордер',
  'My Shift': 'Моя смена',
  'On Duty': 'На смене',
  'Off Duty': 'Не на смене',
  'Available': 'Доступен',
  'Busy': 'Занят',
  'En Route': 'В пути',
  'On Scene': 'На месте',
  'Units': 'Подразделения',
  'Calls': 'Вызовы',
  'New Warrant': 'Новый ордер',
  'WARRANT TYPE': 'ТИП ОРДЕРА',
  'REASON': 'ПРИЧИНА',
  
  // Detective
  'Detective Cases': 'Детективные дела',
  'New Case': 'Новое дело',
  'Evidence': 'Доказательства',
  'Photos': 'Фотографии',
  'Events': 'События',
  'Suspects': 'Подозреваемые',
  'Witnesses': 'Свидетели',
  'Victims': 'Жертвы',
  'Case Details': 'Детали дела',
  'Case Number': 'Номер дела',
  'Title': 'Название',
  'Open': 'Открыто',
  'Closed': 'Закрыто',
  
  // Fire
  'Fire Department': 'Пожарная служба',
  'Incidents': 'Инциденты',
  'Station': 'Станция',
  
  // Dispatch
  'Active Calls': 'Активные вызовы',
  'Call History': 'История вызовов',
  'Units Available': 'Доступные подразделения',
  'Assign Unit': 'Назначить подразделение',
};

interface LanguageContextType {
  language: Language;
  setLanguage: (lang: Language) => void;
  t: (key: string) => string;
}

const LanguageContext = createContext<LanguageContextType | undefined>(undefined);

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [language, setLanguageState] = useState<Language>('en');

  useEffect(() => {
    const saved = localStorage.getItem('language');
    if (saved === 'en' || saved === 'ru') {
      setLanguageState(saved);
    }
  }, []);

  const setLanguage = (lang: Language) => {
    localStorage.setItem('language', lang);
    setLanguageState(lang);
  };

  const t = (key: string): string => {
    if (language === 'ru' && translations[key]) {
      return translations[key];
    }
    return key;
  };

  return (
    <LanguageContext.Provider value={{ language, setLanguage, t }}>
      {children}
    </LanguageContext.Provider>
  );
}

export function useLanguage() {
  const context = useContext(LanguageContext);
  if (!context) {
    return {
      language: 'en' as Language,
      setLanguage: () => {},
      t: (key: string) => key
    };
  }
  return context;
}
