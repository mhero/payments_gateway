# frozen_string_literal: true

module PaymentsGateway
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
