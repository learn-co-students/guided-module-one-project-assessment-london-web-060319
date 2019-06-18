class Customer < ActiveRecord::Base
  has_many :accounts
  has_many :banks, through: :accounts


end
