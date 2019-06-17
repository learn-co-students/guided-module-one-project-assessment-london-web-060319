c1 = Customer.create(first_name: "Anne Marie", last_name: "O'Sullivan", date_of_birth: "August 10th 1993", address: "79 Skyline Plaza")
c2 = Customer.create(first_name: "Chris", last_name: "Russo", date_of_birth: "December 29th 1989", address: "355 East 126th Street")
c3 = Customer.create(first_name: "Katie", last_name: "Sammon", date_of_birth: "August 14th 1993", address: "7 Sefton Green")
c4 = Customer.create(first_name: "Laura", last_name: "Dent", date_of_birth: "October 16th 1993", address: "18 Killabbey")
c5 = Customer.create(first_name: "Hugo", last_name: "Smith", date_of_birth: "September 17th 1987", address: "177 Cherry Lane")

b1 = Bank.create(name_of_bank: "TD Bank")
b2 = Bank.create(name_of_bank: "Barclays")
b3 = Bank.create(name_of_bank: "AIB")
b4 = Bank.create(name_of_bank: "Monzo")
b5 = Bank.create(name_of_bank: "Revolut")

ac1 = Account.create(customer_id: 192834, bank_id: 83927, balance: 100000)
ac2 = Account.create(customer_id: 192835, bank_id: 98709, balance: 20000)
ac3 = Account.create(customer_id: 192836, bank_id: 73808, balance: 100)
ac4 = Account.create(customer_id: 192837 , bank_id: 63792, balance: 90)
ac5 = Account.create(customer_id: 192838, bank_id: 87989, balance: 45000000)

binding.pry
0
