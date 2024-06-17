document.addEventListener("DOMContentLoaded", async function () {
  const center = { lat: 50.064192, lng: -130.605469 };
  // Create a bounding box with sides ~10km away from the center point
  const defaultBounds = {
    north: center.lat + 0.1,
    south: center.lat - 0.1,
    east: center.lng + 0.1,
    west: center.lng - 0.1,
  };
  const input = document.getElementById("address");
  const options = {
    bounds: defaultBounds,
    componentRestrictions: { country: "ug" },
    fields: ["address_components", "geometry", "icon", "name"],
    strictBounds: false,
  };


  try {
  
      const autocomplete = new google.maps.places.Autocomplete(input, options);
  
      autocomplete.addListener("place_changed", onPlaceChanged);
  
      function onPlaceChanged() {
        const place = autocomplete.getPlace();
        console.log(place);
        for (const component of place.address_components) {
          const componentType = component.types[0];
  
          switch (componentType) {
            case "street_number": {
              document.getElementById("street1").value = `${component.long_name}`;
              break;
            }
  
            case "route": {
              document.getElementById(
                "street2"
              ).value = `${component.short_name}`;
              break;
            }
  
            case "locality": {
              document.getElementById("zip").value = `${component.long_name}`;
              break;
            }
  
            case "administrative_area_level_2": {
              document.getElementById("city").value = `${component.short_name}`;
              break;
            }
            case "country":
              document.getElementById("country").value = `${component.long_name}`;
              break;
          }
        }
      }
    
  
} catch (error) {

  console.log()


}

});
