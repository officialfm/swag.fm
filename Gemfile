source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.8'
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'pg'
gem 'turbolinks'

# APIs
gem 'officialfm'
gem 'soundcloud'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

group :development do
  gem 'rack-mini-profiler'
end

group :test do
  gem 'mocha', require: false
end

group :production do
  gem 'newrelic_rpm'
  gem 'thin'
end
