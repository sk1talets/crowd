class Post < ActiveRecord::Base
    validates :text, length: { minimum: 100 }
end
