# frozen_string_literal: true

class ProviderService < ApplicationService
  attr_reader :provider

  def initialize(provider)
    @provider = provider
  end

  def call
    return unless ProviderService.stripe?(@provider)

    StripeService
  end

  def self.stripe?(provider)
    provider == 'stripe'
  end
end
