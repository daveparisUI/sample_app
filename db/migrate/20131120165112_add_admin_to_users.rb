class AddAdminToUsers < ActiveRecord::Migration
  def change
    #Listing 9.40: adding default false explicitly even though it's not needed
    #then run bundle exec rake db:migrate
    #& bundle exec rake db:test:prepare
    add_column :users, :admin, :boolean, default: false
  end
end
