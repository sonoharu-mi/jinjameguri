// map_form.js（修正版）
document.addEventListener("turbolinks:load", async () => {
  const mapEl = document.getElementById("map");
  if (!mapEl) return; // map がないページは何もしない

  await window.waitForGoogleMaps();

  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  const geocoder = new google.maps.Geocoder();

  const defaultPosition = { lat: 35.681236, lng: 139.767125 };

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
    mapId: "DEMO_MAP_ID" // 実運用ではあなたのMap IDに置き換えてください
  });

  const marker = new AdvancedMarkerElement({
    map,
    position: initPosition,
    gmpDraggable: true
  });

  // --- helper: pos が LatLng (methods) か LatLngLiteral (values) か判定して数値を返す ---
  function getLatLng(pos) {
    // pos may be a google.maps.LatLng (with methods) or {lat:.., lng:..}
    if (!pos) return null;

    if (typeof pos.lat === "function" && typeof pos.lng === "function") {
      return { lat: pos.lat(), lng: pos.lng() };
    } else if (typeof pos.lat === "number" && typeof pos.lng === "number") {
      return { lat: pos.lat, lng: pos.lng };
    } else if (pos.lat && pos.lng) {
      // fallback if nested
      return { lat: Number(pos.lat), lng: Number(pos.lng) };
    } else {
      return null;
    }
  }

  // --- 郵便番号と住所をセットする関数 ---
  function fillAddress(latlng) {
    if (!latlng) return;

    geocoder.geocode({ location: latlng }, (results, status) => {
      if (status === "OK" && results && results[0]) {
        const formatted = results[0].formatted_address || "";

        // 郵便番号の抽出（日本のフォーマット「〒123-4567」を想定）
        const postalMatch = formatted.match(/〒\s*\d{3}-\d{4}/) || formatted.match(/\d{3}-\d{4}/);
        if (postalMatch) {
          const postal = postalMatch[0].replace("〒", "").trim();
          const zipInput = document.querySelector("input[name='zipcode']");
          if (zipInput) zipInput.value = postal;
        }

        // 郵便番号を除いた住所（あれば）
        const addressOnly = formatted.replace(/〒\s*\d{3}-\d{4}\s*/, "").trim();
        const addrInput = document.getElementById("post_address");
        if (addrInput) addrInput.value = addressOnly;
      } else {
        console.warn("Geocoder failed: ", status);
      }
    });
  }

  // --- 位置変更時にまとめて実行する関数 ---
  function updatePosition(pos) {
    const latlng = getLatLng(pos);
    if (!latlng) return;

    const lat = latlng.lat;
    const lng = latlng.lng;

    const latInput = document.getElementById("post_latitude");
    const lngInput = document.getElementById("post_longitude");

    if (latInput) latInput.value = lat;
    if (lngInput) lngInput.value = lng;

    fillAddress({ lat: lat, lng: lng });
  }

  // 初期表示で住所をセットしたい場合（編集時など）
  // updatePosition(marker.position);

  // ① ドラッグ終了で更新（AdvancedMarkerElement でも dragend が動く方へ対応）
  google.maps.event.addListener(marker, "dragend", () => {
    updatePosition(marker.position);
  });

  // ② 地図クリック時にマーカー移動 & 更新
  map.addListener("click", (event) => {
    const pos = event.latLng;
    // マーカーを移動（AdvancedMarkerElement は position にオブジェクトを代入可）
    marker.position = { lat: pos.lat(), lng: pos.lng() };
    updatePosition(pos);
  });
});
