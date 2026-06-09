const API_URL =
  "https://owd6chpm07.execute-api.us-east-1.amazonaws.com/dev";

// Load visitor count
async function loadVisitors() {
  try {
    const response = await fetch(`${API_URL}/visitor`);

    const data = await response.json();

    document.getElementById("visitor-count").innerText =
      data.visitor_count;
  } catch (error) {
    console.error("Visitor API Error:", error);

    document.getElementById("visitor-count").innerText =
      "Unable to load visitor count";
  }
}

// Execute when page loads
loadVisitors();

// Contact form submission
document
  .getElementById("contact-form")
  .addEventListener("submit", async (event) => {
    event.preventDefault();

    const name =
      document.getElementById("name").value.trim();

    const email =
      document.getElementById("email").value.trim();

    const message =
      document.getElementById("message").value.trim();

    if (!name || !email || !message) {
      document.getElementById("response").innerText =
        "Please fill all fields.";

      return;
    }

    const payload = {
      name,
      email,
      message,
    };

    try {
      const response = await fetch(
        `${API_URL}/contact`,
        {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
          },

          body: JSON.stringify(payload),
        }
      );

      const data = await response.json();

      if (response.ok) {
        document.getElementById("response").innerText =
          data.message || "Message sent successfully!";

        // Clear form after successful submit
        document.getElementById("contact-form").reset();
      } else {
        document.getElementById("response").innerText =
          data.message || "Something went wrong.";
      }
    } catch (error) {
      console.error("Contact API Error:", error);

      document.getElementById("response").innerText =
        "Unable to connect to the server.";
    }
  });
