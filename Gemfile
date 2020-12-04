source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'bullet', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'pry-byebug', '~> 3.9'
end

group :development do
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  gem 'brakeman', '~> 4.10'
  gem 'listen', '~> 3.2'
  gem 'rails_best_practices', '~> 1.20'
  gem 'reek', '~> 6.0', '>= 6.0.1'
  gem 'rubocop-rails', '~> 2.8', '>= 2.8.1'
  gem 'rubocop-rootstrap', '~> 1.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker', '~> 2.15', '>= 2.15.1'
  gem 'rspec-json_expectations', '~> 2.2'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
  gem 'simplecov', '~> 0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
