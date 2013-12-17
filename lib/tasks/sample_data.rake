#Listing 9.30: populating db w/sample users cuz the book doesn't know i have a bunch

#the book said i wasn't smurt enuff to understand this code but it looks like
#it's adding 100 users

#defining task db:populate
namespace :db do
  desc "Fill database with sample data"

  #giving Rake access to local enviro stuff
  task populate: :environment do
    admin = User.create!(name:"Example User",
                  email: "example@railstutorial.org",
                  password: "foobar",
                  password_confirmation: "foobar")
    #Listing 9,41: making 1st sample user an admin
    admin.toggle!(:admin)
    #now reset & re-populate the db w/this info
    #b e r db:reset
    #b e r db:populate
    #b e r db:test:prepare
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end

    #this was above but upon merge I found my file & moved this here
    #10.23: Adding mp's to sample data, looping thru 6 users & adding 50 mp's
    users = User.all(limit: 6)
        51.times do
          content = Faker::Lorem.sentence(5)
          users.each { |user| user.microposts.create!(content: content) }
          #to generate:
          #bundle exec rake db:reset
          # bundle exec rake db:populate

        end


  end
end

#this is old stuff from failure, leaving in here for now
#got code from here: http://railsguides.net/2012/03/14/how-to-generate-rake-task/

#When I did this:
#               rails generate task sample_data populate
#I got this:
#namespace :sample_data do
#  desc "TODO"
#  task :populate => :environment do
#  end
#
#end

#execute this code with:
#bundle exec rake db:reset
#bundle exec rake db:populate

=begin
!!!!! this didn't work!
rake aborted!
Don't know how to build task 'db:populate'
=end

#bundle exec rake db:test:prepare
