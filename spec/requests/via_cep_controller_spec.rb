# spec/controllers/via_cep_controller_spec.rb
require 'rails_helper'

RSpec.describe ViaCepController, type: :controller do
  describe "GET #consultar_via_cep" do
    context "com um CEP válido" do
      let(:cep) { "12345678" }
      let(:url) { "https://viacep.com.br/ws/#{cep}/json/" }
      let(:endereco_completo) { "Rua Exemplo, São Paulo - SP" }
      let(:response_body) do
        {
          logradouro: "Rua Exemplo",
          localidade: "São Paulo",
          uf: "SP"
        }.to_json
      end

      before do
        stub_request(:get, url)
          .to_return(status: 200, body: response_body, headers: {})
      end

      it "retorna o endereço completo" do
        get :consultar_via_cep, params: { postcode: cep }, format: :json
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["logradouro"]).to eq("Rua Exemplo")
        expect(parsed_response["localidade"]).to eq("São Paulo")
        expect(parsed_response["uf"]).to eq("SP")
      end
    end

    context "com um CEP inválido" do
      let(:cep) { "00000000" }
      let(:url) { "https://viacep.com.br/ws/#{cep}/json/" }
      let(:response_body) do
        {
          erro: true
        }.to_json
      end

      before do
        stub_request(:get, url)
          .to_return(status: 200, body: response_body, headers: {})
      end

      it "retorna status não encontrado" do
        get :consultar_via_cep, params: { postcode: cep }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
