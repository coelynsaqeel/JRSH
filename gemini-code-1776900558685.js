// --- Updated Logo Style ---
function Logo() {
  return (
    <div style={{
      fontSize: "32px",       // Made it bigger
      fontWeight: "900",      // Made it bolder
      color: "#000",          // Pure black
      background: "none",     // Transparent background
      textAlign: "center",
      padding: "20px 0"
    }}>
      JRSH
    </div>
  );
}

// --- Updated Cancel Button ---
function CancelBtn({ onCancel }) {
  return (
    <button 
      onClick={onCancel}
      style={{
        backgroundColor: "#000",
        color: "#fff",
        border: "none",
        padding: "12px 24px",
        borderRadius: "8px",
        fontWeight: "bold",
        cursor: "pointer",
        width: "100%"
      }}
    >
      CANCEL LESSON
    </button>
  );
}

// --- Connection Fix ---
async function checkConnection() {
  try {
    // We fetch a tiny resource to see if the server is actually reachable
    const response = await fetch('https://google.com', { mode: 'no-cors' });
    return true;
  } catch (e) {
    // Only shows error if the fetch actually fails
    return false;
  }
}