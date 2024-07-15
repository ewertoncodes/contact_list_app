class ViaCepController < ApplicationController
  def get_via_cep
    zipcode = params[:zipcode]

    begin
      address = ViaCep.get_address(zipcode)

      render json: address
    rescue ArgumentError => e
      render json: { error: e.message }, status: :bad_request
    rescue StandardError => e
      render json: { error: e.message }, status: :not_found
    end
  end
end
