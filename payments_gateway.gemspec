# frozen_string_literal: true

require_relative 'lib/payments_gateway/version'

Gem::Specification.new do |spec|
  spec.name        = 'payments_gateway'
  spec.version     = PaymentsGateway::VERSION
  spec.authors     = ['Marco']
  spec.email       = ['gdmarav374@gmail.com']
  spec.homepage    = 'https://github.com/mhero/payments-gateway'
  spec.summary     = 'Summary of PaymentsGateway.'
  spec.description = 'Description of PaymentsGateway.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mhero/payments-gateway'
  spec.metadata['changelog_uri'] = 'https://github.com/mhero/payments-gateway'

  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'rspec-rails'

  spec.add_dependency 'pg'
  spec.add_dependency 'stripe'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.0.7'
end
