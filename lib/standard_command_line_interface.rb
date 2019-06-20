class CommandLineInterfaceStandard
    def run
        user = beginning
        menu(user)
    end    
        

    

    def which_menu?(choice, menu, user)
        if choice == menu[1]
            create_review(user)    
        elsif choice == menu[2]
            puts_all_books 
        elsif choice == menu[3]
            puts_reviews(Review.all)     
        elsif choice == menu[4]
            puts "Which of your reviews would you like to edit?"
            puts_reviews(user.reviews)
            review_id = gets.chomp
            review = Review.find_by(id: review_id)
            if user.reviews.include? review
                puts "Please write your review below"
                review_content = gets.chomp
                review.update_attribute(:content, review_content)
            else
                puts "You can't edit this review."
                which_menu?(choice, menu, user)
            end                           ####
        elsif choice == menu[5]
            puts "Please type the number of the review you would like to delete:"
            puts_reviews(user.reviews)
            review_id = gets.chomp
            if Review.find_by(id: review_id, user_id: user.id)
                Review.delete(review_id)    
                puts "The review has been deleted!"
            else
                puts "You can't delete this review."
            end
        elsif choice == menu[6]
            return
        else
            puts "Sorry, was that a typo?"
            self.menu(user)
        end
        self.menu(user)
    end


        # if book.reviews == []
        #     puts "No reviews for this one yet!"
        # else
        #     book.reviews
        # end

       
       
   
    def puts_array(array)
        array.each {|item| puts item}
    end

    

    #INSIDE NEW FILE

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

    def menu(user)
        menu = ["What would you like to do?", "Write a review", "See all books", "See all reviews", "Edit a review", "Delete a review", "Exit"]
        puts_array(menu)
        choice = gets.chomp
        which_menu?(choice, menu, user)
    end

    def create_review(user)
        puts "What book would you like to review?"
        puts_all_books
        book_title = gets.chomp
        book = Book.find_by(title: book_title)        
        puts "Please write your review below"
        review_content = gets.chomp    
        review = Review.create(content: review_content, book_id: book.id, user_id: user.id)
        puts "Successful!"
        book = Book.find_by(title: book_title)
        puts_reviews(book.reviews)
        
    end

    def puts_reviews(reviews)
        reviews.each {|review| puts "#{review.id}. Book: \"#{review.book.title}\", User: #{review.user.username} - #{review.content}"}
    end

    def puts_all_books
        puts "This are all the books on our platform:"
        Book.all.each {|book| puts "#{book.id}. #{book.title}"}
    end

end