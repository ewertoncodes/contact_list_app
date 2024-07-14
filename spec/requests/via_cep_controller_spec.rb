# spec/controllers/via_cep_controller_spec.rb
require 'rails_helper'

RSpec.describe ViaCepController, type: :controller do
  describe "GET #get_via_cep" do
    context "when zipcode is valid" do
      let(:zipcode) { "12345678" }
      let(:url) { "https://viacep.com.br/ws/#{zipcode}/json/" }
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

      it "returns the address" do
        get :get_via_cep, params: { zipcode: zipcode }, format: :json
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["logradouro"]).to eq("Rua Exemplo")
        expect(parsed_response["localidade"]).to eq("São Paulo")
        expect(parsed_response["uf"]).to eq("SP")
      end
    end

    context "when zipcode is invalid" do
      let(:zipcode) { "00000000" }
      let(:url) { "https://viacep.com.br/ws/#{zipcode}/json/" }
      let(:response_body) do
        {
          erro: true
        }.to_json
      end

      before do
        stub_request(:get, url)
          .to_return(status: 200, body: response_body, headers: {})
      end

      it "returns status not found" do
        get :get_via_cep, params: { zipcode: zipcode }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when zipcode is empty" do
      let(:zipcode) { "" }

      it "returns status bad request" do
        get :get_via_cep, params: { zipcode: zipcode }, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
