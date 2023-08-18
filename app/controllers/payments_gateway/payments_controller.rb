# frozen_string_literal: true

module PaymentsGateway
  class PaymentsController < ApplicationController
    def create
      payment_process = PaymentHandlerService.call(
        ::PaymentsGateway::Payment.new(payment_params)
      )

      render json: payment_process.result, status: payment_process.success? ? :created : :unprocessable_entity
    end

    private

    def payment_params
      params.fetch(:payment, {}).permit(:amount, :currency, :customer_external_id, :provider)
    end
  end
end
