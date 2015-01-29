class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, :as => :item, dependent: :destroy
  validates :text, length: { minimum: 100 }
  
  after_initialize :init
  def init
      self.vote_points ||= 0
  end
end
