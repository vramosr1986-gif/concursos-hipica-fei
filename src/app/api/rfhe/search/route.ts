import { NextRequest, NextResponse } from 'next/server';

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

    const response = await fetch('https://www.cbservicios.net/Magic94Scripts/mgrqispi94.dll', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
      body: formData.toString(),
    });

    if (!response.ok) {
      return NextResponse.json(
        { error: `RFHE retornó error ${response.status}` },
        { status: 500 }
      );
    }

    const html = await response.text();

    // Parse HTML manualmente buscando tablas y filas
    const rows: RFHEResult[] = [];
    
    // Buscar todas las filas de tabla <tr>
    const trMatches = html.match(/<tr[^>]*>[\s\S]*?<\/tr>/gi) || [];
    
    let skipHeader = true;
    for (const trHtml of trMatches) {
      // Extraer celdas
      const tdMatches = trHtml.match(/<td[^>]*>([\s\S]*?)<\/td>/gi) || [];
      
      if (skipHeader && tdMatches.length > 0) {
        // Detectar si es header por contenido
        const firstCellContent = (tdMatches[0] || '').replace(/<[^>]+>/g, '').trim();
        if (firstCellContent === 'LDN' || firstCellContent === 'LAC' || firstCellContent === 'DIN') {
          continue;
        }
        skipHeader = false;
      }

      if (tdMatches.length < 5) continue;

      // Limpiar HTML y extraer texto
      const cleanText = (html: string) => {
        return html
          .replace(/<[^>]+>/g, '')
          .replace(/&nbsp;/g, ' ')
          .replace(/&amp;/g, '&')
          .trim();
      };

      const ldn = cleanText(tdMatches[0] || '');
      const ano = cleanText(tdMatches[1] || '');
      const nombre = cleanText(tdMatches[2] || '');
      const categoria = cleanText(tdMatches[3] || '');
      const identificacion = cleanText(tdMatches[4] || '');
      const nacimiento = cleanText(tdMatches[5] || '');

      // Validar que tenga LDN/LAC válido
      if (ldn && nombre && !ldn.includes('LDN') && !ldn.includes('LAC')) {
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
