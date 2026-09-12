import './admin-modern.css';
import React from 'react';

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="admin-page-container">
      {children}
    </div>
  );
}
