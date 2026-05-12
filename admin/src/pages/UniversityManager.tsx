import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/supabaseClient';

export default function UniversityManager() {
  const [universities, setUniversities] = useState<any[]>([]);
  const [name, setName] = useState('');
  const [city, setCity] = useState('');
  const [loading, setLoading] = useState(false);
  const [fetchLoading, setFetchLoading] = useState(true);

  const fetchUniversities = async () => {
    setFetchLoading(true);
    const { data, error } = await supabase
      .from('universities')
      .select('*')
      .order('created_at', { ascending: false });
      
    if (!error && data) {
      setUniversities(data);
    }
    setFetchLoading(false);
  };

  useEffect(() => {
    fetchUniversities();
  }, []);

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    
    const { error } = await supabase
      .from('universities')
      .insert([{ name, city }]);
      
    if (!error) {
      setName('');
      setCity('');
      fetchUniversities(); // Refresh the table
    } else {
      alert('Error creating university: ' + error.message);
    }
    
    setLoading(false);
  };

  return (
    <div className="p-8 max-w-6xl mx-auto">
      <h1 className="text-3xl font-black text-gray-800 mb-8">University Manager</h1>
      
      {/* Create Form */}
      <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-200 mb-10">
        <h2 className="text-xl font-bold text-gray-800 mb-4">Register New College</h2>
        <form onSubmit={handleCreate} className="flex flex-col md:flex-row gap-4 items-end">
          <div className="flex-1 w-full">
            <label className="block text-sm font-semibold text-gray-600 mb-2">University Name</label>
            <input 
              required
              type="text" 
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-500 outline-none" 
              placeholder="e.g. Stanford University" 
            />
          </div>
          <div className="flex-1 w-full">
            <label className="block text-sm font-semibold text-gray-600 mb-2">City</label>
            <input 
              required
              type="text" 
              value={city}
              onChange={(e) => setCity(e.target.value)}
              className="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-500 outline-none" 
              placeholder="e.g. Stanford, CA" 
            />
          </div>
          <button 
            type="submit" 
            disabled={loading}
            className="w-full md:w-auto bg-indigo-600 text-white font-bold py-3 px-8 rounded-lg hover:bg-indigo-700 disabled:opacity-50 transition-colors"
          >
            {loading ? 'Adding...' : 'Add University'}
          </button>
        </form>
      </div>

      {/* List Table */}
      <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
        <div className="px-6 py-5 border-b border-gray-200 bg-gray-50 flex justify-between items-center">
          <h2 className="text-lg font-bold text-gray-800">Database Records</h2>
          <span className="text-sm font-semibold text-indigo-600 bg-indigo-100 px-3 py-1 rounded-full">{universities.length} Total</span>
        </div>
        
        {fetchLoading ? (
          <div className="p-12 text-center text-gray-500 font-medium animate-pulse">Loading universities...</div>
        ) : universities.length === 0 ? (
          <div className="p-12 text-center text-gray-500 font-medium">No universities found. Please add one above.</div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-white border-b border-gray-200 text-xs text-gray-500 uppercase tracking-widest">
                  <th className="px-6 py-4 font-bold">Name</th>
                  <th className="px-6 py-4 font-bold">City</th>
                  <th className="px-6 py-4 font-bold">Database UUID (For VRAM Embeddings)</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {universities.map((uni) => (
                  <tr key={uni.id} className="hover:bg-gray-50 transition-colors">
                    <td className="px-6 py-4 font-bold text-gray-800">{uni.name}</td>
                    <td className="px-6 py-4 font-medium text-gray-600">{uni.city}</td>
                    <td className="px-6 py-4">
                      <code className="bg-gray-100 border border-gray-200 text-indigo-700 px-3 py-1.5 rounded-md text-sm select-all font-mono">
                        {uni.id}
                      </code>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
