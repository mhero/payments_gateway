# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe 'Stripe payments gateway', type: :request do
    describe 'creates a payment' do
      before(:all) do
        Stripe.api_key = ENV['STRIPE_API_KEY']
        VCR.use_cassette('stripe_create_payment_intent') do
          byebug
          Stripe::PaymentIntent.create(
            amount: 100,
            currency: 'EUR',
            payment_method_types: ['card'],
          )
        end
        VCR.eject_cassette
      end

      describe 'sandbox' do
        it 'will sandbox' do
          
          puts 'Just run the test, please'
        end
      end
    end
  end
end
