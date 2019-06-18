$prompt = TTY::Prompt.new

def welcome_msg
    system 'clear'
    $prompt.say("Welcome to Fedsreads, the best book review platform in the world!\nThinking of reading something but not sure what? We can help you with that!")
end

def this_user
    username = $prompt.ask("What is your username?")
    user = User.find_or_create_by(username: username)
    return user
end

def failed(message, choice, user) 
    system "clear"
    $prompt.say("#{message}")
    $prompt.ask("Press enter to continue", echo: false)
    which_choice?(choice, user)
end

def success(message, user)
    system "clear"
    $prompt.say("#{message}")
    $prompt.ask('Press enter to continue', echo: false)
    menu(user)
end

def menu(user)
    system "clear"
    $prompt.say("Welcome #{user.username}!")
    choice = $prompt.select("What would you like to do?") do |menu|
        menu.choice "Write a review", 1
        menu.choice "See all books", 2
        menu.choice "See all reviews", 3
        menu.choice "Edit a review", 4
        menu.choice "Delete a review", 5
        menu.choice "Exit"
    end
    which_choice?(choice, user)
end

def which_choice?(choice, user)
    system "clear"
    if choice == 1
        create_review(user)
    elsif choice == 2 
        puts_all_books
        $prompt.ask("\nPress enter to go back to main menu", echo: false)
        menu(user)
    elsif choice == 3
        puts_reviews(Review.all)
        $prompt.ask("\nPress enter to go back to main menu", echo: false)
        menu(user)
    elsif choice == 4
        edit_review(user)
    elsif choice == 5
        delete_review(user)
    end
end

def create_review(user)
    puts_all_books
    book_title = $prompt.ask("What book would you like to review?")
    book = Book.find_or_create_by(title: book_title)
    review_content = $prompt.ask("Please write your review here")
    review = Review.create(content: review_content, book_id: book.id, user_id: user.id)
    message = "Thank you! Your review was added to our collection!"
    success(message, user)
end

def puts_all_books
    $prompt.say("These are all the books on our platform: \n")
    Book.all.each {|book| puts "#{book.id}. #{book.title}"}
end

def puts_reviews(reviews)
    reviews.each {|review| puts "#{review.id}. Book: \"#{review.book.title}\", User: #{review.user.username} - #{review.content}"}
end

def edit_review(user)
    puts_reviews(user.reviews)
    review_id = $prompt.ask("Pick the number of the review you would like to edit")
    review = Review.find_by(id: review_id)
    if user.reviews.include? review
        review_content = $prompt.ask("Please write your review")
        review.update_attribute(:content, review_content)
        message = "Your review is now updated."
        success(message, user)
    else
        message = "You can't edit this review."
        failed(message, 4, user)
    end     
end

def delete_review(user)
    puts_reviews(user.reviews)
    review_id = $prompt.ask("Please type the number of the review you would like to delete:")
    
    if Review.find_by(id: review_id, user_id: user.id)
        Review.delete(review_id)    
        message = "Success! The review has been deleted!"
        success(message, user)
    else
        message = "You can't delete this review."
        failed(message, 5, user)
    end
end
