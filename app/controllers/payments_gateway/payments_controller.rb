# frozen_string_literal: true

module PaymentsGateway
  class PaymentsController < ApplicationController
    def create
      payment = ::PaymentsGateway::Payment.new(payment_params)

      if payment.save
        provider_result = payment.provider_service.call(payment)

        render json: provider_result.result, status: provider_result.success ? :created : :unprocessable_entity

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
