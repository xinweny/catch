window.checkboxColour = function() {
  const sightedCats = document.querySelectorAll('.sighted-cat-card');
  const selectAllButton = document.getElementById('select-all-button');

  if (sightedCats) {
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
      });
    });
    if (selectAllButton) {
      selectAllButton.addEventListener('click', (event) => {
        if (selectAllButton.innerText === "SELECT ALL") {
          sightedCats.forEach((cat) => {
            if (cat.classList.contains('unchecked')) {
              cat.click();
            }
          });
          selectAllButton.innerText = "DESELECT ALL";
        } else {
          sightedCats.forEach((cat) => {
            if (cat.classList.contains('checked')) {
              cat.click();
            }
          });
          selectAllButton.innerText = "SELECT ALL";
        }
      });
    }
  }
};

const checkboxColour = window.checkboxColour;

export { checkboxColour };
