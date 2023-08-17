# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create
    payment = ::PaymentsGateway::Payment.new(paymnet_params)

    if payment.save
      provider_service = ProviderService.call(payment.provider)
      render json: provider_service.call(payment), status: :created
    else
      render json: payment.errors, status: :unprocessable_entity
    end
  end

  private

  def paymnet_params
    params.fetch(:payment, {}).permit(:amount, :currency, :customer_external_id, :provider)
  end
end
