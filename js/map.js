const hotelCoords = [-74.05402221466133, 4.652610335610418];

const places = {
    restaurant: [-74.05410913404073, 4.653193716985211],
    pharmacy: [-74.05442833901137, 4.652532879957171],
    hospital: [-74.05695724219733, 4.651575656133047]
};

// Inicializar el mapa
mapboxgl.accessToken = 'pk.eyJ1IjoibXJyYW1pcmUyIiwiYSI6ImNtN202ZGs0dDBqeWkybXNkejFpaDdsZTgifQ.WAxXS8sYUXuufJEUI3U2cQ';
const map = new mapboxgl.Map({
    container: 'map', // ID del contenedor HTML donde se mostrará el mapa
    style: 'mapbox://styles/mapbox/streets-v11',
    center: hotelCoords,
    zoom: 17
});

// Añadir marcador para el hotel
createCustomMarker('/student070/dwes/images/pingMap.png').setLngLat(hotelCoords).addTo(map);
let destinationMarker = null;

// Función para eliminar la ruta y el marcador de destino anterior
function removePreviousRoute() {
    if (map.getSource('route')) {
        map.removeLayer('route');
        map.removeSource('route');
    }
    // Eliminar el marcador de destino si existe
    if (destinationMarker) {
        destinationMarker.remove();
        destinationMarker = null;
    }
}

// Función para obtener y mostrar la ruta
function getRoute(place) {
    const destination = places[place];
    const url = `https://api.mapbox.com/directions/v5/mapbox/driving/${hotelCoords[0]},${hotelCoords[1]};${destination[0]},${destination[1]}?geometries=geojson&access_token=${mapboxgl.accessToken}`;

    // Eliminar la ruta y los marcadores anteriores antes de agregar los nuevos
    removePreviousRoute();

    fetch(url)
        .then(response => response.json())
        .then(data => {
            if (data.routes.length > 0) {
                const route = data.routes[0].geometry.coordinates;

                // Añadir la nueva ruta al mapa
                map.addSource('route', {
                    type: 'geojson',
                    data: {
                        type: 'Feature',
                        geometry: {
                            type: 'LineString',
                            coordinates: route
                        }
                    }
                });

                map.addLayer({
                    id: 'route',
                    type: 'line',
                    source: 'route',
                    paint: {
                        'line-color': '#0a2239',
                        'line-width': 4
                    }
                });

                // Añadir el marcador en el destino
                destinationMarker = new mapboxgl.Marker().setLngLat(destination).addTo(map);

                // Ajustar el mapa para mostrar la ruta y los lugares de interés
                const bounds = new mapboxgl.LngLatBounds().extend(hotelCoords).extend(destination);
                map.fitBounds(bounds, {
                    padding: 20,
                    maxZoom: 17
                });
            }
        })
        .catch(err => console.error('Error al obtener la ruta: ', err));
}

// Asignar la función a los botones
document.getElementById('restaurantBtn').addEventListener('click', () => getRoute('restaurant'));
document.getElementById('pharmacyBtn').addEventListener('click', () => getRoute('pharmacy'));
document.getElementById('hospitalBtn').addEventListener('click', () => getRoute('hospital'));

// Función para crear un marcador personalizado
function createCustomMarker(iconUrl) {
  const markerElement = document.createElement('div');
  markerElement.className = 'custom-marker';
  markerElement.style.backgroundImage = `url(${iconUrl})`;
  markerElement.style.backgroundSize = 'contain';
  markerElement.style.width = '34px';
  markerElement.style.height = '40px';

  return new mapboxgl.Marker(markerElement);
}