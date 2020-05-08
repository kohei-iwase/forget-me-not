class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
    	t.integer :visiter_id, null: false
        t.integer :visited_id, null: false
    	t.integer :portrait_id
    	t.integer :memory_id
        t.integer :bouquet_id
        t.integer :flower_id
    	t.string  :action, default: '', null: false
    	t.boolean :checked, default: false, null: false
    	t.timestamps
    	end
  end
end
