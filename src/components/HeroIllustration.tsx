export function HeroIllustration() {
  const letras = [
    { x: 330, y: 110, letter: 'A' },
    { x: 392, y: 182, letter: 'K' },
    { x: 436, y: 258, letter: 'E' },
    { x: 392, y: 334, letter: 'H' },
    { x: 330, y: 406, letter: 'C' },
    { x: 268, y: 334, letter: 'F' },
    { x: 224, y: 258, letter: 'M' },
    { x: 268, y: 182, letter: 'B' },
    { x: 330, y: 200, letter: 'D' },
    { x: 330, y: 316, letter: 'G' },
  ];

  return (
    <svg
      viewBox="0 0 640 520"
      className="h-auto w-full"
      role="img"
      aria-label="Ilustración de una pista de doma clásica con jinetes"
    >
      <g>
        <circle
          cx="330"
          cy="258"
          r="190"
          fill="none"
          stroke="#e8c98d"
          strokeOpacity="0.30"
          strokeWidth="1.5"
        />
        <circle
          cx="330"
          cy="258"
          r="152"
          fill="none"
          stroke="#e8c98d"
          strokeOpacity="0.15"
          strokeWidth="1.5"
          strokeDasharray="3 9"
        />
        <circle
          cx="330"
          cy="258"
          r="118"
          fill="none"
          stroke="#e8c98d"
          strokeOpacity="0.10"
          strokeWidth="1"
        />

        <rect
          x="200"
          y="110"
          width="260"
          height="296"
          rx="130"
          fill="#e8c98d"
          fillOpacity="0.06"
          stroke="#e8c98d"
          strokeOpacity="0.45"
          strokeWidth="1.5"
        />
        <line
          x1="330"
          y1="110"
          x2="330"
          y2="406"
          stroke="#e8c98d"
          strokeOpacity="0.22"
          strokeWidth="1"
        />

        {letras.map((l) => (
          <g key={l.letter} transform={`translate(${l.x} ${l.y})`}>
            <circle r="14" fill="#112d24" stroke="#e8c98d" strokeOpacity="0.8" strokeWidth="1.5" />
            <text
              textAnchor="middle"
              dominantBaseline="central"
              fontSize="11"
              fontWeight="700"
              fill="#e8c98d"
              fontFamily="'Playfair Display', Georgia, serif"
            >
              {l.letter}
            </text>
          </g>
        ))}

        <circle cx="150" cy="120" r="3.5" fill="#e8c98d" fillOpacity="0.5" />
        <circle cx="520" cy="110" r="2.5" fill="#e8c98d" fillOpacity="0.4" />
        <circle cx="130" cy="330" r="2.5" fill="#e8c98d" fillOpacity="0.4" />
        <circle cx="540" cy="360" r="3" fill="#e8c98d" fillOpacity="0.5" />
        <circle cx="180" cy="450" r="2" fill="#e8c98d" fillOpacity="0.35" />
        <circle cx="470" cy="80" r="2" fill="#e8c98d" fillOpacity="0.35" />

        <g transform="translate(376 66) scale(0.62)" opacity="0.9">
          <svg width="200" height="154" viewBox="0 0 130 100" aria-hidden="true">
            <rect x="19" y="46" width="13" height="34" rx="6.5" transform="rotate(-25 25 65)" fill="#f3d9aa" />
            <rect x="34" y="42" width="72" height="36" rx="18" fill="#f3d9aa" />
            <rect x="80" y="24" width="40" height="24" rx="12" transform="rotate(-20 95 60)" fill="#f3d9aa" />
            <rect x="112" y="14" width="17" height="14" rx="7" transform="rotate(-20 120 22)" fill="#f3d9aa" />
            <polygon points="86,24 93,8 102,24" transform="rotate(-20 94 24)" fill="#f3d9aa" />
            <rect x="44" y="78" width="11" height="22" rx="5.5" fill="#f3d9aa" />
            <rect x="61" y="78" width="11" height="22" rx="5.5" fill="#f3d9aa" />
            <rect x="88" y="78" width="11" height="22" rx="5.5" fill="#f3d9aa" />
            <rect x="104" y="78" width="11" height="22" rx="5.5" fill="#f3d9aa" />
          </svg>
        </g>

        <g transform="translate(432 300)" >
          <svg width="130" height="100" viewBox="0 0 130 100" aria-hidden="true">
            <rect x="19" y="46" width="13" height="34" rx="6.5" transform="rotate(-25 25 65)" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="34" y="42" width="72" height="36" rx="18" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="80" y="24" width="40" height="24" rx="12" transform="rotate(-20 95 60)" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="112" y="14" width="17" height="14" rx="7" transform="rotate(-20 120 22)" fill="#e8c98d" fillOpacity="0.55" />
            <polygon points="86,24 93,8 102,24" transform="rotate(-20 94 24)" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="44" y="78" width="11" height="22" rx="5.5" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="61" y="78" width="11" height="22" rx="5.5" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="88" y="78" width="11" height="22" rx="5.5" fill="#e8c98d" fillOpacity="0.55" />
            <rect x="104" y="78" width="11" height="22" rx="5.5" fill="#e8c98d" fillOpacity="0.55" />
          </svg>
        </g>
      </g>
    </svg>
  );
}