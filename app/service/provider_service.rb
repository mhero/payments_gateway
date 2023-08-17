# frozen_string_literal: true

class ProviderService < ApplicationService
  attr_reader :provider

  PROVIDERS = ['stripe'].freeze

  PROVIDERS.each do |attribute|
    define_singleton_method(:"#{attribute}?") do |attr_|
      attribute == attr_
    end
  end

  def initialize(provider)
    @provider = provider
  end

  def call
    # This method can support more providers by mapping them here
    return unless ProviderService.stripe?(@provider)

    StripeService
  end
end
