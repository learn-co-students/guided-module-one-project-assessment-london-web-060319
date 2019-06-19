class Account < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank

  # def deposit
  #
  #
  # end



end
