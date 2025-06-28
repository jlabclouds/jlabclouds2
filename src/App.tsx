import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import { AppsDropdown } from "./AppsDropdown";
import { ProfileDropdown } from "./ProfileDropdown";
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <nav
      aria-label="Main"
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        width: "100vw",
        zIndex: 100,
        background: "#282c34",
        boxShadow: "0 2px 8px rgba(0,0,0,0.08)",
      }}
    >
      <div
        style={{
          display: "flex",
          alignItems: "center",
          padding: "1rem 2rem",
          borderRadius: "18px",
          gap: "1.5rem",
          maxWidth: "480px",
          width: "100%",
          boxSizing: "border-box",
          justifyContent: "space-between",
          margin: "1.5rem auto",
          background: "rgba(255,255,255,0.07)",
          boxShadow: "0 8px 32px 0 rgba(31, 38, 135, 0.18)",
          border: "1px solid rgba(255,255,255,0.18)",
          backdropFilter: "blur(8px)",
        }}
      >
        <a
          href="https://react.dev"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="React homepage"
        >
          <img
            src={reactLogo}
            className="logo react"
            alt="React logo"
            style={{
              height: 40,
              filter: "drop-shadow(0 2px 8px #61dafb88)",
            }}
          />
        </a>
        <SearchInput />
        <AppsDropdown />
        <ProfileDropdown />
      </div>
    </nav>
    </>
  );
}

function SearchInput() {
  const [searchQuery, setSearchQuery] = React.useState("");
  return (
    <label style={{ flex: 1, minWidth: 0, maxWidth: 220 }}>
      <span className="sr-only">Search</span>
      <input
        type="search"
        aria-label="Search"
        placeholder="Search..."
        value={searchQuery}
        onChange={e => setSearchQuery(e.target.value)}
        style={{
          width: "100%",
          padding: "0.5rem 1rem",
          borderRadius: "20px",
          border: "1px solid #61dafb",
          fontSize: "1rem",
          background: "rgba(255,255,255,0.85)",
          boxShadow: "0 1px 4px rgba(97,218,251,0.08)",
          outline: "none",
          transition: "border 0.2s",
        }}
      />
    </label>
  );
}
export default App
