/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#1d4d3b',
        'primary-dark': '#112d24',
        secondary: '#b88746',
        danger: '#b42318',
        warning: '#d97706',
        dark: '#112d24',
      },
      boxShadow: {
        soft: '0 16px 45px rgba(25, 55, 43, 0.10)',
        card: '0 10px 30px rgba(25, 55, 43, 0.08)',
      },
    },
  },
  plugins: [],
};
