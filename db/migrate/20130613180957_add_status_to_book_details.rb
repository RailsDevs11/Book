class AddStatusToBookDetails < ActiveRecord::Migration
  def change
    add_column :book_details, :status, :boolean, :default => false
  end
end
