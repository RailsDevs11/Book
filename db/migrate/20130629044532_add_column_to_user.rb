class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :socail_img, :string
  end
end
