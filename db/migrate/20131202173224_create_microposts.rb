class CreateMicroposts < ActiveRecord::Migration
#Chapter 10: creating Micropost model, used: rails generate model Micropost content:string user_id:integer

  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    #Listing 10.1: adding index on user_id
    # bundle exec rake db:migrate
    # bundle exec rake db:test:prepare
    #multiple key index; using both keys from array @ same time
    add_index :microposts, [:user_id, :created_at]
  end
end
