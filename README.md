# PaymentsGateway
I'm managing this project using an engine to ensure easy connectivity to any Rails app. I've created an endpoint to handle payment creation and return the Octo response as required in the challenge. The flow of the gem is as follows:

First, create the payment on the app's side to maintain traceability of the actions.<br/>
Next, attempt to create the intent on the Stripe side.<br/>
If everything is successful, return the card payment with Stripe information.<br/>
If the Stripe side fails, we still have data on the created payment.<br/>
This effectively manages the payment intent. While we could expose another endpoint for the payment confirmation webhook, that seems to be beyond the scope of the test.<br/>

I'm using VCR to manage the integration test with Stripe, and RSpec for the rest of the tests.<br/>
Finally, this challenge doesn't take into consideration any authorization/authentication, which I also consider outside of the challenge, but should be added to handle security.

## Usage
This is a rails engine that will expose functionality for payments<br/>
Currently it's using only stripe, but it's extendable to handle any other payment<br/>

This needs to be mounted as a gem in a rails app using the config described here


## Dependencies

* Ruby 3.2.2

## Local build

```ruby
gem build payments_gateway.gemspec
```

```ruby
gem install ./payments_gateway-0.1.0.gem
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
