class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      t.string :title
      t.string :author
      t.string :isbn_number
      t.text :description
      t.float :price
      t.integer :user_id

      t.timestamps
    end
  end
end
