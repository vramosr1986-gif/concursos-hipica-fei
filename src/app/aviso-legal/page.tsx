import Link from 'next/link';

export const metadata = { title: 'Aviso legal · Concursos de Doma Clásica' };

export default function AvisoLegalPage() {
  return (
    <div className="container max-w-3xl py-8">
      <h1 className="text-3xl font-bold mb-6">Aviso legal</h1>

      <div className="card p-8 space-y-6 text-sm leading-6 text-gray-700">
        <section>
          <h2 className="text-lg font-bold text-gray-900">1. Titular del sitio web</h2>
          <p>
            En cumplimiento del artículo 10 de la Ley 34/2002, de Servicios de la Sociedad de la
            Información y de Comercio Electrónico (LSSI-CE), se informa de que el titular de este
            sitio web es:
          </p>
          <ul className="mt-2 list-disc pl-5">
            <li>Titular: [COMPLETAR: nombre o razón social]</li>
            <li>NIF/CIF: [COMPLETAR]</li>
            <li>Domicilio: [COMPLETAR]</li>
            <li>Correo electrónico de contacto: [COMPLETAR]</li>
          </ul>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">2. Objeto</h2>
          <p>
            Esta plataforma permite gestionar y consultar concursos de doma clásica: calendario de
            pruebas, binomios inscritos, puntuaciones de los jueces y clasificaciones. El acceso a
            las secciones públicas es libre y gratuito. Las secciones de administración y de jueces
            requieren una cuenta creada por el titular.
          </p>
          <p className="mt-2">
            Este sitio es independiente y no es un sitio oficial de la Real Federación Hípica
            Española (RFHE) ni de la Fédération Équestre Internationale (FEI)
            [COMPLETAR/CONFIRMAR]. Las referencias a reglamentos, reprises o federaciones se hacen
            solo a título informativo.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">3. Condiciones de uso</h2>
          <p>
            El usuario se compromete a hacer un uso lícito de la web, a no intentar acceder a
            áreas restringidas sin autorización y a no alterar su funcionamiento. El titular puede
            suspender o modificar el servicio, y bloquear cuentas que incumplan estas condiciones.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">4. Exactitud de la información</h2>
          <p>
            Los resultados y clasificaciones se publican a medida que se introducen las
            puntuaciones y pueden corregirse. Los datos oficiales de cada concurso son los
            publicados por la federación o el comité organizador correspondiente. El titular no
            responde de errores u omisiones ni de las decisiones tomadas a partir de esta
            información.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">5. Enlaces a terceros</h2>
          <p>
            La web puede enlazar a páginas de terceros, como los buscadores de licencias o el
            calendario de la RFHE. El titular no controla ni se responsabiliza de su contenido ni
            de sus políticas de privacidad.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">6. Propiedad intelectual</h2>
          <p>
            El diseño, el código y los contenidos propios de la web pertenecen al titular. Las
            reprises, reglamentos, marcas y logotipos de la RFHE, la FEI y otras entidades son de
            sus respectivos propietarios. No se permite su reproducción o explotación sin
            autorización de los titulares de los derechos.
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">7. Protección de datos</h2>
          <p>
            El tratamiento de datos personales se describe en la{' '}
            <Link href="/privacidad" className="text-primary underline">
              Política de privacidad
            </Link>
            .
          </p>
        </section>

        <section>
          <h2 className="text-lg font-bold text-gray-900">8. Legislación y jurisdicción</h2>
          <p>
            Este aviso se rige por la legislación española. Para cualquier controversia, las
            partes se someten a los juzgados y tribunales que correspondan conforme a la
            normativa aplicable.
          </p>
        </section>

        <p className="text-xs text-gray-500">Última actualización: [COMPLETAR: fecha]</p>
      </div>
    </div>
  );
}
