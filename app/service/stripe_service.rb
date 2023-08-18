# frozen_string_literal: true

class StripeService < ApplicationService
  attr_reader :payment

  PAYMENT_METHOD_TYPES = ['card'].freeze

  def initialize(payment)
    @payment = payment
  end

  def call
    return no_payment unless @payment
    return invalid_provider unless PaymentsGateway::Payment.stripe?(@payment.provider)

    if create_intent
      OpenStruct.new(
        success: true,
        result: card_payment
      )
    else
      unable_to_create
    end
  end

  private

  def no_payment
    OpenStruct.new(
      success: false,
      result: 'no payment provided'
    )
  end

  def invalid_provider
    OpenStruct.new(
      success: false,
      result: 'invalid provider'
    )
  end

  def unable_to_create
    OpenStruct.new(
      success: false,
      result: 'unable to create payment intent'
    )
  end

  def card_payment
    {
      gateway: @payment.provider,
      stripe: {
        version: 'latest',
        paymentIntent: {
          id: @payment.intent['id'],
          publishableKey: publishable_key,
          clientSecret: @payment.intent['clientSecret'],
          amount: @payment.intent['amount'],
          currency: @payment.intent['currency']
        }
      }
    }
  end

  def publishable_key
    ENV.fetch('PULISHABLE_KEY', nil)
  end

  def create_intent
    intent = Stripe::PaymentIntent.create({
                                            amount: @payment.amount,
                                            currency: @payment.currency,
                                            payment_method_types: PAYMENT_METHOD_TYPES,
                                            customer: @payment.customer_external_id
                                          })
    intent[:status] = 'success'
    payment.update(intent:)
  rescue Stripe::InvalidRequestError
    payment.update(intent: { status: 'failed' })
    nil
  end
end
