'use client';

import ManualLayout from '@/components/ManualLayout';

export default function ManualAdminPage() {
  return (
    <ManualLayout
      titulo="Manual del Administrador"
      emoji="🔐"
      color="emerald"
      archivoMd="MANUAL_ADMIN.md"
    >
      <section>
        <h2 className="text-2xl font-bold mb-3">🏆 Crear concurso</h2>
        <p className="text-gray-700">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/nuevo</code>
        </p>
        <p className="text-gray-700 mt-2">
          Rellena: nombre, fechas, ubicación, organizador.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">📅 Añadir jornadas</h2>
        <p className="text-gray-700">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/[id]</code> → Jornadas
        </p>
        <p className="text-gray-700 mt-2">
          Pulsa <strong>&quot;+ Añadir Jornada&quot;</strong> y rellena fecha, pista y horario.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">🏇 Crear pruebas</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/[id]</code> → Pruebas
        </p>
        <p className="text-gray-700">Rellena:</p>
        <ul className="list-disc pl-6 space-y-1 text-gray-700 mt-2">
          <li>Nombre</li>
          <li>Jornada</li>
          <li>Nivel (N0-N9, SJ, INT_I/II, GP, KUR)</li>
          <li>Categoría edad (se filtra según nivel)</li>
          <li>Tipo de prueba (se filtra según nivel)</li>
          <li>Reprise (se filtra según nivel)</li>
        </ul>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">🐴 Registrar binomios</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/binomios</code>
        </p>
        <p className="text-gray-700">
          Pulsa <strong>&quot;+ Nuevo Binomio&quot;</strong>. Las categorías se calculan automáticamente.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">✍️ Inscribir binomios</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/[id]</code> → Inscripciones
        </p>
        <p className="text-gray-700">
          Elige binomio, dorsal y categoría.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">👥 Crear equipos</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/[id]</code> → Equipos
        </p>
        <p className="text-gray-700">
          Pulsa <strong>&quot;+ Nuevo Equipo&quot;</strong> y añade miembros.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">⚖️ Asignar jueces</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/concursos/[id]/pruebas/[pruebaId]</code>
        </p>
        <p className="text-gray-700">
          En <strong>&quot;Jueces asignados&quot;</strong>, pulsa <strong>&quot;+ Añadir Juez&quot;</strong> y asigna una letra (A-E).
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">👤 Gestionar usuarios</h2>
        <p className="text-gray-700 mb-2">
          <strong>Ruta:</strong> <code className="bg-gray-100 px-2 py-1 rounded">/admin/usuarios</code>
        </p>
        <p className="text-gray-700">
          Pulsa <strong>&quot;+ Nuevo Usuario&quot;</strong> y rellena email, contraseña, nombre y rol.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">💾 Backup</h2>
        <div className="bg-gray-100 p-4 rounded">
          <pre className="text-sm">.\scripts\backup_bbdd.ps1</pre>
        </div>
        <p className="text-gray-700 mt-3">
          Restore: <code className="bg-gray-100 px-2 py-1 rounded">.\scripts\restore_bbdd.ps1 -BackupZip &quot;...&quot;</code>
        </p>
      </section>
    </ManualLayout>
  );
}