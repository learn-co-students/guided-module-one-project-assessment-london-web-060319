class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :customer_id
      t.integer :bank_id
      t.float :balance
      t.datetime :account_opening
      t.datetime :account_closing
    end
  end

end
