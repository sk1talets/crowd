class User < ActiveRecord::Base
    enum role: [:user, :admin]

    validates :name, presence: true,
                     length: { minimum: 4, maximum: 20},
                     format: { with: /\A[\s\w\-]+\z/i },
                     uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, length: { minimum: 6 }

    after_initialize :init
    def init
        self.role ||= "user"
    end
end
