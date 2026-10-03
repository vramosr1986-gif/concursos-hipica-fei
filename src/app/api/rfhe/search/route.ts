import { NextRequest, NextResponse } from 'next/server';
import { JSDOM } from 'jsdom';

interface RFHEResult {
  ldn: string;
  ano: string;
  nombre: string;
  categoria: string;
  identificacion: string;
  nacimiento: string;
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { apellidos, tipo } = body;

    if (!apellidos || !tipo) {
      return NextResponse.json({ error: 'Faltan parámetros' }, { status: 400 });
    }

    const prgname = tipo === 'jinete' ? 'RFHEBUSJIN02' : 'RFHEBUSCAB02';

    // Hacer POST a RFHE
    const formData = new URLSearchParams();
    formData.append('APPNAME', 'CBRFHE');
    formData.append('PRGNAME', prgname);
    formData.append('ARGUMENTS', tipo === 'jinete' ? 'APE,FIN' : 'NOMBRE,FIN');
    formData.append('FIN', 'FIN');
    formData.append(tipo === 'jinete' ? 'APE' : 'NOMBRE', apellidos);

    const response = await fetch('https://www.cbservicios.net/Magic94Scripts/mgrqispi94.dll?', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
      body: formData.toString(),
    });

    const html = await response.text();

    // Parse HTML con JSDOM
    const dom = new JSDOM(html);
    const { document } = dom.window;

    const rows: RFHEResult[] = [];
    const tables = document.querySelectorAll('table');

    // Buscar tabla con resultados (generalmente la segunda tabla)
    for (const table of tables) {
      const tbody = table.querySelector('tbody');
      if (!tbody) continue;

      const trs = tbody.querySelectorAll('tr');
      let isHeaderRow = true;

      for (const tr of trs) {
        if (isHeaderRow) {
          // Verificar si es header (contiene th o no tiene datos)
          const hasHeader = tr.querySelector('th');
          if (hasHeader) {
            isHeaderRow = true;
            continue;
          }
          isHeaderRow = false;
        }

        const tds = tr.querySelectorAll('td');
        if (tds.length < 5) continue;

        // Estructura: LDN | AÑO | NOMBRE | CATEGORÍA | IDENTIFICACIÓN | NACIMIENTO
        const ldn = tds[0]?.textContent?.trim() || '';
        const ano = tds[1]?.textContent?.trim() || '';
        const nombre = tds[2]?.textContent?.trim() || '';
        const categoria = tds[3]?.textContent?.trim() || '';
        const identificacion = tds[4]?.textContent?.trim() || '';
        const nacimiento = tds[5]?.textContent?.trim() || '';

        if (ldn && nombre) {
          rows.push({
            ldn,
            ano,
            nombre,
            categoria,
            identificacion,
            nacimiento,
          });
        }
      }

      if (rows.length > 0) break;
    }

    return NextResponse.json({
      tipo,
      apellidos,
      resultados: rows,
      total: rows.length,
    });
  } catch (error: any) {
    console.error('Error en búsqueda RFHE:', error);
    return NextResponse.json(
      { error: error.message || 'Error al consultar RFHE' },
      { status: 500 }
    );
  }
}
