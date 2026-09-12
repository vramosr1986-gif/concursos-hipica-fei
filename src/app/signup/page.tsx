'use client';

import Link from 'next/link';

export default function SignupPage() {
  return (
    <div className="container flex justify-center items-center min-h-[calc(100vh-8rem)]">
      <div className="card p-8 w-full max-w-md text-center">
        <h1 className="text-2xl font-bold mb-4">Registro deshabilitado</h1>
        <p className="text-gray-600 mb-6">
          El registro público no está disponible. Las cuentas de juez y administrador
          son creadas únicamente por un administrador desde el panel de gestión de usuarios.
        </p>
        <Link href="/login" className="btn btn-primary">
          Ir a Iniciar Sesión
        </Link>
      </div>
    </div>
  );
}

