import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';

const customStyles = {
  body: {
    backgroundImage: "url(\"data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.03'/%3E%3C/svg%3E\")"
  }
};

const Nav = () => {
  const [activeTab, setActiveTab] = useState('Characters');
  
  const navItems = ['Characters', 'Vehicles', 'Properties', 'Documents', 'Records'];
  
  return (
    <nav className="h-16 border-b border-white/5 flex items-center px-8 flex-shrink-0 bg-[rgba(5,5,5,0.8)] backdrop-blur-[10px] z-10">
      <div className="flex items-center gap-2 font-bold text-sm tracking-wider uppercase text-[#555555] mr-12">
        <span className="text-[#e6e6e6]">CIV</span>NET
      </div>
      <div className="flex gap-8 h-full">
        {navItems.map((item) => (
          <div
            key={item}
            className={`flex items-center h-full text-[13px] font-medium cursor-pointer transition-colors duration-200 relative ${
              activeTab === item ? 'text-[#e6e6e6]' : 'text-[#808080] hover:text-[#e6e6e6]'
            }`}
            onClick={() => setActiveTab(item)}
          >
            {item}
            {activeTab === item && (
              <div className="absolute bottom-[-1px] left-0 right-0 h-[2px] bg-[#4ade80] shadow-[0_-2px_8px_rgba(74,222,128,0.3)]"></div>
            )}
          </div>
        ))}
      </div>
    </nav>
  );
};

const Header = () => {
  return (
    <header className="flex justify-between items-center mb-4">
      <h1 className="text-xl font-semibold text-[#e6e6e6] tracking-[-0.01em]">Civilian Database</h1>
      <div className="flex gap-3">
        <button className="bg-transparent text-[#808080] border border-white/10 px-4 py-2 rounded-md text-[13px] font-semibold cursor-pointer transition-opacity duration-200 hover:opacity-90">
          Filter
        </button>
        <button className="bg-transparent text-[#808080] border border-white/10 px-4 py-2 rounded-md text-[13px] font-semibold cursor-pointer transition-opacity duration-200 hover:opacity-90">
          Sort
        </button>
      </div>
    </header>
  );
};

const CreateForm = () => {
  const [formData, setFormData] = useState({
    legalName: '',
    dateOfBirth: '',
    occupation: 'Unemployed'
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Creating record:', formData);
    setFormData({
      legalName: '',
      dateOfBirth: '',
      occupation: 'Unemployed'
    });
  };

  return (
    <div className="bg-[#111111] rounded-xl p-6 flex items-end gap-4 flex-wrap">
      <div className="flex flex-col gap-2 flex-[0_0_100%] mb-2">
        <label className="text-[#e6e6e6] text-xs uppercase tracking-[0.5px] font-semibold">New Entry</label>
      </div>
      <div className="flex flex-col gap-2 flex-1 min-w-[180px]">
        <label className="text-[11px] uppercase tracking-[0.5px] text-[#555555] font-semibold">Legal Name</label>
        <input
          type="text"
          placeholder="Last, First"
          value={formData.legalName}
          onChange={(e) => setFormData({...formData, legalName: e.target.value})}
          className="bg-[#0a0a0a] border border-white/5 rounded-md px-3 py-2.5 text-[#e6e6e6] text-[13px] outline-none transition-all duration-200 focus:border-[#555555] focus:shadow-[0_0_0_2px_rgba(255,255,255,0.05)]"
        />
      </div>
      <div className="flex flex-col gap-2 flex-1 min-w-[180px]">
        <label className="text-[11px] uppercase tracking-[0.5px] text-[#555555] font-semibold">Date of Birth</label>
        <input
          type="date"
          value={formData.dateOfBirth}
          onChange={(e) => setFormData({...formData, dateOfBirth: e.target.value})}
          className="bg-[#0a0a0a] border border-white/5 rounded-md px-3 py-2.5 text-[#e6e6e6] text-[13px] outline-none transition-all duration-200 focus:border-[#555555] focus:shadow-[0_0_0_2px_rgba(255,255,255,0.05)]"
        />
      </div>
      <div className="flex flex-col gap-2 flex-1 min-w-[180px]">
        <label className="text-[11px] uppercase tracking-[0.5px] text-[#555555] font-semibold">Occupation</label>
        <select
          value={formData.occupation}
          onChange={(e) => setFormData({...formData, occupation: e.target.value})}
          className="bg-[#0a0a0a] border border-white/5 rounded-md px-3 py-2.5 text-[#e6e6e6] text-[13px] outline-none transition-all duration-200 focus:border-[#555555] focus:shadow-[0_0_0_2px_rgba(255,255,255,0.05)]"
        >
          <option>Unemployed</option>
          <option>Civil Servant</option>
          <option>Mechanic</option>
          <option>Medical</option>
        </select>
      </div>
      <div className="flex flex-col gap-2 flex-1 min-w-[180px]">
        <button
          onClick={handleSubmit}
          className="w-full h-[38px] bg-[#e6e6e6] text-[#050505] border-none px-4 py-2 rounded-md text-[13px] font-semibold cursor-pointer transition-opacity duration-200 hover:opacity-90"
        >
          Create Record
        </button>
      </div>
    </div>
  );
};

const Card = ({ data }) => {
  const isActive = data.status === 'Active Citizen';
  const isVehicle = data.type === 'vehicle';
  const isProperty = data.type === 'property';
  const isLoadMore = data.type === 'loadMore';

  if (isLoadMore) {
    return (
      <div className="border border-dashed border-white/10 bg-transparent rounded-xl h-[140px] flex items-center justify-center text-[#555555] text-[13px] cursor-pointer hover:border-white/20 transition-colors duration-200">
        + Load More Records
      </div>
    );
  }

  return (
    <div className="bg-[#111111] rounded-xl h-[140px] relative flex flex-col p-5 px-6 transition-all duration-200 cursor-pointer hover:bg-[#161616] hover:-translate-y-0.5 overflow-hidden">
      <div
        className="absolute top-3 bottom-3 right-0 w-[3px] bg-[#4ade80] rounded-l-sm shadow-[-2px_0_12px_rgba(74,222,128,0.3)]"
      ></div>
      
      <div className="flex justify-between items-start mb-auto pr-3">
        <div>
          <div className="text-[15px] font-semibold text-[#e6e6e6] mb-1">{data.title}</div>
          <div className="text-xs text-[#555555] flex items-center gap-1.5">
            {!isVehicle && !isProperty && (
              <div className={`w-1.5 h-1.5 rounded-full ${isActive ? 'bg-[#4ade80] shadow-[0_0_8px_rgba(74,222,128,0.3)]' : 'bg-[#555555]'}`}></div>
            )}
            {data.subtitle}
          </div>
        </div>
        <div className="bg-white/5 px-2 py-1 rounded text-[11px] text-[#808080] tracking-[0.5px]">
          {data.tag}
        </div>
      </div>
      
      <div className="flex gap-6 pr-3">
        {data.dataPoints.map((point, idx) => (
          <div key={idx} className="flex flex-col gap-1">
            <span className="text-[10px] uppercase tracking-[0.5px] text-[#555555]">{point.label}</span>
            <span className={`text-[13px] font-mono ${point.highlight ? 'text-[#4ade80]' : 'text-[#808080]'}`}>
              {point.value}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

const MainContent = () => {
  const [records] = useState([
    {
      type: 'person',
      title: 'Vance, Marcus',
      subtitle: 'Active Citizen',
      status: 'Active Citizen',
      tag: 'ID: 948-22',
      dataPoints: [
        { label: 'Age', value: '34' },
        { label: 'Occupation', value: 'Heavy Transport' },
        { label: 'Vehicles', value: '2' }
      ]
    },
    {
      type: 'person',
      title: 'Kovacs, Elena',
      subtitle: 'Restricted',
      status: 'Restricted',
      tag: 'ID: 882-19',
      dataPoints: [
        { label: 'Age', value: '29' },
        { label: 'Occupation', value: 'Medical Asst.' },
        { label: 'Vehicles', value: '0' }
      ]
    },
    {
      type: 'person',
      title: 'Roth, Julian',
      subtitle: 'Active Citizen',
      status: 'Active Citizen',
      tag: 'ID: 102-44',
      dataPoints: [
        { label: 'Age', value: '42' },
        { label: 'Occupation', value: 'Logistics' },
        { label: 'Properties', value: '1' }
      ]
    },
    {
      type: 'vehicle',
      title: 'Stratum 2022',
      subtitle: 'Sedan • Black',
      tag: 'LCS-992',
      dataPoints: [
        { label: 'Owner', value: 'Vance, Marcus' },
        { label: 'Insured', value: 'Yes', highlight: true },
        { label: 'Impound', value: 'No' }
      ]
    },
    {
      type: 'property',
      title: '224 Popular St',
      subtitle: 'Residential • Apt 4B',
      tag: 'Tier 2',
      dataPoints: [
        { label: 'Owner', value: 'Chen, Sarah' },
        { label: 'Tenants', value: '1' },
        { label: 'Status', value: 'Occupied' }
      ]
    },
    {
      type: 'loadMore'
    }
  ]);

  return (
    <main className="flex-1 p-8 overflow-y-auto flex flex-col gap-8">
      <Header />
      <CreateForm />
      <div className="grid grid-cols-[repeat(auto-fill,minmax(380px,1fr))] gap-4 pb-16">
        {records.map((record, idx) => (
          <Card key={idx} data={record} />
        ))}
      </div>
    </main>
  );
};

const App = () => {
  useEffect(() => {
    const style = document.createElement('style');
    style.textContent = `
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }
      body {
        -webkit-font-smoothing: antialiased;
      }
      ::-webkit-scrollbar {
        width: 8px;
      }
      ::-webkit-scrollbar-track {
        background: #050505;
      }
      ::-webkit-scrollbar-thumb {
        background: #222;
        border-radius: 4px;
      }
      ::-webkit-scrollbar-thumb:hover {
        background: #333;
      }
    `;
    document.head.appendChild(style);
    return () => document.head.removeChild(style);
  }, []);

  return (
    <Router basename="/">
      <div 
        className="bg-[#050505] text-[#e6e6e6] font-['Inter',-apple-system,BlinkMacSystemFont,'Segoe_UI',Roboto,Helvetica,Arial,sans-serif] h-screen flex flex-col overflow-hidden"
        style={customStyles.body}
      >
        <Nav />
        <Routes>
          <Route path="/" element={<MainContent />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;