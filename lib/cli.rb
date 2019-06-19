

class CommandLineInterface

  attr_reader :prompt
  attr_accessor :current_customer

  def initialize
    @prompt = TTY::Prompt.new
    @current_customer = nil
  end

  def greet
     puts "Welcome to UK Online Banking"
     user = prompt.select("Do you have an account with us?", %w(Yes No))
     if user == 'No'
       bank_list = Bank.all.map {|bank| bank.name_of_bank}
       bank_name = prompt.select('Which bank would you like to join?', [bank_list])
       @user_bank = Bank.all.find_by(name_of_bank: bank_name)
       # @user_bank = prompt.collect do
       #   key(:bank).select('Which bank would you like to join?', %w([bank_list], required: true)
       # end
       @current_customer = create_customer_from_form
       a = create_customer_account(@current_customer.id)
       puts "Your customer ID is #{@current_customer.id}."
       puts "Congratulations on your new account! Your account number is #{a.id}."
       user_display
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
      selection = prompt.select("What would you like to do today?", %w(Display_Balance  Close_Account Deposit))
       if selection == "Display_Balance"
         display_balance
       elsif selection == "Close Account"
         @current_customer.close_account
       elsif selection == "Deposit"
         deposit_amount = prompt.ask('How much would you like to deposit?')
         @current_customer.make_deposit(deposit_amount)
         puts @current_customer.accounts[0].balance
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
         customer_id: @current_customer.id,
         bank_id: @user_bank.id
       )
       a.save!
       a
      end


     def run
       greet
       user_display
     end

 end
