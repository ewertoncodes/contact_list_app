document.addEventListener("DOMContentLoaded", function() {
  var googleMapsApiKey = window.GOOGLE_MAPS_API_KEY;
  console.log(googleMapsApiKey);
  // Encontrar os campos de texto do CEP, endereço, latitude e longitude
  var postalcodeField = document.getElementById("user_contacts_attributes_0_postalcode");
  var addressField = document.getElementById("user_contacts_attributes_0_address");
  var latitudeField = document.getElementById("latitude");
  var longitudeField = document.getElementById("longitude");

  // Adicionar um listener para o evento de mudança no campo de CEP
  postalcodeField.addEventListener("input", function() {
    // Pegar o valor atual do campo de CEP
    var postalcodeValue = postalcodeField.value.trim();

    // Verificar se o campo de CEP está preenchido corretamente
    if (postalcodeValue.length === 8 && !isNaN(postalcodeValue)) {
      // Fazer a requisição AJAX para o backend
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "/via_cep/consultar_via_cep?postcode=" + postalcodeValue, true);
      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
          // Parse da resposta JSON
          var response = JSON.parse(xhr.responseText);

          // Preencher o campo de endereço com os dados retornados pelo backend
          if (response.hasOwnProperty("logradouro")) {
            addressField.value = response.logradouro + ", " + response.localidade + " - " + response.uf;

            // Chamar a função para obter as coordenadas a partir do endereço preenchido
            getCoordinatesFromAddress(addressField.value);
          } else {
            console.log("CEP não encontrado.");
          }
        }
      };
      xhr.send();
    } else {
      // Se o campo de CEP for apagado, limpar também o campo de endereço, latitude e longitude
      addressField.value = "";
      latitudeField.value = "";
      longitudeField.value = "";
    }
  });

  // Adicionar um listener para o evento de mudança no campo de endereço
  addressField.addEventListener("input", function() {
    // Pegar o valor atual do campo de endereço
    var addressValue = addressField.value.trim();

    // Se o campo de endereço estiver vazio, limpar também o campo de latitude e longitude
    if (addressValue === "") {
      latitudeField.value = "";
      longitudeField.value = "";
    } else {
      // Chamar a função para obter as coordenadas a partir do endereço preenchido
      getCoordinatesFromAddress(addressValue);
    }
  });

  // Função para obter coordenadas a partir do endereço usando a API de Geocodificação do Google Maps
  function getCoordinatesFromAddress(address) {
    // Montar a URL da API de Geocodificação do Google Maps
    var geocodeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodeURIComponent(address) + "&key=" + apiKey;
    console.log("url: " + geocodeUrl);
    // Requisição AJAX para obter coordenadas
    var xhr = new XMLHttpRequest();
    xhr.open("GET", geocodeUrl, true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
        // Parse da resposta JSON
        var response = JSON.parse(xhr.responseText);

        // Verificar se há resultados de geocodificação
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
