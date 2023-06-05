class ChangeDriverTrue < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :driver_id, :bigint, null: true
  end
end
