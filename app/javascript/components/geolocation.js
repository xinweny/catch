const addressField = document.getElementById('cat_address');

function success(position) {
  const url = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.coords.latitude},${position.coords.longitude}&key=${process.env.GOOGLE_API_SERVER_KEY}`;
  fetch(url).then(response => response.json())
  .then((data) => {
    const address = data.results[0].formatted_address;
    addressField.value = address;
  });
}

function setPosition() {
  if (addressField) {
    navigator.geolocation.getCurrentPosition(success);
  }
}

export { setPosition };
