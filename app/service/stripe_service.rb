# frozen_string_literal: true

class StripeService < ApplicationService
  attr_reader :payment

  PAYMENT_METHOD_TYPES = ['card'].freeze

  def initialize(payment)
    @payment = payment
  end

  def call
    return unless @payment
    return unless ProviderService.stripe?(@payment.provider)

    create_intent

    card_payment
  end

  private

  def card_payment
    {
      gateway: @payment.provider,
      stripe: {
        version: 'latest',
        paymentIntent: {
          id: @payment.intent['id'],
          publishableKey: @payment.intent['publishableKey'],
          clientSecret: @payment.intent['clientSecret'],
          amount: @payment.intent['amount'],
          currency: @payment.intent['currency']
        }
      }
    }
  end

  def create_intent
    intent = Stripe::PaymentIntent.create({
                                            amount: @payment.amount,
                                            currency: @payment.currency,
                                            payment_method_types: PAYMENT_METHOD_TYPES,
                                            customer: @payment.customer_external_id
                                          })

    payment.update(intent:)
  end
end
