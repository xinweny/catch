const sightedCats = document.querySelectorAll('.sighted-cat-card');

sightedCats.forEach((cat) => {
  cat.addEventListener('click', (event) => {
    let checkBox = event.currentTarget.querySelector('input');
    if (checkBox.checked === true) {
      checkBox.checked = false;
      event.currentTarget.classList.remove("checked");
      event.currentTarget.classList.add("unchecked");
    } else {
      checkBox.checked = true;
      event.currentTarget.classList.remove("unchecked");
      event.currentTarget.classList.add("checked");
    }
  })
})
