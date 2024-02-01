/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        transparent: "transparent",
        current: "currentColor",
        primary: "#006AFF",
        white: "#ffffff",
        black: "#202224",
        custom_gray: {
          100: "#F5F6FA",
          600: "#8E95A9",
        },
      },
    },
  },
  plugins: [],
};
