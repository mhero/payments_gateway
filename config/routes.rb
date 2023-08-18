# frozen_string_literal: true

PaymentsGateway::Engine.routes.draw do
  resources :payments, only: [:create]
end
