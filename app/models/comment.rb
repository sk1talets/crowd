class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, :as => :item

  after_initialize :init
  def init
    self.vote_points ||= 0
  end
end
