class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  #11.6: adding belongs_to associations to Relationship model
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  #11.8: Relationship model validations
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
