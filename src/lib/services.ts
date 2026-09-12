import { supabase } from './supabase';
import { Concurso, Jornada, Binomio, Juez, Puntuacion } from '@/types';

// Concursos
export const concursoService = {
  async getAll() {
    const { data, error } = await supabase
      .from('concursos')
      .select('*')
      .order('fecha_inicio', { ascending: false });
    return { data: data as Concurso[], error };
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('concursos')
      .select('*')
      .eq('id', id)
      .single();
    return { data: data as Concurso, error };
  },

  async create(concurso: Omit<Concurso, 'id' | 'created_at'>) {
    const { data, error } = await supabase
      .from('concursos')
      .insert([concurso])
      .select()
      .single();
    return { data: data as Concurso, error };
  },

  async update(id: string, concurso: Partial<Concurso>) {
    const { data, error } = await supabase
      .from('concursos')
      .update(concurso)
      .eq('id', id)
      .select()
      .single();
    return { data: data as Concurso, error };
  },

  async delete(id: string) {
    const { error } = await supabase.from('concursos').delete().eq('id', id);
    return { error };
  },
};

// Jornadas
export const jornadaService = {
  async getByConcurso(concursoId: string) {
    const { data, error } = await supabase
      .from('jornadas')
      .select('*')
      .eq('concurso_id', concursoId)
      .order('fecha', { ascending: true });
    return { data: data as Jornada[], error };
  },

  async create(jornada: Omit<Jornada, 'id' | 'created_at'>) {
    const { data, error } = await supabase
      .from('jornadas')
      .insert([jornada])
      .select()
      .single();
    return { data: data as Jornada, error };
  },

  async delete(id: string) {
    const { error } = await supabase.from('jornadas').delete().eq('id', id);
    return { error };
  },
};

// Binomios
export const binomioService = {
  async getByConcurso(concursoId: string) {
    const { data, error } = await supabase
      .from('binomios')
      .select('*')
      .eq('concurso_id', concursoId)
      .order('dorsal', { ascending: true });
    return { data: data as Binomio[], error };
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('binomios')
      .select('*')
      .eq('id', id)
      .single();
    return { data: data as Binomio, error };
  },

  async create(binomio: Omit<Binomio, 'id' | 'created_at'>) {
    const { data, error } = await supabase
      .from('binomios')
      .insert([binomio])
      .select()
      .single();
    return { data: data as Binomio, error };
  },

  async update(id: string, binomio: Partial<Binomio>) {
    const { data, error } = await supabase
      .from('binomios')
      .update(binomio)
      .eq('id', id)
      .select()
      .single();
    return { data: data as Binomio, error };
  },

  async delete(id: string) {
    const { error } = await supabase.from('binomios').delete().eq('id', id);
    return { error };
  },
};

// Jueces
export const juezService = {
  async getByConcurso(concursoId: string) {
    const { data, error } = await supabase
      .from('jueces')
      .select('*')
      .eq('concurso_id', concursoId)
      .order('letra_oficial', { ascending: true });
    return { data: data as Juez[], error };
  },

  async create(juez: Omit<Juez, 'id' | 'created_at'>) {
    const { data, error } = await supabase
      .from('jueces')
      .insert([juez])
      .select()
      .single();
    return { data: data as Juez, error };
  },

  async delete(id: string) {
    const { error } = await supabase.from('jueces').delete().eq('id', id);
    return { error };
  },
};

// Puntuaciones
export const puntuacionService = {
  async getByCompetencia(competenciaId: string) {
    const { data, error } = await supabase
      .from('puntuaciones')
      .select('*')
      .eq('competencia_id', competenciaId);
    return { data: data as Puntuacion[], error };
  },

  async create(puntuacion: Omit<Puntuacion, 'id' | 'created_at' | 'updated_at'>) {
    const { data, error } = await supabase
      .from('puntuaciones')
      .insert([puntuacion])
      .select()
      .single();
    return { data: data as Puntuacion, error };
  },

  async update(id: string, puntuacion: Partial<Puntuacion>) {
    const { data, error } = await supabase
      .from('puntuaciones')
      .update(puntuacion)
      .eq('id', id)
      .select()
      .single();
    return { data: data as Puntuacion, error };
  },
};

// Reprises
export const reprisesService = {
  async getAll() {
    const { data, error } = await supabase
      .from('reprises')
      .select('*')
      .order('fei_numero', { ascending: true });
    return { data, error };
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('reprises')
      .select('*')
      .eq('id', id)
      .single();
    return { data, error };
  },
};

// Competencias (binomio en jornada-reprise, con notas agrupadas por jornada)
export const competenciaService = {
  async getByBinomio(binomioId: string) {
    const { data, error } = await supabase
      .from('competencias')
      .select(
        `
        id,
        estado,
        orden_salida,
        hora_salida,
        jornada_reprise:jornada_reprise_id (
          id,
          orden,
          hora_salida,
          pista,
          jornada:jornada_id ( id, numero, fecha, pista ),
          reprise:reprise_id ( id, numero, nombre, fei_numero, nivel, desviacion, multiplicador )
        ),
        puntuaciones (
          id,
          juez_id,
          letra_juez,
          notas,
          puntuacion_final
        )
      `
      )
      .eq('binomio_id', binomioId);
    return { data, error };
  },
};
