document.addEventListener("DOMContentLoaded", function () {
  const titles = document.querySelectorAll(".tittle-dropdown");

  titles.forEach(title => {
    title.addEventListener("click", function () {

      const dropdown = title.nextElementSibling;

      document.querySelectorAll(".container-dropdown.active").forEach(menu => {
        if (menu !== dropdown) {
          menu.classList.remove("active");
        }
      });

      if (dropdown && dropdown.classList.contains("container-dropdown")) {
        dropdown.classList.toggle("active");
      }
    });
  });
});