# frozen_string_literal: true

class CreatePaymentsGatewayPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments_gateway_payments do |t|
      t.integer :amount
      t.string :currency
      t.string :customer_external_id
      t.json :intent
      t.string :provider
      t.timestamps
    end
  end
end
