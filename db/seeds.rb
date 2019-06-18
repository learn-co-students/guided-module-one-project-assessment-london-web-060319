# Users

10.times {User.create(username: Faker::Hipster.unique.word)}

# Books

10.times {Book.create(title: Faker::Book.unique.title)}

# Reviews

10.times {Review.create(user_id: User.all.sample.id, book_id: Book.all.sample.id, content: Faker::Hipster.unique.sentence(3, true))}

