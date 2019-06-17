class Bank < ActiveRecord::Base
  has_many :accounts
  has_many :customers, through: :accounts
end
