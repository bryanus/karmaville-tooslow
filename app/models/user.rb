class User < ActiveRecord::Base
  has_many :karma_points
  after_create :update_karma
  attr_accessible :first_name, :last_name, :email, :username, :sum

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}
  
  # def set_sum
  #   self.update_attribute(:sum, 0)
  #   self.save
  # end

  def self.page(next_page)
    limit(50).offset(next_page.to_i - 1)
  end
  
  def update_karma
    val = self.karma_points.sum("value")
    # if val > 0 || val.nil? 
      self.update_attribute(:sum, val)
    # else
    #   self.update_attribute(:sum, 0)
    # end
  end

  def self.by_karma
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
    order("sum DESC")
  end

  def total_karma
    self.sum
    #.sum(:value)
    # KarmaPoint.total_karma_by_user_id(self.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
