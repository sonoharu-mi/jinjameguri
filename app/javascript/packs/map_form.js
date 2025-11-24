// map_form.js
(async function() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  const geocoder = new google.maps.Geocoder();

  const defaultPosition = {
    lat: 35.681236,
    lng: 139.767125
  };

  // 編集時は既存の位置を初期値にする（存在する場合のみ）
  const initialLat = parseFloat(document.getElementById("post_latitude")?.value);
  const initialLng = parseFloat(document.getElementById("post_longitude")?.value);

  const initPosition =
    !isNaN(initialLat) && !isNaN(initialLng)
      ? { lat: initialLat, lng: initialLng }
      : defaultPosition;

  const map = new Map(document.getElementById("map"), {
    center: initPosition,
    zoom: 15,
    mapId: "DEMO_MAP_ID"
  });

  const marker = new AdvancedMarkerElement({
    map,
    position: initPosition,
    gmpDraggable: true
  });

  // 住所をフォームにセットする関数
  function fillAddress(position) {
    geocoder.geocode({ location: position }, (results, status) => {
      if (status === "OK" && results[0]) {
        document.getElementById("post_address").value = results[0].formatted_address;
      }
    });
  }

  // ドラッグ終了で座標と住所を更新
  google.maps.event.addListener(marker, "dragend", () => {
    const pos = marker.position;
    document.getElementById("post_latitude").value = pos.lat;
    document.getElementById("post_longitude").value = pos.lng;
    fillAddress({ lat: pos.lat, lng: pos.lng });
  });
})();
