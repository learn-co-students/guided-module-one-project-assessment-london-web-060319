class CommandLineInterface
    def run
        
        
        
        # "Enter a book title to get started:"]
        # puts_array(welcome_messages)
        # book_title = gets.chomp 
        # book = Book.find_by(title: book_title)
        # book.reviews
        # if book.reviews == []
        #     puts "No reviews for this one yet!"
        # else
        #     book.reviews
        # end
        
    end

    def show_all_books
        Book.all.map {|book| puts book.title}
    end

    def beginning
        welcome_messages = ["Welcome to Fedsreads, the best book review platform in the world!",
        "Thinking of reading something but not sure what? We can help you with that!", 
        "First of all, what is your username?"]
        puts_array(welcome_messages)
        username = gets.chomp
        User.find_or_create_by(username: username)
        puts "Welcome #{username}!"
    end

    def puts_array(array)
        array.each {|item| puts item}
    end

    def puts_reviews(reviews)
        reviews.each {|review| puts "Review by user - #{review.user.username} - \n \"#{review.content}\""}
    end

    def create_review
        puts "What book would you like to review?"
        book_title = gets.chomp
        book = Book.find_by(title: book_title)
        puts "Please write your review below"
        review_content = gets.chomp
        review = Review.create(content: review_content, book_id: book.id)
        # binding.pry
        # review.book = book
        # binding.pry
        book.reviews
        # binding.pry
    end


end