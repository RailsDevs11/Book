class CreateNotifies < ActiveRecord::Migration
  def change
    create_table :notifies do |t|
      t.integer :user_id
      t.string :isbn_number
      t.datetime :end_date

      t.timestamps
    end
  end
end
