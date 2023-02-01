source 'https://rubygems.org'

gem 'activesupport', '~> 6.0'
gem 'hashie'
gem 'recursive-open-struct', '~> 1.1.0'
gem 'zeitwerk'

group :development, :test do
  gem 'awesome_print', '~> 1.8.0'
  gem 'rubocop', '~> 1.22.1'
end

group :test do
  gem 'minitest', '~> 5.0'
  gem 'minitest-great_expectations'
  gem 'minitest-reporters', '~> 1.3.6'
  gem 'rake', '~> 12.3'
  gem 'simplecov'
end
