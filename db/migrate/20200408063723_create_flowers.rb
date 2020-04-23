class CreateFlowers < ActiveRecord::Migration[5.2]
  def change
    create_table :flowers do |t|
    	t.integer	:user_id
    	t.integer	:memory_id
      t.timestamps
    end
        add_index :flowers, :user_id
        add_index :flowers, :memory_id
  end
end
