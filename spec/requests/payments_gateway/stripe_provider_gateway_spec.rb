# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe 'Stripe payments gateway', type: :request do
    describe 'payment creation' do
      before(:all) do
        Stripe.api_key = ENV.fetch('STRIPE_API_KEY', nil)
      end

      it 'creates a payment' do
        VCR.use_cassette('stripe_create_payment_intent') do
          post '/payments_gateway/payments',
               params: {
                 payment: { amount: 1000, currency: 'EUR', provider: 'stripe' }
               }
        end

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
      end

      it 'returns unprocessable entity with invalid customer' do
        VCR.use_cassette('stripe_create_payment_intent_invalid_customer') do
          post '/payments_gateway/payments',
               params: {
                 payment: { amount: 1000, currency: 'EUR', provider: 'stripe', customer_external_id: 4 }
               }
        end

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns unprocessable entity with missing required params' do
        VCR.use_cassette('stripe_create_payment_intent_missing_params') do
          post '/payments_gateway/payments',
               params: {
                 payment: { provider: 'stripe' }
               }
        end

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
