$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\resultados\page.tsx"

$bak = "$f.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item -LiteralPath $f -Destination $bak -Force
Write-Host "Backup: $bak" -ForegroundColor Green

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))

$thViejo = '<th className="text-right w-28">%</th>'
$thNuevo = '<th className="text-right w-28">%</th>' + "`r`n" + '                            <th className="text-center w-28"></th>'

if ($c.Contains($thViejo)) {
    $c = $c.Replace($thViejo, $thNuevo)
    Write-Host "OK: th anadido" -ForegroundColor Green
}

$marcaIni = '{prueba.equipos.map((eq) => ('
$marcaFin = '</tbody>'
$i1 = $c.IndexOf($marcaIni)
$i2 = $c.IndexOf($marcaFin, $i1)

if ($i1 -lt 0 -or $i2 -lt 0) {
    Write-Host "ERROR: marcadores no encontrados" -ForegroundColor Red
    return
}

$nuevo = @'
{prueba.equipos.map((eq) => (
                            <Fragment key={eq.equipo_id}>
                              {eq.miembros.map((m, idx) => {
                                const participacionDetalle = prueba.clasificaciones.find(
                                  (c) => c.dorsal === m.dorsal && c.jinete === m.nombre_jinete
                                );
                                const keyDetalle = eq.equipo_id + '-det-' + m.dorsal;
                                const abiertoEq = expandidos.includes(keyDetalle);
                                return (
                                  <Fragment key={eq.equipo_id + '-' + m.posicion_miembro}>
                                    <tr className={idx === 0 ? colorPuesto(eq.posicion_equipo) : ''}>
                                      {idx === 0 && (
                                        <td className="text-center font-bold align-top" rowSpan={eq.miembros.length}>
                                          {medallaEmoji(eq.posicion_equipo)} {eq.posicion_equipo}º
                                        </td>
                                      )}
                                      {idx === 0 && (
                                        <td className="font-bold align-top" rowSpan={eq.miembros.length}>
                                          {eq.equipo_nombre}
                                          <div className="text-lg font-bold text-teal-700 mt-1">
                                            {eq.puntuacion_equipo.toFixed(2)}%
                                          </div>
                                        </td>
                                      )}
                                      <td className="text-center text-gray-500">{m.posicion_miembro}</td>
                                      <td>{m.nombre_jinete}</td>
                                      <td>{m.nombre_caballo}</td>
                                      <td className="text-right font-bold">{m.porcentaje.toFixed(2)}%</td>
                                      <td className="text-center">
                                        {participacionDetalle && participacionDetalle.ejercicios.length > 0 ? (
                                          <button
                                            onClick={() => setExpandidos((prev) => abiertoEq ? prev.filter((x) => x !== keyDetalle) : [...prev, keyDetalle])}
                                            className="text-primary hover:underline text-sm font-medium"
                                          >
                                            {abiertoEq ? 'Ocultar' : 'Ver detalle'}
                                          </button>
                                        ) : (
                                          <span className="text-xs text-gray-400">-</span>
                                        )}
                                      </td>
                                    </tr>
                                    {abiertoEq && participacionDetalle && (
                                      <tr>
                                        <td colSpan={7} className="bg-blue-50 p-4">
                                          <h4 className="font-bold mb-2">Detalle por ejercicio · {m.nombre_jinete} / {m.nombre_caballo}</h4>
                                          <div className="table-responsive">
                                            <table className="table text-sm">
                                              <thead>
                                                <tr>
                                                  <th className="text-center w-14">N</th>
                                                  <th className="w-16">Letra</th>
                                                  <th>Movimiento</th>
                                                  <th className="text-center w-16">Coef</th>
                                                  {letrasJueces.map((l) => (<th key={l} className="text-center w-20">{l}</th>))}
                                                  <th className="text-center w-24">Media</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                {participacionDetalle.ejercicios.map((ej) => {
                                                  const notas = letrasJueces.map((l) => ej.notas[l]).filter((n) => n !== undefined) as number[];
                                                  const mediaEj = notas.length > 0 ? notas.reduce((a, b) => a + b, 0) / notas.length : 0;
                                                  return (
                                                    <tr key={ej.id}>
                                                      <td className="text-center font-bold">{ej.numero_orden}</td>
                                                      <td className="font-mono text-xs">{ej.letra || '-'}</td>
                                                      <td className="text-xs">{ej.descripcion}</td>
                                                      <td className="text-center">{ej.coeficiente > 1 ? 'x' + ej.coeficiente : '1'}</td>
                                                      {letrasJueces.map((l) => (<td key={l} className="text-center">{ej.notas[l] !== undefined ? ej.notas[l].toFixed(1) : '-'}</td>))}
                                                      <td className="text-center font-bold">{mediaEj.toFixed(2)}</td>
                                                    </tr>
                                                  );
                                                })}
                                              </tbody>
                                              <tfoot>
                                                <tr className="bg-gray-100 border-t-2 font-bold">
                                                  <td colSpan={4} className="text-right pr-2">SUMA:</td>
                                                  {letrasJueces.map((l) => {
                                                    const punt = participacionDetalle.puntuaciones.find((p) => p.letra === l);
                                                    return (<td key={l} className="text-center">{punt ? punt.puntuacion.toFixed(2) + '%' : '-'}</td>);
                                                  })}
                                                  <td className="text-center text-blue-700">{participacionDetalle.media.toFixed(2)}%</td>
                                                </tr>
                                              </tfoot>
                                            </table>
                                          </div>
                                        </td>
                                      </tr>
                                    )}
                                  </Fragment>
                                );
                              })}
                            </Fragment>
                          ))}
'@

$c = $c.Substring(0, $i1) + $nuevo + $c.Substring($i2)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "=== VERIFICACION ===" -ForegroundColor Cyan
$d = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
Write-Host "participacionDetalle: $($d -match 'participacionDetalle')"
Write-Host "keyDetalle:           $($d -match 'keyDetalle')"
Write-Host "colSpan=7:            $($d -match 'colSpan=\{7\}')"
Write-Host "text-center w-28:     $($d -match 'text-center w-28')"