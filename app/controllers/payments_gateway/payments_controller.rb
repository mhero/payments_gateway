# frozen_string_literal: true

module PaymentsGateway
  class PaymentsController < ApplicationController
    def create
      payment = ::PaymentsGateway::Payment.new(payment_params)

      if payment.save
        render json: payment.provider_service.call(payment), status: :created
      else
        render json: payment.errors, status: :unprocessable_entity
      end
    end

    private

    def payment_params
      params.fetch(:payment, {}).permit(:amount, :currency, :customer_external_id, :provider)
    end
  end
end
