require "rails_helper"
require "via_cep"

RSpec.describe ViaCep do
  describe "#get_address" do
    let(:valid_zipcode) { "01001-000" }
    let(:invalid_zipcode) { "00000-000" }
    let(:empty_zipcode) { "" }

    context "when the zipcode is valid" do
      it "returns the address" do
        VCR.use_cassette("valid_zipcode") do
          address = ViaCep.get_address(valid_zipcode)
          expect(address["cep"]).to eq("01001-000")
          expect(address["logradouro"]).to eq("Praça da Sé")
        end
      end
    end

    context 'when the zipcode format is invalid' do
      it 'raises an ArgumentError' do
        VCR.use_cassette('invalid_zipcode') do
          expect { ViaCep.get_address('950100100') }.to raise_error(ArgumentError, 'CEP inválido')
        end
      end
    end

    context 'when the zipcode is empty' do
      it 'raises an ArgumentError' do
        VCR.use_cassette('empty_zipcode') do
          expect { ViaCep.get_address('') }.to raise_error(ArgumentError, 'CEP não pode ser vazio')
        end
      end
    end
  end
end
