import { SVGProps } from 'react';

export function HorseIcon({
  size = 24,
  className,
  ...props
}: SVGProps<SVGSVGElement> & { size?: number }) {
  return (
    <svg
      viewBox="0 0 130 100"
      width={size}
      height={(size * 100) / 130}
      className={className}
      fill="currentColor"
      aria-hidden="true"
      {...props}
    >
      <rect x="19" y="46" width="13" height="34" rx="6.5" transform="rotate(-25 25 65)" />
      <rect x="34" y="42" width="72" height="36" rx="18" />
      <rect
        x="80"
        y="24"
        width="40"
        height="24"
        rx="12"
        transform="rotate(-20 95 60)"
      />
      <rect
        x="112"
        y="14"
        width="17"
        height="14"
        rx="7"
        transform="rotate(-20 120 22)"
      />
      <polygon
        points="86,24 93,8 102,24"
        transform="rotate(-20 94 24)"
      />
      <rect x="44" y="78" width="11" height="22" rx="5.5" />
      <rect x="61" y="78" width="11" height="22" rx="5.5" />
      <rect x="88" y="78" width="11" height="22" rx="5.5" />
      <rect x="104" y="78" width="11" height="22" rx="5.5" />
    </svg>
  );
}