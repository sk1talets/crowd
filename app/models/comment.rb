class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes, :as => :item
  
  attr_accessor :reply_depth

  after_initialize :init
  def init
    self.vote_points ||= 0
  end
end
