

// ライブラリの読み込み
document.addEventListener("turbolinks:load", async () => {
  const mapEl = document.getElementById("map");
  if (!mapEl) return; // map がないページは何もしない

  await window.waitForGoogleMaps();
  
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker")

  // 地図の中心と倍率は公式から変更しています。
  const map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 }, 
    zoom: 15,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false
  });


  try {
    const response = await fetch("/posts.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const {data: { items } } = await response.json();
    if (!Array.isArray(items)) throw new Error("Items is not an array");

    items.forEach( item => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const shirineName = item.shirine_name;
      const userImage = item.user.image;
      const userName = item.user.name;
      const postImage = item.image;
      const address = item.address;
      const body = item.body;
      const shirineStamp = item.shirine_stamp;
      const parking = item.parking;
      const seasonalStamp = item.seasonal_stamp;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: shirineName,
        // 他の任意のオプションもここに追加可能
      });

      const contentString = `
        <div class="information container p-0">
          <div class="mb-3 d-flex align-items-center">
            <img class="rounded-circle mr-2" src="${userImage}" width="40" height="40">
            <p class="lead m-0 font-weight-bold">${userName}</p>
          </div>
          <div class="mb-3">
            <img class="thumbnail" src="${postImage}" loading="lazy" width="200px">
          </div>
          <div>
            <h1 class="h4 font-weight-bold">${shirineName}</h1>
            <p class="text-muted">${address}</p>
            <p class="lead">${body}</p>
          </div>
        </div>
      `;
      
      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: shirineName,
      });
      
      marker.addListener("click", () => {
          infowindow.open({
          anchor: marker,
          map,
        })
      });
    });
  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }
})
