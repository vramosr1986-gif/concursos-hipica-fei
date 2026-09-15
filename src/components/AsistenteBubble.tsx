'use client';

import { Bot, Send, Sparkles, User, X } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';

type Mensaje = { role: 'user' | 'assistant'; content: string };

const SUGERENCIAS = [
  '¿Cuándo es la próxima prueba?',
  '¿Quién lidera la temporada?',
  '¿Qué es la piaffe?',
  '¿Cuántas pruebas hay programadas?',
];

export default function AsistenteBubble() {
  const [abierto, setAbierto] = useState(false);
  const [mensajes, setMensajes] = useState<Mensaje[]>([
    {
      role: 'assistant',
      content:
        'Hola, soy el Asistente FEI. Preguntame sobre la web (concursos, horarios, notas, resultados, estadisticas) o sobre doma clasica y el reglamento FEI.',
    },
  ]);
  const [texto, setTexto] = useState('');
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');
  const panelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (abierto && panelRef.current) {
      panelRef.current.scrollTop = panelRef.current.scrollHeight;
    }
  }, [abierto, mensajes, cargando]);

  const enviar = async (contenido: string) => {
    const pregunta = contenido.trim();
    if (!pregunta || cargando) return;

    const historial: Mensaje[] = [...mensajes, { role: 'user', content: pregunta }];
    setMensajes(historial);
    setTexto('');
    setError('');
    setCargando(true);

    try {
      const res = await fetch('/api/asistente', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ mensajes: historial }),
      });
      const datos = await res.json();
      setMensajes((prev) => [
        ...prev,
        { role: 'assistant', content: datos?.respuesta || 'No he podido responder.' },
      ]);
    } catch {
      setMensajes((prev) => [
        ...prev,
        { role: 'assistant', content: 'No he podido procesar la pregunta ahora mismo. Intentalo en unos segundos.' },
      ]);
    } finally {
      setCargando(false);
    }
  };

  return (
    <div className="fixed bottom-4 right-4 z-[60] flex flex-col items-end gap-3 sm:bottom-6 sm:right-6">
      {abierto && (
        <div className="pointer-events-auto flex w-[min(96vw,30rem)] flex-col overflow-hidden rounded-2xl border border-[#dcd4c4] bg-white shadow-2xl">
          <div className="flex items-center justify-between gap-3 bg-[#173b2f] px-4 py-3 text-white">
            <div className="flex items-center gap-2.5">
              <span className="flex size-10 items-center justify-center rounded-full bg-[#b88746] text-white">
                <Bot className="size-5" aria-hidden="true" />
              </span>
              <div>
                <p className="text-base font-bold leading-tight">Asistente FEI</p>
                <p className="text-xs leading-tight text-white/70">
                  Solo la web y doma clasica
                </p>
              </div>
            </div>
            <button
              onClick={() => setAbierto(false)}
              aria-label="Cerrar asistente"
              className="rounded-full p-1.5 text-white/70 transition hover:bg-white/10 hover:text-white"
            >
              <X className="size-4" aria-hidden="true" />
            </button>
          </div>

          <div
            ref={panelRef}
            className="flex max-h-[72vh] min-h-40 flex-col gap-3 overflow-y-auto bg-[#f7f5f0] px-4 py-4"
          >
            {error && (
              <p className="rounded-lg bg-red-50 px-3 py-2 text-xs text-red-700">{error}</p>
            )}
            {mensajes.map((m, i) => (
              <div
                key={i}
                className={`flex gap-2 ${m.role === 'user' ? 'justify-end' : 'justify-start'}`}
              >
                {m.role === 'assistant' && (
                  <span className="mt-0.5 flex size-7 shrink-0 items-center justify-center rounded-full bg-[#e4dfd4] text-[#173b2f]">
                    <Bot className="size-4" aria-hidden="true" />
                  </span>
                )}
                <p
                  className={`max-w-[80%] whitespace-pre-wrap px-3 py-2 text-sm leading-6 ${
                    m.role === 'user'
                      ? 'rounded-2xl rounded-br-sm bg-[#173b2f] text-white'
                      : 'rounded-2xl rounded-bl-sm border border-[#e4dfd4] bg-white text-[#3c3c3c]'
                  }`}
                >
                  {m.content}
                </p>
                {m.role === 'user' && (
                  <span className="mt-0.5 flex size-7 shrink-0 items-center justify-center rounded-full bg-[#b88746] text-white">
                    <User className="size-4" aria-hidden="true" />
                  </span>
                )}
              </div>
            ))}
            {cargando && (
              <div className="flex items-center gap-2 pl-8">
                <span className="flex items-center gap-1 rounded-2xl bg-white px-3 py-2">
                  <span className="size-1.5 animate-bounce rounded-full bg-[#b88746]" />
                  <span className="size-1.5 animate-bounce rounded-full bg-[#b88746] [animation-delay:0.12s]" />
                  <span className="size-1.5 animate-bounce rounded-full bg-[#b88746] [animation-delay:0.24s]" />
                </span>
              </div>
            )}
          </div>

          <div className="border-t border-[#e4dfd4] bg-white p-2">
            {mensajes.length <= 1 && (
              <div className="mb-2 flex flex-wrap gap-1.5">
                {SUGERENCIAS.map((s) => (
                  <button
                    key={s}
                    onClick={() => enviar(s)}
                    disabled={cargando}
                    className="rounded-full border border-[#dcd4c4] bg-[#f7f5f0] px-3 py-1.5 text-xs text-[#173b2f] transition hover:border-[#b88746] hover:text-[#b88746]"
                  >
                    {s}
                  </button>
                ))}
              </div>
            )}
            <form
              onSubmit={(e) => {
                e.preventDefault();
                enviar(texto);
              }}
              className="flex items-center gap-2"
            >
              <input
                value={texto}
                onChange={(e) => setTexto(e.target.value)}
                placeholder="Pregunta sobre la web o doma FEI..."
                aria-label="Pregunta al asistente"
                className="min-w-0 flex-1 rounded-xl border border-[#dcd4c4] bg-[#f7f5f0] px-3 py-2.5 text-sm outline-none transition focus:border-[#b88746] focus:bg-white"
              />
              <button
                type="submit"
                disabled={cargando || !texto.trim()}
                aria-label="Enviar pregunta"
                className="flex size-10 shrink-0 items-center justify-center rounded-xl bg-[#173b2f] text-white transition hover:bg-[#0f2a21] disabled:cursor-not-allowed disabled:opacity-40"
              >
                <Send className="size-4" aria-hidden="true" />
              </button>
            </form>
          </div>
        </div>
      )}

      <button
        onClick={() => setAbierto((v) => !v)}
        aria-label={abierto ? 'Cerrar asistente' : 'Abrir asistente'}
        className="pointer-events-auto flex size-14 items-center justify-center rounded-full bg-[#173b2f] text-white shadow-lg ring-2 ring-[#e8c98d]/60 transition hover:scale-105 hover:bg-[#0f2a21]"
      >
        {abierto ? (
          <X className="size-6" aria-hidden="true" />
        ) : (
          <Sparkles className="size-6" aria-hidden="true" />
        )}
      </button>
    </div>
  );
}