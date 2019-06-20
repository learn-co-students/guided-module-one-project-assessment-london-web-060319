class Author < ActiveRecord::Base

    has_many :books
    has_many :reviews, through: :books

    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    def self.most_reviewed
        Book.all.max_by {|book| book.reviews.count}.author.full_name
    end

    def self.reviews_by_author
        first_name = ask_input("What is the author's first name?")
        last_name = ask_input("What is the author's last name?")
        if author = Author.find_by(first_name: first_name, last_name: last_name)
            author.reviews
        else 
            puts "We don't have any books by that author yet!"    
            []
        end

    end
end