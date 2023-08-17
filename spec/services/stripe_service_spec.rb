# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe StripeService do
    let(:amount) { payment.amount }
    let(:currency) { payment.currency }
    let(:clientSecret) { SecureRandom.uuid }
    let(:id) { SecureRandom.uuid }
    let(:publishableKey) { SecureRandom.uuid }

    context 'with valid payment provider' do
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

      let(:payment) { create(:payment) }
      it 'returns a complete card payment object' do
        expect(described_class.call(payment)).to eq(
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
          }
        )
      end
    end

    context 'with invalid payment provider' do
      let(:payment) { create(:payment, provider: 'other') }
      it 'returns a complete card payment object' do
        expect(described_class.call(payment)).to be_nil
      end
    end
  end
end
