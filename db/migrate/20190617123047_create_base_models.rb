class CreateBaseModels < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
    end

    create_table :books do |t|
      t.string :title
    end
      
    create_table :reviews do |t|
        t.integer :user_id
        t.integer :book_id
        t.string :message
    end
  end
end
