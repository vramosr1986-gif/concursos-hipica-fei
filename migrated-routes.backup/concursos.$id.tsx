import { createFileRoute, Link } from "@tanstack/react-router";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useState } from "react";
import { ArrowLeft, Plus, Trash2 } from "lucide-react";
import { toast } from "sonner";

import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export const Route = createFileRoute("/concursos/$id")({
  head: () => ({
    meta: [
      { title: "Binomios del concurso — gestión hípica" },
      {
        name: "description",
        content:
          "Consulta y edita los binomios de un concurso: Nº, año, jinete y caballo.",
      },
      { property: "og:title", content: "Binomios del concurso" },
      {
        property: "og:description",
        content: "Consulta y edita los binomios de un concurso hípico.",
      },
    ],
  }),
  component: ConcursoDetalle,
});

function ConcursoDetalle() {
  const { id } = Route.useParams();
  const queryClient = useQueryClient();
  const [nuevo, setNuevo] = useState({
    numero: "",
    anio: String(new Date().getFullYear()),
    jinete: "",
    caballo: "",
  });

  const concurso = useQuery({
    queryKey: ["concurso", id],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("concursos")
        .select("id, nombre, fecha, lugar")
        .eq("id", id)
        .maybeSingle();
      if (error) throw error;
      return data;
    },
  });

  const binomios = useQuery({
    queryKey: ["binomios", id],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("binomios")
        .select("id, numero, anio, jinete, caballo")
        .eq("concurso_id", id)
        .order("created_at", { ascending: true });
      if (error) throw error;
      return data;
    },
  });

  const añadir = useMutation({
    mutationFn: async () => {
      const { error } = await supabase.from("binomios").insert({
        concurso_id: id,
        numero: nuevo.numero.trim() || null,
        anio: nuevo.anio ? Number(nuevo.anio) : null,
        jinete: nuevo.jinete.trim(),
        caballo: nuevo.caballo.trim(),
      });
      if (error) throw error;
    },
    onSuccess: () => {
      setNuevo((p) => ({ ...p, numero: "", jinete: "", caballo: "" }));
      queryClient.invalidateQueries({ queryKey: ["binomios", id] });
      queryClient.invalidateQueries({ queryKey: ["concursos"] });
    },
    onError: (e: Error) => toast.error(e.message),
  });

  const borrar = useMutation({
    mutationFn: async (binomioId: string) => {
      const { error } = await supabase
        .from("binomios")
        .delete()
        .eq("id", binomioId);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["binomios", id] });
      queryClient.invalidateQueries({ queryKey: ["concursos"] });
    },
    onError: (e: Error) => toast.error(e.message),
  });

  return (
    <main className="mx-auto max-w-4xl px-5 py-12">
      <Link
        to="/"
        className="inline-flex items-center gap-2 text-sm text-muted-foreground transition-colors hover:text-foreground"
      >
        <ArrowLeft className="size-4" /> Volver a concursos
      </Link>

      <h1 className="mt-6 font-display text-3xl font-semibold tracking-tight text-foreground">
        {concurso.data?.nombre ?? "Concurso"}
      </h1>
      <p className="mt-1 text-sm text-muted-foreground">
        {[concurso.data?.fecha, concurso.data?.lugar].filter(Boolean).join(" · ")}
      </p>

      <section className="mt-10 rounded-xl border border-border bg-card p-6 shadow-sm">
        <h2 className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
          Añadir binomio
        </h2>
        <div className="mt-4 grid gap-3 sm:grid-cols-[90px_90px_1fr_1fr_auto] sm:items-center">
          <Input
            aria-label="Número"
            placeholder="Nº"
            value={nuevo.numero}
            onChange={(e) => setNuevo((p) => ({ ...p, numero: e.target.value }))}
          />
          <Input
            aria-label="Año"
            inputMode="numeric"
            placeholder="Año"
            value={nuevo.anio}
            onChange={(e) => setNuevo((p) => ({ ...p, anio: e.target.value }))}
          />
          <Input
            aria-label="Jinete"
            placeholder="Jinete"
            value={nuevo.jinete}
            onChange={(e) => setNuevo((p) => ({ ...p, jinete: e.target.value }))}
          />
          <Input
            aria-label="Caballo"
            placeholder="Caballo"
            value={nuevo.caballo}
            onChange={(e) => setNuevo((p) => ({ ...p, caballo: e.target.value }))}
          />
          <Button
            onClick={() => añadir.mutate()}
            disabled={
              añadir.isPending || (!nuevo.jinete.trim() && !nuevo.caballo.trim())
            }
          >
            <Plus className="mr-1 size-4" /> Añadir
          </Button>
        </div>
      </section>

      <section className="mt-10">
        <h2 className="font-display text-xl font-semibold text-foreground">
          Binomios ({binomios.data?.length ?? 0})
        </h2>

        <div className="mt-4 overflow-hidden rounded-xl border border-border">
          <div className="grid grid-cols-[70px_80px_1fr_1fr_48px] gap-3 border-b border-border bg-muted px-4 py-3 text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            <span>Nº</span>
            <span>Año</span>
            <span>Jinete</span>
            <span>Caballo</span>
            <span />
          </div>
          {binomios.data?.length ? (
            binomios.data.map((b) => (
              <div
                key={b.id}
                className="grid grid-cols-[70px_80px_1fr_1fr_48px] items-center gap-3 border-b border-border px-4 py-3 text-sm last:border-b-0"
              >
                <span className="text-muted-foreground">{b.numero ?? "—"}</span>
                <span className="text-muted-foreground">{b.anio ?? "—"}</span>
                <span className="font-medium text-foreground">{b.jinete}</span>
                <span className="text-foreground">{b.caballo}</span>
                <Button
                  variant="ghost"
                  size="icon"
                  aria-label="Borrar binomio"
                  onClick={() => borrar.mutate(b.id)}
                >
                  <Trash2 className="size-4" />
                </Button>
              </div>
            ))
          ) : (
            <p className="px-4 py-6 text-sm text-muted-foreground">
              Este concurso no tiene binomios todavía.
            </p>
          )}
        </div>
      </section>
    </main>
  );
}
