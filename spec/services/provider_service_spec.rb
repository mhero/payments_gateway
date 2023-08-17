# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe ProviderService do
    let(:valid_provider) { 'stripe' }
    let(:invalid_provider) { 'other' }

    it 'returns a service for a valid provider' do
      expect(described_class.call(valid_provider)).to eq(StripeService)
    end

    it 'returns nil for an invalid provider' do
      expect(described_class.call(invalid_provider)).to eq(nil)
    end
  end
end
