class CreateNotificarions < ActiveRecord::Migration[5.2]
  def change
    create_table :notificarions do |t|
    	t.integer :user_id, null: false
    	t.integer :user_id, null: false
    	t.integer :portrait_id
    	t.integer :memory_id
    	t.string :action, default: '', null: false
    	t.boolean :checked, default: false, null: false
    	t.timestamps
    	end

    	add_index :notifications, :user_id
    	add_index :notifications, :user_id
    	add_index :notifications, :portrait_id
    	add_index :notifications, :memory_id
  end
end
