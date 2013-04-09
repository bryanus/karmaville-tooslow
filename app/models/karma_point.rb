class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value, :user
  after_create :update_user_karma
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true

  def update_user_karma
  	self.user.sum = self.user.karma_points.sum("value")
  	self.user.save
  end
end
