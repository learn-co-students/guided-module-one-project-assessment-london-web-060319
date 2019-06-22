class ChangeColumnNameReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :message, :content
  end
end
