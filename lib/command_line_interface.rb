$prompt = TTY::Prompt.new

def welcome_msg
    system 'clear'
    $prompt.say("Welcome to FedsReads, the best book review platform in the world!\nThinking of reading something but not sure what? We can help you with that!")
end

def this_user
    username = ask_input("What is your username?")
    user = User.find_or_create_by(username: username)
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
    $prompt.ask("Press enter to continue", echo: false)
    menu(user)
end

def press_enter_to_main_menu(user)
    $prompt.ask("\nPress enter to go back to main menu", echo: false)
    menu(user)
end

def menu(user)
    system "clear"
    user.reload()
    $prompt.say("Welcome #{user.username}!")
    choice = $prompt.select("What would you like to do?") do |menu|
        menu.choice "Write a review", 1
        menu.choice "Who's the chattiest user?", 8
        menu.choice "See all books", 2
        menu.choice "See my books", 6
        menu.choice "What is the most reviewed book?", 15
        menu.choice "See books in alphabetical order", 11
        menu.choice "See books ordered by number of reviews", 16
        menu.choice "See all the authors on our platform", 13
        menu.choice "Who is the most reviewed author?", 14
        menu.choice "See all reviews", 3
        menu.choice "See my reviews", 7
        menu.choice "See reviews sorted by author", 17
        menu.choice "What author's reviews do you want to read?", 18
        menu.choice "What book's reviews do you want to read?", 10
        menu.choice "Which is the longest review?", 9
        menu.choice "Average reviews per book", 12
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
        puts_certain_books(Book.all, "These are all the books on our platform: \n")
        press_enter_to_main_menu(user)
    elsif choice == 3
        puts_certain_reviews(Review.all, "These are all the reviews on our platform:\n")
        press_enter_to_main_menu(user)
    elsif choice == 4
        edit_review(user)
    elsif choice == 5
        delete_review(user)
    elsif choice == 6
        puts_certain_books(user.books, "These are all the books you have reviewed so far:\n")
        press_enter_to_main_menu(user)
    elsif choice == 7
        puts_certain_reviews(user.reviews, "These are all your reviews:\n")  
        press_enter_to_main_menu(user)   
    elsif choice == 8
        $prompt.say("The longest review so far is by: #{User.chattiest.username}")
        press_enter_to_main_menu(user)
    elsif choice == 11
        puts_certain_books(Book.alphabetize_titles, "These are our books in alphabetical order:\n")
        press_enter_to_main_menu(user)
    elsif choice == 10
        puts_certain_books(Book.all, "These are all of our books: \n")
        book_title = ask_input("Please type the book title")
        puts_certain_reviews(Book.find_reviews_of(book_title), "These are the reviews for \"#{book_title}\"")
        press_enter_to_main_menu(user)
    elsif choice == 9
        review = Review.longest
        $prompt.say("#{review.id}. Book: \"#{review.book.title}\", User: #{review.user.username} - #{review.content}")
        press_enter_to_main_menu(user)
    elsif choice == 12
        $prompt.say("The average reviews per book are: #{Book.average_reviews_per_book}")
        press_enter_to_main_menu(user)
    elsif choice == 13
        Author.all.map {|author| puts "#{author.full_name}"}
        press_enter_to_main_menu(user)
    elsif choice == 14
        $prompt.say("Our most reviewed author is: #{Author.most_reviewed}")
        press_enter_to_main_menu(user)
    elsif choice == 15
        puts_certain_books(Book.most_reviewed, "This is our most reviewed book:\n")
        press_enter_to_main_menu(user)
    elsif choice == 16
        puts_certain_books(Book.ordered_by_n_reviews, "These are the books ordered by number of reviews:\n")
        press_enter_to_main_menu(user)
    elsif choice == 17
        puts_certain_reviews(Review.all.sort_by_author, "Here are the reviews grouped by author:\n")
        press_enter_to_main_menu(user)
    elsif choice == 18
        puts_certain_reviews(Author.reviews_by_author, "Here are their reviews:\n")
        press_enter_to_main_menu(user)
    end
end

def ask_input(sentence)
    user_input = $prompt.ask(sentence) do |q|
        q.required true
        q.modify :capitalize
    end
end

def create_review(user)
    puts_certain_books(Book.all, "These are all of our books: ")
    book_id = ask_input("Please type the number of the book you would like to review, or 0 to add a new book and review it:").to_i
    if book_id == 0
        book_title = ask_input("What is the title of the book you want to review?")
        synopsis = Faker::Hipster.sentence
        author_first_name = ask_input("What is the author's first name?")
        author_last_name = ask_input("What is the author's last name?")
        author_id = (Author.find_or_create_by(first_name: author_first_name, last_name: author_last_name)).id
        book = Book.create(title: book_title, author_id: author_id, synopsis: synopsis)
        review_content = ask_input("Please write your review here")
        review = Review.create(content: review_content, book_id: book.id, user_id: user.id)
        success("Thank you! Your review was added to our collection!", user)
    else 
        book = Book.find_by(id: book_id)
        review_content = ask_input("Please write your review here")
        review = Review.create(content: review_content, book_id: book.id, user_id: user.id)
        success("Thank you! Your review was added to our collection!", user)
    end
end

def puts_certain_books(books, message)
    $prompt.say(message)                                                 
    books.each {|book| puts "#{book.id}. \"#{book.title}\", written by: #{book.author.full_name}, synopsis: #{book.synopsis}"}
end

def puts_certain_reviews(reviews, message)
    if !reviews.empty?
        $prompt.say(message)
        reviews.each {|review| puts "#{review.id}. Book: \"#{review.book.title}\", User: #{review.user.username} - #{review.content}"}
    end
end

def edit_review(user)
    if user.reviews.count == 0
        puts "You haven't reviewed any book yet!"
        $prompt.ask("\nPress enter to go back to main menu", echo: false)
        menu(user)
    else
        puts_certain_reviews(user.reviews, "These are all your reviews:\n")
        review_id = ask_input("Pick the number of the review you would like to edit").to_i
        review = Review.find_by(id: review_id)
        if user.reviews.include?(review)
            review_content = ask_input("Please write your review")
            review.update_attribute(:content, review_content)
            success("Your review is now updated.", user)
        else
            message = "You can't edit this review."
            failed(message, 4, user)
        end
    end     
end

def delete_review(user)
    if user.reviews.count == 0
        puts "You haven't reviewed any book yet!"
        $prompt.ask("\nPress enter to go back to main menu", echo: false)
        menu(user)
    else
        puts_certain_reviews(user.reviews, "These are your reviews:\n")
        review_id = ask_input("Please type the number of the review you would like to delete:").to_i
        review = Review.find_by(id: review_id, user_id: user.id)
        if user.reviews.include? review
            book = review.book
            author = book.author
            Review.delete(review_id)
            if book.reviews.empty?
                book.delete
            end
            if author.reviews.empty?
                author.delete
            end
            message = "Success! The review has been deleted!"
            success(message, user)
        else
            message = "You can't delete this review."
            failed(message, 5, user)
        end
    end
end


