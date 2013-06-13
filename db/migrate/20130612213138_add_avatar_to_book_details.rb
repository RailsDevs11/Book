class AddAvatarToBookDetails < ActiveRecord::Migration
  def change
    add_column :book_details, :avatar, :string
  end
end
