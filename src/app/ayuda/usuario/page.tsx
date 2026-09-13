'use client';

import ManualLayout from '@/components/ManualLayout';

export default function ManualUsuarioPage() {
  return (
    <ManualLayout
      titulo="Manual de Usuario"
      emoji="📘"
      color="blue"
      archivoMd="MANUAL_USUARIO.md"
    >
      <section>
        <h2 className="text-2xl font-bold mb-3">📖 Introducción</h2>
        <p className="text-gray-700">
          Esta plataforma gestiona <strong>concursos de Doma Clásica</strong> según el
          reglamento de la Real Federación Hípica Española (RFHE).
        </p>
        <p className="text-gray-700 mt-2">
          Hay tres tipos de usuarios: <strong>Admin</strong>, <strong>Juez</strong> y{' '}
          <strong>Público</strong>.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">🏆 Crear un concurso</h2>
        <ol className="list-decimal pl-6 space-y-2 text-gray-700">
          <li>Crea el <strong>concurso</strong> (nombre, fechas, ubicación).</li>
          <li>Añade las <strong>jornadas</strong> (sábado, domingo).</li>
          <li>Registra los <strong>binomios</strong> (jinete + caballo).</li>
          <li><strong>Inscribe</strong> los binomios al concurso.</li>
          <li>Crea los <strong>equipos</strong> (si aplica).</li>
          <li>Crea las <strong>pruebas</strong> (nivel + categoría + tipo).</li>
          <li>Asigna <strong>jueces</strong> a cada prueba.</li>
          <li>Los jueces <strong>puntúan</strong>.</li>
          <li>Los <strong>resultados</strong> se publican automáticamente.</li>
        </ol>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">📊 Sistema de categorías</h2>
        <p className="text-gray-700 mb-4">
          Las categorías se calculan <strong>automáticamente</strong> según la edad.
        </p>
        <div className="overflow-x-auto">
          <table className="table w-full">
            <thead>
              <tr><th>Categoría</th><th>Edad jinete</th></tr>
            </thead>
            <tbody>
              <tr><td>Alevines</td><td>≤ 12 años</td></tr>
              <tr><td>Infantiles</td><td>13-14 años</td></tr>
              <tr><td>Juveniles</td><td>15-17 años</td></tr>
              <tr><td>Jóvenes Jinetes</td><td>18-21 años</td></tr>
              <tr><td>Adultos</td><td>22+ años</td></tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">🏆 Sistema de equipos</h2>
        <p className="text-gray-700">
          Los equipos agrupan 3-4 binomios. La clasificación se calcula con la{' '}
          <strong>media de los 3 mejores %</strong> de cada equipo.
        </p>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">📈 Ver resultados</h2>
        <p className="text-gray-700 mb-2">Ve a <code className="bg-gray-100 px-2 py-1 rounded">/resultados</code>:</p>
        <ul className="list-disc pl-6 space-y-1 text-gray-700">
          <li><strong>Individual:</strong> clasificación por binomio</li>
          <li><strong>Equipos:</strong> clasificación por equipo</li>
          <li><strong>Auto-update:</strong> se actualiza en tiempo real</li>
        </ul>
      </section>
    </ManualLayout>
  );
}