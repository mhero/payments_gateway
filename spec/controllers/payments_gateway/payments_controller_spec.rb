# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe '/payments', type: :request do
    describe 'POST /create' do
      let(:attributes) do
        { amount: 1000, customer: 'me@example.com', currency: 'EUR', provider: 'stripe' }
      end

      context 'with valid parameters' do
        let(:amount) { attributes[:amount] }
        let(:clientSecret) { SecureRandom.uuid }
        let(:currency) { attributes[:currency] }
        let(:id) { SecureRandom.uuid }
        let(:publishableKey) { SecureRandom.uuid }

        before do
          expect(Stripe::PaymentIntent).to receive(:create).and_return(
            {
              id:,
              publishableKey:,
              clientSecret:,
              amount:,
              currency:
            }
          )
        end

        it 'creates a new payment' do
          expect do
            post payments_gateway.payments_url,
                 params: { payment: attributes }, as: :json
          end.to change(Payment, :count).by(1)
        end

        it 'renders a valid JSON response' do
          post payments_gateway.payments_url,
               params: { payment: attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(response.body).to eq(
            {
              gateway: 'stripe',
              stripe: {
                version: 'latest',
                paymentIntent: {
                  id:,
                  publishableKey:,
                  clientSecret:,
                  amount:,
                  currency:
                }
              }
            }.to_json
          )
        end
      end

      context 'with invalid parameters' do
        context 'with all invalid params' do
          let(:attributes) do
            { amount: nil, customer: nil, currency: nil }
          end

          it 'does not create a new payment' do
            expect do
              post payments_gateway.payments_url,
                   params: { payment: attributes }, as: :json
            end.not_to change(Payment, :count)
          end

          it 'renders a empty JSON response' do
            post payments_gateway.payments_url,
                 params: { payment: attributes }, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end

        context 'with invalid provider params' do
          let(:attributes) do
            { amount: 1000, customer: 'me@example.com', currency: 'EUR', provider: 'other' }
          end

          it 'does not create a new payment' do
            expect do
              post payments_gateway.payments_url,
                   params: { payment: attributes }, as: :json
            end.not_to change(Payment, :count)
          end

          it 'renders a empty JSON response' do
            post payments_gateway.payments_url,
                 params: { payment: attributes }, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including('application/json'))
          end
        end
      end
    end
  end
end
