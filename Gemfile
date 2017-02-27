source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'twitter-bootstrap-rails'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'foreman'
gem 'graphql'
gem 'faker'
gem 'factory_girl_rails'
gem 'haml-rails'

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem "guard-rspec"
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "spring-commands-rspec"
  gem 'listen', '~> 3.0.5'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end
