class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    #11.1: adding indexes to tbl
    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
    #composite index: enforces uniqueness of pairs so can't be followed more than once
    add_index :relationships, [:followed_id, :follower_id], unique: true


  end
end
