# frozen_string_literal: true

module PaymentsGateway
  class Payment < ApplicationRecord
    validates :amount, :currency, :provider, presence: true
  end
end
