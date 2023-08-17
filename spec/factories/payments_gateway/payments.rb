# frozen_string_literal: true

FactoryBot.define do
  factory :payment, class: PaymentsGateway::Payment do
    amount { 100 }
    currency { 'EUR' }
    provider { 'stripe' }
  end
end
