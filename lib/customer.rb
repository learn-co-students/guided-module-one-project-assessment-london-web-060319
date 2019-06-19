class Customer < ActiveRecord::Base
  has_many :accounts
  has_many :banks, through: :accounts
  #
  # def display_balance
  #   self.accounts.map {|a| a.balance}.first.to_s
  # end
  def account_balances
    self.accounts.map {|a| a.balance}
  end

  def close_account
    @user_bank.account.destroy
  end
end
