#Listing 9.30: populating db w/sample users cuz the book doesn't know i have a bunch

#the book said i wasn't smurt enuff to understand this code but it looks like
#it's adding 100 users

#defining task db:populate
namespace :db do
  desc "Fill database with sample data"

  #giving Rake access to local enviro stuff
  task populate: :environment do
    User.create!(name:"Example User",
                  email: "example@railstutorial.org",
                  password: "foobar",
                  password_confirmation: "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end

#execute this code with:
#bundle exec rake db:reset
#bundle exec rake db:populate

=begin
!!!!! this didn't work!
rake aborted!
Don't know how to build task 'db:populate'
=end

#bundle exec rake db:test:prepare