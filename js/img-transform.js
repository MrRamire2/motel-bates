const imgRoom = document.querySelectorAll(".img-room");
const imgMore = document.querySelectorAll(".img-more");
const info = document.querySelectorAll(".info");

imgMore.forEach((img, i) => {
  img.addEventListener("click", (e) => {
      e.target.classList.toggle("open");
      info[i].classList.toggle("hidden");
    })
});
