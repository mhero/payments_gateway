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
    return no_publishable_key unless publishable_key

    if create_intent
      Outcome.successful(card_payment)
    else
      unable_to_create
    end
  end

  private

  def no_payment
    Outcome.failed('no payment provided')
  end

  def invalid_provider
    Outcome.failed('invalid provider')
  end

  def unable_to_create
    Outcome.failed('unable to create payment intent')
  end

  def no_publishable_key
    Outcome.failed('failure while returning intent')
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
    intent = stripe_intent
    payment.update(intent:, succeeded_at: Time.zone.now) if intent
    intent
  end

  def stripe_intent
    Stripe::PaymentIntent.create({
                                   amount: @payment.amount,
                                   currency: @payment.currency,
                                   payment_method_types: PAYMENT_METHOD_TYPES,
                                   customer: @payment.customer_external_id
                                 })
  rescue Stripe::InvalidRequestError
    nil
  end
end
