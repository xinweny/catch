const colonyAddress = document.getElementById('colony_address');

let address = undefined;
colonyAddress.addEventListener('change', (event) => {
  address = event.currentTarget.value;
});
