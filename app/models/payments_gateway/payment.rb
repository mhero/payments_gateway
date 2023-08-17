# frozen_string_literal: true

module PaymentsGateway
  class Payment < ApplicationRecord
    PROVIDERS = ['stripe'].freeze

    validates :amount, :currency, :provider, presence: true

    validates :provider, inclusion: PROVIDERS

    PROVIDERS.each do |attribute|
      define_singleton_method(:"#{attribute}?") do |attr_|
        attribute == attr_
      end
    end

    def provider_service
      # This method can support more providers by mapping them here
      return unless Payment.stripe?(provider)

      StripeService
    end
  end
end
