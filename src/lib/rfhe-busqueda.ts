// Abre en otra pestaña las búsquedas públicas de la RFHE ya hechas, enviando
// el mismo formulario que su web (POST a CashBox).
const ENDPOINT = 'https://www.cbservicios.net/Magic94Scripts/mgrqispi94.dll?';

function enviarFormulario(campos: Record<string, string>) {
  const ventana = `rfhe-${Date.now()}`;
  window.open('', ventana);
  const form = document.createElement('form');
  form.method = 'POST';
  form.action = ENDPOINT;
  form.target = ventana;
  for (const [name, value] of Object.entries(campos)) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    form.appendChild(input);
  }
  document.body.appendChild(form);
  form.submit();
  form.remove();
}

/** Jinetes: la RFHE busca por apellidos ("Apellido Apellido, Nombre" → lo de antes de la coma). */
export function buscarJineteEnRfhe(nombre: string) {
  enviarFormulario({
    APPNAME: 'CBRFHE',
    PRGNAME: 'RFHEBUSJIN02',
    ARGUMENTS: 'APE,FIN',
    FIN: 'FIN',
    APE: nombre.split(',')[0]?.trim() || nombre.trim(),
  });
}

/** Caballos: busca por nombre, de cualquier edad. */
export function buscarCaballoEnRfhe(nombre: string) {
  enviarFormulario({
    APPNAME: 'CBRFHE',
    PRGNAME: 'RFHEBUSCAB02',
    ARGUMENTS: 'NOM,EDD,EDH,FIN',
    FIN: 'FIN',
    NOM: nombre.trim(),
    EDD: '0',
    EDH: '999',
  });
}
