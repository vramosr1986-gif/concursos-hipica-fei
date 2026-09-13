'use client';

import ManualLayout from '@/components/ManualLayout';

export default function ManualJuezPage() {
  return (
    <ManualLayout
      titulo="Manual del Juez"
      emoji="⚖️"
      color="amber"
      archivoMd="MANUAL_JUEZ.md"
    >
      <section>
        <h2 className="text-2xl font-bold mb-3">🔐 Acceso</h2>
        <ol className="list-decimal pl-6 space-y-2 text-gray-700">
          <li>Ve a <code className="bg-gray-100 px-2 py-1 rounded">/login</code></li>
          <li>Introduce tu email y contraseña</li>
        </ol>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">📋 Ver tus pruebas</h2>
        <ol className="list-decimal pl-6 space-y-2 text-gray-700">
          <li>Ve a <code className="bg-gray-100 px-2 py-1 rounded">/juez</code></li>
          <li>Verás las pruebas donde estás asignado</li>
          <li>Cada tarjeta muestra: letra, prueba, reprise, fecha, binomios</li>
        </ol>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">⚖️ Puntuar una prueba</h2>
        <ol className="list-decimal pl-6 space-y-2 text-gray-700">
          <li>Pulsa <strong>&quot;Puntuar&quot;</strong> en una prueba</li>
          <li>Pulsa en un binomio para empezar</li>
          <li>Introduce una nota de 0 a 10 por ejercicio</li>
          <li>Las notas se guardan automáticamente</li>
        </ol>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">📊 Escala FEI</h2>
        <div className="overflow-x-auto">
          <table className="table w-full">
            <thead>
              <tr><th>Nota</th><th>Significado</th></tr>
            </thead>
            <tbody>
              <tr><td>10</td><td>Excelente</td></tr>
              <tr><td>8</td><td>Bien</td></tr>
              <tr><td>6</td><td>Satisfactorio</td></tr>
              <tr><td>4</td><td>Insuficiente</td></tr>
              <tr><td>0</td><td>No ejecutado</td></tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">🏆 Puntuar pruebas de equipos</h2>
        <ol className="list-decimal pl-6 space-y-2 text-gray-700">
          <li>Verás <strong>pestañas por equipo</strong> (🏆 Andalucía, 🏆 Madrid, 👤 Sin equipo)</li>
          <li>Dentro de cada equipo, <strong>pestañas por miembro</strong></li>
          <li>Puntúa a cada miembro individualmente</li>
          <li>La clasificación del equipo se calcula automáticamente</li>
        </ol>
      </section>

      <hr className="my-6" />

      <section>
        <h2 className="text-2xl font-bold mb-3">❓ FAQ</h2>
        <div className="space-y-3 text-gray-700">
          <div>
            <p className="font-bold">¿Puedo editar una nota?</p>
            <p className="text-sm">Sí, vuelve a entrar y cambia la nota.</p>
          </div>
          <div>
            <p className="font-bold">¿Los resultados son en tiempo real?</p>
            <p className="text-sm">Sí, con Supabase Realtime.</p>
          </div>
        </div>
      </section>
    </ManualLayout>
  );
}