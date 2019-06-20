class Synopsis < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :synopsis, :string
  end
end

