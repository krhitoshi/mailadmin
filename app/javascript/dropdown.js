// User menu dropdown in the navbar
// A single delegated listener keeps working across Turbo page visits
document.addEventListener("click", function (event) {
    var toggle = document.getElementById("user-menu-button");
    var menu = document.getElementById("user-menu");
    if (toggle === null || menu === null) {
        return;
    }
    if (toggle.contains(event.target)) {
        menu.classList.toggle("hidden");
    } else if (!menu.contains(event.target)) {
        menu.classList.add("hidden");
    }
});
