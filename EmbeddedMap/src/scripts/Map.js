function init()
{
  let map = document.createElement('div');
  map.id = 'map';
  map.className = 'map';
  document.getElementById('controlAddIn').appendChild(map);
  
  Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnAfterInit",[]);
}

async function embedMap(address_json, settings_json)
{
  if(isValidInput(address_json, settings_json) == false) {
    return;
  }
  const addressData = await getAddressData(address_json, settings_json);
  if(isWellFormedData(addressData) == false) {
    return;
  }
  addAddressDataToMap(addressData, settings_json);
}

function isValidInput(address_json, settings_json) {
  try {
    if(address_json.address == "") {
      return false;
    }
    if(settings_json.positionStackApiKey == "") {
      return false;
    }
    if(settings_json.mapTilerKey == "") {
      return false;
    }
    return true;
  } catch {
    return false;
  }
}

async function getAddressData(address_json, settings_json)
{
  const address = encodeURIComponent(address_json.address);
  const region = encodeURIComponent(address_json.region);
  const country = encodeURIComponent(address_json.country);
  let apiAddress = `http://api.positionstack.com/v1/forward?access_key=${settings_json.positionStackApiKey}&query=${address}`;
  if(region) {
    apiAddress = apiAddress.concat(`&region=${region}`);
  }
  if(country) {
    apiAddress = apiAddress.concat(`&country=${country}`);
  }

  const response = await fetch(apiAddress);
  const responseAsJson = response.json();
  
  return responseAsJson;
}

function isWellFormedData(addressData) {
  try {
    const longitude = addressData.data[0].longitude;
    const latitude = addressData.data[0].latitude;
    return true;
  } catch {
    return false;
  }
}

function addAddressDataToMap(addressData, settings_json) {
  let zoom = settings_json.zoom;
  if(settings_json.zoom == "") {
    zoom = 12;
  }

  const map = new ol.Map({
    target: 'map',
    layers: [
      new ol.layer.Tile({
        source: new ol.source.TileJSON({
          url: `https://api.maptiler.com/maps/streets-v2/tiles.json?key=${settings_json.mapTilerKey}`,
          tileSize: 512,
        })
      })
    ],
    view: new ol.View({
      center: ol.proj.fromLonLat([addressData.data[0].longitude, addressData.data[0].latitude]),
      zoom: settings_json.zoom
    })
  });

  const marker = new ol.layer.Vector({
    source: new ol.source.Vector({
      features: [
        new ol.Feature({
          geometry: new ol.geom.Point(
            ol.proj.fromLonLat([addressData.data[0].longitude, addressData.data[0].latitude])
          )
        })
      ],
    }),
    style: new ol.style.Style({
      image: new ol.style.Icon({
        src: 'https://docs.maptiler.com/openlayers/default-marker/marker-icon.png',
        anchor: [0.5, 1]
      })
    })
  });

  map.addLayer(marker);
}

function clear() {
  let map = document.getElementById('map');
  map.innerHTML = "";
}