document.addEventListener("turbo:load", function() {
  var postalcodeField = document.getElementById("postalcode");
  var addressField = document.getElementById("address");
  var latitudeField = document.getElementById("latitude");
  var longitudeField = document.getElementById("longitude");

  postalcodeField.addEventListener("input", function() {
    var postalcodeValue = postalcodeField.value.trim();

    if (postalcodeValue.length === 8 && !isNaN(postalcodeValue)) {
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "/via_cep/consultar_via_cep?postcode=" + postalcodeValue, true);
      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
          var response = JSON.parse(xhr.responseText);

          if (response.hasOwnProperty("logradouro")) {
            addressField.value = response.logradouro + ", " + response.localidade + " - " + response.uf;

            getCoordinatesFromAddress(addressField.value);
          } else {
            console.log("CEP não encontrado.");
          }
        }
      };
      xhr.send();
    } else {
      addressField.value = "";
      latitudeField.value = "";
      longitudeField.value = "";
    }
  });

  addressField.addEventListener("input", function() {
    var addressValue = addressField.value.trim();

    if (addressValue === "") {
      latitudeField.value = "";
      longitudeField.value = "";
    } else {
      getCoordinatesFromAddress(addressValue);
    }
  });

  function getCoordinatesFromAddress(address) {
    var geocodeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodeURIComponent(address) + "&key=" + apiKey;
    var xhr = new XMLHttpRequest();
    xhr.open("GET", geocodeUrl, true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
        var response = JSON.parse(xhr.responseText);

        if (response.results.length > 0) {
          var location = response.results[0].geometry.location;
          latitudeField.value = location.lat;
          longitudeField.value = location.lng;
        } else {
          console.log("Endereço não encontrado.");
        }
      }
    };
    xhr.send();
  }
});
