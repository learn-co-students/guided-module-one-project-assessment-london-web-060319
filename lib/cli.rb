

class CommandLineInterface

  attr_reader :prompt

  def initialize
    @prompt = TTY::Prompt.new
  end

  def greet
     puts "Welcome to UK Online Banking"
     user = prompt.select("Do you have an account with us?", %w(Yes No))
     if user == 'No'
       c = create_customer_from_form
       a = create_customer_account(c.id)
       puts "Your customer ID is #{c.id}."
       puts "Congratulations on your new account! Your account number is #{a.id}."
     elsif user == 'Yes'
       user_login

       # TODO: Add menu items: New account, delete account, deposit, withdraw
     end
   end

   def user_login
       customer_info = prompt.collect do
         key(:id).ask('Customer ID:')
         key(:last_name).ask('Surname:')
       end

       @current_customer = Customer.find_by(id: customer_info[:id], last_name: customer_info[:last_name])
       # if @current_customer.empty?
       #   raise "Invalid account info!"
       # end
     end

     def user_display
      selection = prompt.select("What would you like to do today?", %w(Display_Balance Deposit Withdrawal Close_Account))
       if selection == "Display_Balance"
         display_balance
       # elsif user == "Deposit"
       #   deposit
       # elsif user == "Withdrawal"
       #   withdrawal
       # end
     end
     end

     def display_balance
       puts @current_customer.account_balances
     end

     def create_customer_from_form
       customer_attrs = prompt.collect do
         key(:first_name).ask('First name:', required: true)
         key(:last_name).ask('Surname:', required: true)
         key(:date_of_birth).ask('Date of birth (DD-MM-YYYY):', required: true)
         key(:address).ask('Address:', required: true)
       end

       c = Customer.new(**customer_attrs)
       c.save!
       c
     end

     def create_customer_account(customer_id)
       account_attrs = prompt.collect do
         key(:deposit_amt).ask('Deposit amount:', required: true)
       end

       a = Account.new(
         balance: account_attrs[:deposit_amt],
         customer_id: customer_id
         # bank_id: bank_id
       )
       a.save!
       a
     end


     def run
       greet
       user_display
     end
   end
