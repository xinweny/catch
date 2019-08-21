function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var eventAddress = document.getElementById('event_address');

    if (eventAddress) {
      var autocomplete = new google.maps.places.Autocomplete(eventAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(eventAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
