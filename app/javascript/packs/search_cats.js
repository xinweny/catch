const colonyAddress = document.getElementById('colony_address');
const hiddenForm = document.getElementById('location');
let address = undefined;
colonyAddress.addEventListener('blur', (event) => {
  address = event.currentTarget.value;
  hiddenForm.value = address;
  document.querySelector('.submit-button').click();
});
