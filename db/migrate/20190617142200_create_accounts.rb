class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :customer
      t.string :bank
      t.float :balance
      t.datetime :account_opening
      t.datetime :account_closing
    end
  end
end
