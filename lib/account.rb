class Account < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank

  # 
  # def display_balance
  #   "Your balance is £#{@balance}"
  # end
  #
  #


end
