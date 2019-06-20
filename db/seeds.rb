User.delete_all
Book.delete_all
Review.delete_all
# Users

8.times {User.create(username: Faker::GreekPhilosophers.unique.name.delete(" "))}

# Books

13.times {Book.create(title: Faker::Book.unique.title.downcase.capitalize)}

# Reviews

20.times {Review.create(user_id: User.all.sample.id, book_id: Book.all.sample.id, content: Faker::GreekPhilosophers.unique.quote)}

