

class CommandLineInterface

  # attr_accessor :name, :address, :bank, :account_opening
  # attr_reader :date_of_birth
  #
  # def initialize(name, address, date_of_birth, bank)
  #   @name = name
  #   @address = address
  #   @date_of_birth = date_of_birth
  #   @bank = bank
  #   @account_opening = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
  # end
  attr_reader :prompt

  def initialize
    @prompt = TTY::Prompt.new
  end

  def greet
    puts "Welcome to UK Online Banking"
    user = prompt.select("Do you have an account with us?", %w(Yes No))
    if user == 'No'
      create_account
    elsif user == 'Yes'
      user_login
    end
  end

  def user_login
    c_id = prompt.ask('Customer ID:', required: true)
    c_password = prompt.mask('Password:', required: true)
    puts c_id
    puts c_password
  end

  def create_account
    result = prompt.collect do
    key(:bank).select('Which bank would you like to join?', %w(Barclays Monzo Starling Santander Revolut), required: true)

    @first_name = prompt.ask('First Name?', required: true)

    @last_name = prompt.ask('First Name?', required: true)

    @date_of_birth = prompt.ask('Date of birth?', required: true)

    @balance = prompt.ask('Starting balance?', convert: :float, default: 100.00)

      street = prompt.ask('Street?', required: true)
      city =prompt.ask('City?', required: true)
      zip = prompt.ask('Zip?', validate: /\A\d{3}\Z/, required: true)
      @address = street + city + zip
      Customer.create(@first_name, @last_name, @date_of_birth, @balance, @address)
      Account.create(@user.id)
    end
  end



  def run
    greet
  end

end
