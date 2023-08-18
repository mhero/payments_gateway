# frozen_string_literal: true

class PaymentHandlerService < ApplicationService
  attr_reader :payment

  def initialize(payment)
    @payment = payment
  end

  def call
    if @payment.save
      @payment.provider_service.call(@payment)
    else
      Outcome.failed(@payment.errors)
    end
  end
end
