import GMaps from 'gmaps/gmaps.js';

const catCards = document.querySelectorAll('.sighted-cat');

const mapElement = document.getElementById('map');
if (mapElement) {
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers = JSON.parse(mapElement.dataset.markers);
  const mapMarkers = [];
  // map.addMarkers(markers);
  markers.forEach((marker) => {
    let infoWindow = new google.maps.InfoWindow({
      content: marker.infoWindow.content
    });

    const mapMarker = new google.maps.Marker({
      position: { lat: marker.lat, lng: marker.lng },
      cat_id: marker.cat_id
    });

    console.log(mapMarker);
    console.log(infoWindow);

    mapMarker.addListener('click', function() {
      infoWindow.open(map.map, mapMarker);
    })
    mapMarker.addListener('mouseenter', function() {
      infoWindow.close();
    })

    mapMarkers.push(mapMarker);
    mapMarker.setMap(map.map);
  });

  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }

  if (markers[0].radius !== undefined) {
    markers.forEach((marker) => {
      let colonyRadius = new google.maps.Circle({
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 0,
        fillColor: '#cc8fcb',
        fillOpacity: 0.4,
        map: map.map,
        center: { lat: marker.lat, lng: marker.lng },
        radius: marker.radius * 1000
      });
    });
  }

  if (catCards !== null) {
    catCards.forEach((card, index) => {
      card.addEventListener('mouseenter', (event) => {
        google.maps.event.trigger(mapMarkers[index], 'click');
      });

      card.addEventListener('mouseleave', (event) => {
        google.maps.event.trigger(mapMarkers[index], 'mouseenter');
      });
    });
  }

  const styles = [
    {
        "featureType": "landscape.natural",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#e0efef"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "hue": "#1900ff"
            },
            {
                "color": "#c0e8e8"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
            {
                "lightness": 100
            },
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "lightness": 700
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "color": "#7dcdcd"
            }
        ]
    }
];

map.addStyle({
  styles: styles,
  mapTypeId: 'map_style'
});
map.setStyle('map_style');

}

