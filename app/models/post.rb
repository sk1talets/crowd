class Post < ActiveRecord::Base
    belongs_to :user
    validates :text, length: { minimum: 100 }
end
