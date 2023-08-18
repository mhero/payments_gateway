# PaymentsGateway
I created an endpoint to manage a payment creation and return the octo response asked n the challenge


## Usage
This is a rails engine that will expose functionality for payments
Currently it's using only stripe, but it's extendable to handle any other payment

This needs to be mounted as a gem in a rails app using the config described here


## Dependencies

* Ruby 3.2.2

## Local build

```ruby
gem build payments_gateway.gemspec
```

```ruby
gem uninstall ./payments_gateway-0.1.0.gem
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "payments_gateway"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install payments_gateway
```

Set `STRIPE_API_KEY` in `.env` file(you can use .env.test a reference)

Add:
`mount PaymentsGateway::Engine, at: "/payments_gateway/"` to `config/routes.rb`

Finally:

```bash
bin/rails payments_gateway:install:migrations
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
