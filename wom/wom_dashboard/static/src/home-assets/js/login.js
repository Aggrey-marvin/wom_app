document.addEventListener("DOMContentLoaded", async function () {
    // Example usage:
  
  
    function getElementReference(id) {
      return document.getElementById(id);
    }
  
    
    const togglePassword = getElementReference("toggle-password");
  
    if (togglePassword) {
      togglePassword.addEventListener("click", function () {
        const passwordInput = getElementReference("password");
        let inputType =
          passwordInput.getAttribute("type") === "password" ? "text" : "password";
        passwordInput.setAttribute("type", inputType);
        getElementReference("toggleIcon").classList.toggle("fa-eye-slash");
      });
    }
  });
  