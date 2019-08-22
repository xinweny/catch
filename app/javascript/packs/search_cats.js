const colonyAddress = document.getElementById('colony_address');
let address = undefined;
colonyAddress.addEventListener('blur', (event) => {
  address = event.currentTarget.value;
  const url = `/colonies/new/cats?location=${address}`
  console.log(url)
  fetch(url).then(response => console.log(response));
});
