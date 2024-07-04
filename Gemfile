source "https://rubygems.org"

gem "rails", "~> 7.2.0.beta2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem 'rspec-rails', '~> 6.1.0'
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "faker", "~> 3.4"
  gem 'pry-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem 'shoulda-matchers', '~> 6.0'
  gem "factory_bot", "~> 6.4"
end

gem "devise", "~> 4.9"
gem 'net-pop', github: 'ruby/net-pop'
