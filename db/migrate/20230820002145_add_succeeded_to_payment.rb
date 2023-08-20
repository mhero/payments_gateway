# frozen_string_literal: true

class AddSucceededToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments_gateway_payments, :succeeded_at, :timestamp
  end
end
