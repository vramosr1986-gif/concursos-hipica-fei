import Link from 'next/link';

export const metadata = { title: 'Política de privacidad · Concursos de Doma Clásica' };

export default function PrivacidadPage() {
  return (
    <div className="container max-w-3xl py-8">
      <h1 className="text-3xl font-bold mb-6">Política de privacidad</h1>

      <div className="card p-8 space-y-6 text-sm leading-6 text-gray-700">
        <section>
          <h2 className="text-lg font-bold text-gray-900">1. Responsable del tratamiento</h2>
          <ul className="list-disc pl-5">
            <li>Responsable: [COMPLETAR: nombre o razón social]</li>
            <li>NIF/CIF: [COMPLETAR]</li>
            <li>Domicilio: [COMPLETAR]</li>
            <li>Correo electrónico: [COMPLETAR]</li>
          </ul>
          <p className="mt-2">
            Tratamos los datos conforme al Reglamento (UE) 2016/679 (RGPD) y a la Ley Orgánica
            3/2018 (LOPDGDD).
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">2. Qué datos tratamos y para qué</h2>
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead>
                <tr className="border-b">
                  <th className="py-2 pr-4">Datos</th>
                  <th className="py-2 pr-4">Finalidad</th>
                  <th className="py-2">Base jurídica</th>
                </tr>
              </thead>
              <tbody className="align-top">
                <tr className="border-b">
                  <td className="py-2 pr-4">
                    Nombre del jinete, nombre del caballo, número de licencia, dorsal, categoría y
                    fecha de nacimiento
                  </td>
                  <td className="py-2 pr-4">
                    Gestionar inscripciones y calcular la categoría en los concursos
                  </td>
                  <td className="py-2">[COMPLETAR: p. ej., interés legítimo del organizador / ejecución de la inscripción]</td>
                </tr>
                <tr className="border-b">
                  <td className="py-2 pr-4">Puntuaciones y clasificaciones</td>
                  <td className="py-2 pr-4">Publicar resultados de las pruebas</td>
                  <td className="py-2">[COMPLETAR: p. ej., interés legítimo en la difusión de resultados deportivos]</td>
                </tr>
                <tr className="border-b">
                  <td className="py-2 pr-4">Correo electrónico, nombre y rol de las cuentas de jueces y administradores</td>
                  <td className="py-2 pr-4">Autenticación y control de acceso</td>
                  <td className="py-2">Ejecución de la relación con el usuario</td>
                </tr>
                <tr>
                  <td className="py-2 pr-4">Datos técnicos de la sesión (identificador de sesión)</td>
                  <td className="py-2 pr-4">Mantener la sesión iniciada y garantizar la seguridad</td>
                  <td className="py-2">Interés legítimo en la seguridad del servicio</td>
                </tr>
              </tbody>
            </table>
          </div>
          <p className="mt-2">
            En el panel público solo se muestran nombre del jinete, nombre del caballo, dorsal y
            puntuaciones. La fecha de nacimiento no se publica.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">3. Menores de edad</h2>
          <p>
            Participan menores en categorías como alevín, infantil o juvenil. Los datos de menores
            solo se tratan para su participación en el concurso. Para los menores de 14 años se
            requiere el consentimiento de sus padres o tutores legales
            [COMPLETAR: indicar cómo se recoge].
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">4. Destinatarios y encargados</h2>
          <p>No vendemos ni cedemos los datos. Para prestar el servicio usamos proveedores que actúan como encargados del tratamiento:</p>
          <ul className="mt-2 list-disc pl-5">
            <li>Supabase: base de datos y autenticación [COMPLETAR: región del proyecto].</li>
            <li>Vercel: alojamiento de la aplicación web.</li>
          </ul>
          <p className="mt-2">
            Si algún proveedor trata datos fuera del Espacio Económico Europeo, lo hace con las
            garantías previstas en el RGPD, como las cláusulas contractuales tipo
            [COMPLETAR/CONFIRMAR con los contratos de cada proveedor].
          </p>
          <p className="mt-2">
            Los resultados publicados son visibles para cualquier visitante de la web.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">5. Conservación</h2>
          <p>
            Conservamos los datos mientras sean necesarios para la finalidad indicada y, después,
            durante los plazos de prescripción de posibles responsabilidades
            [COMPLETAR: p. ej., resultados históricos de concursos y plazo de las cuentas].
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">6. Derechos</h2>
          <p>
            Puedes ejercer los derechos de acceso, rectificación, supresión, oposición, limitación
            del tratamiento y portabilidad escribiendo a la dirección de contacto indicada
            arriba, identificándote adecuadamente. Si consideras que no hemos atendido tus
            derechos, puedes reclamar ante la Agencia Española de Protección de Datos
            (<a href="https://www.aepd.es" target="_blank" rel="noopener noreferrer" className="text-primary underline">www.aepd.es</a>).
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">7. Cookies y almacenamiento local</h2>
          <p>
            Esta web usa únicamente almacenamiento técnico en tu navegador para mantener la
            sesión iniciada de los usuarios con cuenta. Es necesario para el funcionamiento del
            servicio y no requiere consentimiento. No usamos cookies publicitarias ni de
            analítica [COMPLETAR/CONFIRMAR].
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">8. Seguridad</h2>
          <p>
            Aplicamos medidas técnicas y organizativas razonables: acceso restringido por roles,
            comunicaciones cifradas y control de permisos en la base de datos.
          </p>
        </section>

        <p>
          Consulta también el{' '}
          <Link href="/aviso-legal" className="text-primary underline">
            Aviso legal
          </Link>
          .
        </p>
        <p className="text-xs text-gray-500">Última actualización: [COMPLETAR: fecha]</p>
      </div>
    </div>
  );
}
