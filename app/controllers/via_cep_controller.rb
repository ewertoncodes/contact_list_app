# app/controllers/via_cep_controller.rb
class ViaCepController < ApplicationController
  require "httparty"

  def consultar_via_cep
    cep = params[:postcode]
    url = "https://viacep.com.br/ws/#{cep}/json/"

    response = HTTParty.get(url)

    if response.code == 200 && response.parsed_response["erro"]
      render json: { error: "CEP não encontrado" }, status: :not_found
    else
      render json: response.parsed_response
    end
  end
end
