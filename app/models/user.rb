class User < ActiveRecord::Base
    has_many :posts
    has_many :comments
    has_many :votes
    enum role: [:user, :admin]

    validates :name, presence: true,
                     length: { minimum: 4, maximum: 20},
                     format: { with: /\A[\s\w\-]+\z/i },
                     uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: { on: create }, length: { minimum: 6 }, :if => :password_digest_changed?

    after_initialize :init
    def init
        self.role ||= "user"
        self.vote_weight ||= 1
    end
end
