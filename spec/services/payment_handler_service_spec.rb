# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe PaymentHandlerService do
    subject { described_class.new(payment).call }

    let(:amount) { payment.amount }
    let(:clientSecret) { SecureRandom.uuid }
    let(:currency) { payment.currency }
    let(:id) { SecureRandom.uuid }
    let(:publishableKey) { SecureRandom.uuid }

    context 'with a valid payment' do
      before do
        allow_any_instance_of(StripeService).to receive(:publishable_key).and_return(publishableKey)
        expect(Stripe::PaymentIntent).to receive(:create).and_return(
          {
            id:,
            clientSecret:,
            amount:,
            currency:
          }
        )
      end

      let(:payment) { build(:payment) }

      it 'creates a new payment record' do
        expect { subject }.to change(Payment, :count).by(1)
      end

      it 'returns a success response' do
        expect(subject.success?).to be true
      end
    end

    context 'with invalid payment' do
      let(:payment) { build(:payment, amount: nil) }

      it 'does not create a new payment record' do
        expect { subject }.not_to change(Payment, :count)
      end

      it 'returns an error response' do
        expect(subject.success?).to be false
      end
    end

    context 'with invalid provider' do
      let(:payment) { build(:payment, provider: 'other') }

      it 'does not create a new payment record' do
        expect { subject }.not_to change(Payment, :count)
      end

      it 'returns an error response' do
        expect(subject.success?).to be false
      end
    end
  end
end
