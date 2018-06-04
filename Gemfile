source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem "animate-rails"
gem 'autosize-rails'
gem 'aws-sdk-v1'
gem 'aws-sdk', '~> 2'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'friendly_id', '~> 5.1.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-fileupload-rails'
gem 'jquery-rails'
gem 'jquery-atwho-rails'
gem 'paperclip', '~> 4.1'
gem 'paper_trail'
gem 'pg'
gem "puma"
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.1.2'
gem 'rails_autolink'
gem 'redcarpet'
gem 'searchkick'
gem 'sass-rails', '~> 5.0'
gem 'semantic-ui-sass'
gem "sentry-raven"
gem 'social-share-button'
gem 'sqlite3'
gem 'rails-assets-sweetalert2', source: 'https://rails-assets.org'
gem 'therubyracer'
gem 'tooltipster-rails'
gem 'turbolinks', '~> 5'
gem 'typedjq-rails'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'


gem 'mini_magick'
gem 'rails-assets-jcrop', source: 'https://rails-assets.org'
gem  'papercrop'

# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "omniauth-google-oauth2"
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'letter_opener'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
