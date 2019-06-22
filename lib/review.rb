class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :book


    def self.longest
        find_by(content: Review.pluck(:content).max_by(&:length))
    end

    def self.sort_by_author
        self.all.sort_by {|review| review.book.author_id}
    end

end