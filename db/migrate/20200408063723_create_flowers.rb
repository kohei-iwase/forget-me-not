class CreateFlowers < ActiveRecord::Migration[5.2]
  def change
    create_table :flowers do |t|
    	t.integer	:user_id
    	t.integer	:memory_id
      t.timestamps
    end
  end
end
