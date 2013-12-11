# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#create users
User.create(name: 'Average Schmoe', email: 'someone@test.com', password: 'abc123', password_confirmation: 'abc123')
admin = User.create(name: 'Admin Guy', email: 'topdog@test.com', password: 'secret', password_confirmation: 'secret')
admin.admin = true
admin.save!

