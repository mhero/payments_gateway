# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe StripeService do
    let(:amount) { payment.amount }
    let(:currency) { payment.currency }
    let(:clientSecret) { SecureRandom.uuid }
    let(:id) { SecureRandom.uuid }
    let(:publishableKey) { SecureRandom.uuid }

    context 'with no payment' do
      let(:payment) { nil }

      it 'returns a complete card payment object' do
        subject = described_class.call(payment)
        expect(subject.success?).to be false
        expect(subject.result).to eq('no payment provided')
      end
    end

    context 'with valid payment provider' do
      context 'with successful intent' do
        before do
          allow_any_instance_of(described_class).to receive(:publishable_key).and_return(publishableKey)
          expect(Stripe::PaymentIntent).to receive(:create).and_return(
            {
              id:,
              clientSecret:,
              amount:,
              currency:
            }
          )
        end

        let(:payment) { create(:payment) }
        it 'returns a complete card payment object' do
          subject = described_class.call(payment)
          expect(subject.success?).to be true
          expect(subject.result).to eq(
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
      context 'with failed intent' do
        before do
          allow(Stripe::PaymentIntent).to receive(:create).and_raise(Stripe::InvalidRequestError.new('some error', nil))
        end

        let(:payment) { create(:payment) }
        it 'returns a complete card payment object' do
          subject = described_class.call(payment)
          expect(subject.success?).to be false
          expect(subject.result).to eq('unable to create payment intent')
        end
      end
    end
  end
end
