'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';

export default function NuevoJuezPage() {
  const router = useRouter();

  useEffect(() => {
    // Redirige al formulario de crear usuario con rol=juez preseleccionado
    router.replace('/admin/usuarios/nuevo?rol=juez');
  }, [router]);

  return (
    <div className="container py-8 text-center text-gray-600">
      Redirigiendo a crear usuario...
    </div>
  );
}
