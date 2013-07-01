class AddMsgCountToBookDetails < ActiveRecord::Migration
  def change
    add_column :book_details, :msg_count, :integer, :default => 0
  end
end
