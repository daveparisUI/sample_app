source 'https://rubygems.org'

#book listing 5.1.2
#gem 'rails', '3.2.3'
#gem 'bootstrap-sass', '2.0.0'

#web listing 5.1.2
gem 'rails', '3.2.15'
gem 'bootstrap-sass', '2.1'

#Listing 9.29: using to add more users cuz book doesn't know I have a few
#being added via a rake task in lib/tasks/sample_data.rake
gem 'faker', '1.0.1'

#Listing 9.31: Will Paginate gem
gem 'will_paginate', '3.0.3'

gem 'bcrypt-ruby', '3.0.1'

#found these here: http://stackoverflow.com/questions/12040518/paginate-method-is-not-found-on-activerecordrelation-with-metasearch
#10.22, was getting a "no method found for paginate" & didn't have these gems
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

#10.23: !!!! NOT SURE IF THIS IS RIGHT BUT FAKER WAS CAUSING PROBLEMS !!!!!
gem 'faker', '1.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.9.0'
  gem 'guard-rspec', '0.5.5'
  gem 'annotate', '~> 2.4.1.beta'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby
end

gem 'jquery-rails', '2.0.2'


group :production do
  #heroku postgreSQL gem for deployment
  gem 'pg', '0.12.2'
end

# Test gems on Macintosh
group :test do

  #*&*&* This was above so I moved into here &commented out the dups

#group :test do
#  gem 'rspec-rails', '2.9.0'
#  gem 'capybara', '1.1.2'
#  gem 'factory_girl_rails', '1.4.0'
  gem 'cucumber-rails', '1.2.1', :require =>false
  gem 'database_cleaner', '0.7.0'
#end

  gem 'rspec-rails', '2.9.0'
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.4.3.1', :require => false
  gem 'growl', '1.0.3'
  gem 'guard-spork', '0.3.2'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.4.0'
  gem 'launchy'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
