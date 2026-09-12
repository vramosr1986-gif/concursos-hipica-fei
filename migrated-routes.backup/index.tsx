import { createFileRoute, Link } from "@tanstack/react-router";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useState } from "react";
import { Plus, Trash2, CalendarDays, MapPin } from "lucide-react";
import { toast } from "sonner";

import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Concursos hípicos — gestión de binomios" },
      {
        name: "description",
        content:
          "Crea concursos hípicos y registra sus binomios con Nº, año, jinete y caballo.",
      },
      { property: "og:title", content: "Concursos hípicos — gestión de binomios" },
      {
        property: "og:description",
        content:
          "Crea concursos hípicos y registra sus binomios con Nº, año, jinete y caballo.",
      },
    ],
  }),
  component: Home,
});

type BinomioDraft = {
  numero: string;
  anio: string;
  jinete: string;
  caballo: string;
};

const emptyBinomio = (anio: string): BinomioDraft => ({
  numero: "",
  anio,
  jinete: "",
  caballo: "",
});

function Home() {
  const queryClient = useQueryClient();
  const currentYear = String(new Date().getFullYear());

  const [nombre, setNombre] = useState("");
  const [fecha, setFecha] = useState("");
  const [lugar, setLugar] = useState("");
  const [binomios, setBinomios] = useState<BinomioDraft[]>([
    emptyBinomio(currentYear),
  ]);

  const concursos = useQuery({
    queryKey: ["concursos"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("concursos")
        .select("id, nombre, fecha, lugar, binomios(count)")
        .order("created_at", { ascending: false });
      if (error) throw error;
      return data;
    },
  });

  const crear = useMutation({
    mutationFn: async () => {
      const { data: concurso, error } = await supabase
        .from("concursos")
        .insert({
          nombre: nombre.trim(),
          fecha: fecha || null,
          lugar: lugar.trim() || null,
        })
        .select("id")
        .single();
      if (error) throw error;

      const filas = binomios
        .filter((b) => b.jinete.trim() || b.caballo.trim())
        .map((b) => ({
          concurso_id: concurso.id,
          numero: b.numero.trim() || null,
          anio: b.anio ? Number(b.anio) : null,
          jinete: b.jinete.trim(),
          caballo: b.caballo.trim(),
        }));

      if (filas.length > 0) {
        const { error: errBin } = await supabase.from("binomios").insert(filas);
        if (errBin) throw errBin;
      }
      return filas.length;
    },
    onSuccess: (n) => {
      toast.success(`Concurso guardado con ${n} binomio${n === 1 ? "" : "s"}`);
      setNombre("");
      setFecha("");
      setLugar("");
      setBinomios([emptyBinomio(currentYear)]);
      queryClient.invalidateQueries({ queryKey: ["concursos"] });
    },
    onError: (e: Error) => toast.error(e.message),
  });

  const updateBinomio = (i: number, campo: keyof BinomioDraft, valor: string) =>
    setBinomios((prev) =>
      prev.map((b, idx) => (idx === i ? { ...b, [campo]: valor } : b)),
    );

  return (
    <main className="mx-auto max-w-5xl px-5 py-12">
      <header className="border-b border-border pb-8">
        <p className="text-xs font-semibold uppercase tracking-[0.25em] text-primary">
          Hípica · cambio sincronizado
        </p>
        <h1 className="mt-2 font-display text-4xl font-semibold tracking-tight text-foreground">
          Concursos y binomios
        </h1>
        <p className="mt-2 max-w-xl text-sm text-muted-foreground">
          Da de alta un concurso y añade en la misma pantalla todos sus binomios:
          Nº, año, jinete y caballo.
        </p>
      </header>

      <section className="mt-10 rounded-xl border border-border bg-card p-6 shadow-sm">
        <h2 className="font-display text-xl font-semibold text-card-foreground">
          Nuevo concurso
        </h2>

        <div className="mt-5 grid gap-4 sm:grid-cols-3">
          <div className="space-y-2">
            <Label htmlFor="nombre">Nombre del concurso</Label>
            <Input
              id="nombre"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              placeholder="Concurso de Saltos de Primavera"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="fecha">Fecha</Label>
            <Input
              id="fecha"
              type="date"
              value={fecha}
              onChange={(e) => setFecha(e.target.value)}
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="lugar">Lugar</Label>
            <Input
              id="lugar"
              value={lugar}
              onChange={(e) => setLugar(e.target.value)}
              placeholder="Club Hípico"
            />
          </div>
        </div>

        <div className="mt-8">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Binomios
            </h3>
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() =>
                setBinomios((prev) => [...prev, emptyBinomio(currentYear)])
              }
            >
              <Plus className="mr-1 size-4" /> Añadir binomio
            </Button>
          </div>

          <div className="mt-4 space-y-3">
            <div className="hidden grid-cols-[90px_90px_1fr_1fr_40px] gap-3 px-1 text-xs font-semibold uppercase tracking-wide text-muted-foreground sm:grid">
              <span>Nº</span>
              <span>Año</span>
              <span>Jinete</span>
              <span>Caballo</span>
              <span />
            </div>

            {binomios.map((b, i) => (
              <div
                key={i}
                className="grid gap-3 rounded-lg border border-border bg-background p-3 sm:grid-cols-[90px_90px_1fr_1fr_40px] sm:items-center sm:border-0 sm:bg-transparent sm:p-0"
              >
                <Input
                  aria-label="Número"
                  placeholder="Nº"
                  value={b.numero}
                  onChange={(e) => updateBinomio(i, "numero", e.target.value)}
                />
                <Input
                  aria-label="Año"
                  inputMode="numeric"
                  placeholder="Año"
                  value={b.anio}
                  onChange={(e) => updateBinomio(i, "anio", e.target.value)}
                />
                <Input
                  aria-label="Jinete"
                  placeholder="Jinete"
                  value={b.jinete}
                  onChange={(e) => updateBinomio(i, "jinete", e.target.value)}
                />
                <Input
                  aria-label="Caballo"
                  placeholder="Caballo"
                  value={b.caballo}
                  onChange={(e) => updateBinomio(i, "caballo", e.target.value)}
                />
                <Button
                  type="button"
                  variant="ghost"
                  size="icon"
                  aria-label="Quitar binomio"
                  onClick={() =>
                    setBinomios((prev) =>
                      prev.length === 1
                        ? [emptyBinomio(currentYear)]
                        : prev.filter((_, idx) => idx !== i),
                    )
                  }
                >
                  <Trash2 className="size-4" />
                </Button>
              </div>
            ))}
          </div>
        </div>

        <div className="mt-8 flex items-center gap-3">
          <Button
            onClick={() => crear.mutate()}
            disabled={!nombre.trim() || crear.isPending}
          >
            {crear.isPending ? "Guardando…" : "Guardar concurso"}
          </Button>
          <span className="text-xs text-muted-foreground">
            Los binomios vacíos se ignoran.
          </span>
        </div>
      </section>

      <section className="mt-12">
        <h2 className="font-display text-xl font-semibold text-foreground">
          Concursos creados
        </h2>

        {concursos.isLoading ? (
          <p className="mt-4 text-sm text-muted-foreground">Cargando…</p>
        ) : concursos.data && concursos.data.length > 0 ? (
          <ul className="mt-4 grid gap-3 sm:grid-cols-2">
            {concursos.data.map((c) => (
              <li key={c.id}>
                <Link
                  to="/concursos/$id"
                  params={{ id: c.id }}
                  className="block rounded-xl border border-border bg-card p-5 transition-colors hover:border-primary"
                >
                  <p className="font-display text-lg font-semibold text-card-foreground">
                    {c.nombre}
                  </p>
                  <div className="mt-2 flex flex-wrap gap-4 text-xs text-muted-foreground">
                    {c.fecha && (
                      <span className="inline-flex items-center gap-1">
                        <CalendarDays className="size-3.5" />
                        {c.fecha}
                      </span>
                    )}
                    {c.lugar && (
                      <span className="inline-flex items-center gap-1">
                        <MapPin className="size-3.5" />
                        {c.lugar}
                      </span>
                    )}
                  </div>
                  <p className="mt-3 text-sm text-primary">
                    {c.binomios?.[0]?.count ?? 0} binomios
                  </p>
                </Link>
              </li>
            ))}
          </ul>
        ) : (
          <p className="mt-4 text-sm text-muted-foreground">
            Todavía no hay concursos.
          </p>
        )}
      </section>
    </main>
  );
}
