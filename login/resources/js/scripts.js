function showHide() {
  const togglePassword = document.getElementById("password");
  const togglePasswordIcon = document.getElementById("togglePassword");
  if (togglePassword.type === "password") {
    togglePassword.type = "text";
    togglePasswordIcon.classList.remove("fa-eye");
    togglePasswordIcon.classList.add("fa-eye-slash");
  } else {
    togglePassword.type = "password";
    togglePasswordIcon.classList.remove("fa-eye-slash");
    togglePasswordIcon.classList.add("fa-eye");
  }
}
