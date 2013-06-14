class AddColumnToImageLink < ActiveRecord::Migration
  def change
    add_column :book_details, :image_link, :string
  end
end
