class CreateTransactionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :amount
      t.integer :account_id
    end
  end
end
