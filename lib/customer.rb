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

  def make_deposit(deposit_amount)
    if deposit_amount != nil
      self.accounts[0].balance += deposit_amount.to_i
      self.accounts[0].save
    end
  end
end
