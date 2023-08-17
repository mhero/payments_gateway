# frozen_string_literal: true

require 'rails_helper'

module PaymentsGateway
  RSpec.describe Payment, type: :model do
    let(:valid_attributes) do
      { amount: 500, customer_external_id: 'me@example.es', currency: 'EUR', provider: 'stripe' }
    end

    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column(:currency).of_type(:string) }
    it { is_expected.to have_db_column(:customer_external_id).of_type(:string) }
    it { is_expected.to have_db_column(:intent).of_type(:json) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
  end
end
