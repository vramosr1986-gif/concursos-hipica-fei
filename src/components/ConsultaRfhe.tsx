const BASE = 'https://www.cbservicios.net/Magic94Scripts/Mgrqispi94.dll?APPNAME=CBRFHE&PRGNAME=';

const ENLACES = [
  { etiqueta: 'LDN del jinete', url: BASE + 'RFHEBUSJIN' },
  { etiqueta: 'LAC del caballo', url: BASE + 'RFHEBUSCAB' },
];

export function ConsultaRfhe() {
  return (
    <div className="mt-2 flex flex-wrap items-center gap-2 text-xs">
      <span className="text-gray-500">Comprobar en la RFHE:</span>
      {ENLACES.map((e) => (
        <a
          key={e.url}
          href={e.url}
          target="_blank"
          rel="noopener noreferrer"
          className="rounded border px-2 py-1 text-primary hover:bg-gray-50"
        >
          {e.etiqueta}
        </a>
      ))}
    </div>
  );
}
