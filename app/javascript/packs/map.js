function initMap() {
  const position = { lat: 35.6804, lng: 139.7690 }; // 東京駅

  new google.maps.Map(document.getElementById("map"), {
    zoom: 14,
    center: position,
  });
}

window.initMap = initMap;