# PaymentsGateway
Short description and motivation.

## Usage
How to use my plugin.

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

Set `STRIPE_API_KEY` in `.env` file

Add:
`mount PaymentsGateway::Engine => "/payments_gateway/"` to `config/routes.rb`

Finally:

```bash
bin/rails payments_gateway:install:migrations
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
