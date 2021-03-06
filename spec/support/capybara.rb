require "capybara/poltergeist"
require "capybara/rspec"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, url_whitelist: [])
end

Capybara.app = Sinatra::Application
Capybara.default_driver = :poltergeist
