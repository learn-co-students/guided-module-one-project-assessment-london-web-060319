class Book < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews
    belongs_to :author

    def self.find_reviews_of(book_title)
        book = Book.find_by(title: book_title)
        if book
            book.reviews
        else
            puts "We don't have that book yet!"
            return []
        end
    end

    def self.average_reviews_per_book
        Review.all.count.to_f / Book.all.count
    end

    def self.alphabetize_titles
        Book.all.order(:title)
    end

    def self.most_reviewed
        [Book.all.max_by {|book| book.reviews.count}]
    end

    def self.ordered_by_n_reviews
        Book.all.sort_by {|book| book.reviews.count}.reverse
    end


end