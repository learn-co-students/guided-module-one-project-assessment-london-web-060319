class Account < ActiveRecord::Base
  belongs_to :customer
  belongs_to :bank
  has_many :transactions

  def current_balance
    # starting balance + all the values of all the transations related to this account
    total_transactions = self.transactions.map {|transaction| transaction.amount}.sum
    self.balance + total_transactions
  end

end
