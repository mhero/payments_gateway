Rails.application.routes.draw do
  mount PaymentsGateway::Engine => "/payments_gateway"
end
