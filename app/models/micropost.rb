class Micropost < ActiveRecord::Base
  #Chapter 10: created model using _create_micoposts migration, from generate model command
  attr_accessible :content
  #Chapter 10, Listing 10.7: making ONLY content attribute accessible by removing :user_id

  #Chapter 10; Listing 10: mp belongs_to user
    belongs_to :user

  #10.18: validates length
  validates :content, presence: true, length: { maximum: 140 }

  #Chapter 10, Listing 10.4: validation for micropost's userid
  validates :user_id, presence: true

  #10.14: using default_scope to change order to display most recent 1st
  default_scope order: 'microposts.created_at DESC'

  #11.43: V1 of method
  def self.from_users_followed_by(user)
    #followed_user_ids = user.followed_user_ids
    #where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    #11.44: refactoring
    #where("user_id IN (:followed_user_ids) OR user_id = :user_id",
    #      followed_user_ids: followed_user_ids, user_id: user)
    #11.45: latest refactor, seems less rails-like
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
         user_id: user.id)
  end

end
