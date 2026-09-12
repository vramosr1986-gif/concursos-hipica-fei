'use client';

import Link from 'next/link';

export default function CentralCreacionPage() {
  return (
    <div className="container py-12">
      <div className="text-center mb-12">
        <h1 className="text-4xl font-bold mb-4">🚀 Centro de Creación</h1>
        <p className="text-gray-600">Seleccione qué desea añadir al sistema</p>
      </div>

      <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
        {/* Opción Juez */}
        <Link 
          href="/admin/jueces/nuevo" 
          className="card p-10 hover:shadow-2xl transition-all group border-2 border-transparent hover:border-primary text-center"
        >
          <div className="text-6xl mb-6 group-hover:scale-110 transition-transform">⚖️</div>
          <h2 className="text-2xl font-bold mb-4">Crear Juez</h2>
          <p className="text-gray-600 mb-6">
            Añadir un profesional al catálogo maestro para asignarlo a concursos. 
            <br/><span className="text-xs font-semibold">(Sin acceso a la web)</span>
          </p>
          <span className="bg-primary text-white px-6 py-2 rounded-full font-bold">
            Ir al formulario →
          </span>
        </Link>

        {/* Opción Usuario */}
        <Link 
          href="/admin/usuarios/nuevo" 
          className="card p-10 hover:shadow-2xl transition-all group border-2 border-transparent hover:border-primary text-center"
        >
          <div className="text-6xl mb-6 group-hover:scale-110 transition-transform">👤</div>
          <h2 className="text-2xl font-bold mb-4">Crear Usuario</h2>
          <p className="text-gray-600 mb-6">
            Crear una cuenta de acceso con email y contraseña para entrar en la web.
            <br/><span className="text-xs font-semibold">(Acceso Admin o User)</span>
          </p>
          <span className="bg-primary text-white px-6 py-2 rounded-full font-bold">
            Ir al formulario →
          </span>
        </Link>
      </div>
    </div>
  );
}
