#10.23: Adding mp's to sample data, looping thru 6 users & adding 50 mp's
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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


