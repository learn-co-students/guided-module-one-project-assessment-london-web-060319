class CommandLineInterface
    def run
        user = beginning
        menu = ["What would you like to do?", "Write a review", "See all the books on our platform", "Edit a review","Delete a review"]
        puts_array(menu)
        choice = gets.chomp
        which_menu?(choice, menu, user)
    end    
        
        def which_menu?(choice, menu, user)
            if choice == menu[1]
                create_review(user)
                
            elsif choice == menu[2]
                puts_all_books    
            
            end

        end
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
        
    

    def puts_all_books
        puts "This are all the books on our platform:"
        Book.all.each {|book| puts "#{book.id}. #{book.title}"}
    end

    def beginning
        welcome_messages = ["Welcome to Fedsreads, the best book review platform in the world!",
        "Thinking of reading something but not sure what? We can help you with that!", 
        "First of all, what is your username?"]
        puts_array(welcome_messages)
        username = gets.chomp
        user = User.find_or_create_by(username: username)
        puts "Welcome #{username}!"
        return user
    end

    def puts_array(array)
        array.each {|item| puts item}
    end

    def puts_reviews(reviews)
        reviews.each {|review| puts "Review by #{review.user.username} - \"#{review.content}\""}
    end

    def create_review(user)
        puts "What book would you like to review?"
        puts_all_books
        book_title = gets.chomp
        book = Book.find_by(title: book_title)
        # binding.pry
        
        puts "Please write your review below"
        review_content = gets.chomp
    
        review = Review.create(content: review_content, book_id: book.id, user_id: user.id)
        puts "Successful!"
        book = Book.find_by(title: book_title)
        puts_reviews(book.reviews)
        
    end

    def puts_book_reviews(book) # delete method if write works
        book.reviews.each {|review| "Review @{book.id}.   "}
    end


end