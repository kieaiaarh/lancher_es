# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara'
require 'capybara/dsl'
require 'webmock/rspec'
require 'capybara/poltergeist'
require "active_decorator/rspec"

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!
POLTERGEIST_OPTIONS = {phantomjs_options: ['--load-images=no'], timeout: 60}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
end

Capybara.register_driver :iphone do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A365 Safari/600.1.4' }
  ghost
end

Capybara.register_driver :ipad do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53' }
  ghost
end

Capybara.register_driver :ipod do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (iPod touch; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53' }
  ghost
end

Capybara.register_driver :android do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LMY47Z) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.93 Mobile Safari/537.36' }
  ghost
end

Capybara.register_driver :android_tablet do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (Linux; Android 4.3; Nexus 7 Build/JSS15Q) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2307.2 Safari/537.36' }
  ghost
end

Capybara.register_driver :windows_phone do |app|
  ghost = Capybara::Poltergeist::Driver.new(app, POLTERGEIST_OPTIONS)
  ghost.headers = { 'User-Agent' => 'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; FujitsuToshibaMobileCommun; IS12T; KDDI)' }
  ghost
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :suite do
    WebMock.disable!
  end

  config.after :each do
    DatabaseRewinder.clean
  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
