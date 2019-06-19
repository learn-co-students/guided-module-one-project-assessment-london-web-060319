class User < ActiveRecord::Base
    has_many :reviews
    has_many :books, through: :reviews


    def self.chattiest
        Review.longest.user
    end

end