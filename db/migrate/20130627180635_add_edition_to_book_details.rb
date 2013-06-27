class AddEditionToBookDetails < ActiveRecord::Migration
  def change
    add_column :book_details, :edition, :string
    add_column :book_details, :condition, :integer
  end
end
