require "net/http"
require "json"

class ViaCep
  BASE_URL = "https://viacep.com.br/ws"

  def self.get_address(zipcode)
    raise ArgumentError, "CEP não pode ser vazio" if zipcode.blank?
    raise ArgumentError, "CEP inválido" unless valid_zipcode?(zipcode)

    url = "#{BASE_URL}/#{zipcode}/json/"
    uri = URI(url)

    response = Net::HTTP.get_response(uri)
    handle_response(response)
  end

  private

  def self.valid_zipcode?(zipcode)
    zipcode.match?(/^\d{5}-?\d{3}$/)
  end

  def self.handle_response(response)
    case response
    when Net::HTTPSuccess
      data = JSON.parse(response.body)
      raise StandardError, "CEP não encontrado" if data["erro"]

      data
    when Net::HTTPClientError, Net::HTTPServerError
      raise StandardError, "Erro ao consultar o ViaCEP: #{response.message}"
    else
      raise StandardError, "Erro desconhecido ao consultar o ViaCEP"
    end
  rescue JSON::ParserError
    raise StandardError, "Erro ao processar a resposta do ViaCEP"
  end
end
