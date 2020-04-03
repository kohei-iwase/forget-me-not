class CreateWiths < ActiveRecord::Migration[5.2]
  def change
    create_table :withs do |t|
    	t.integer	:user_id
    	t.integer	:memory_id


      t.timestamps
    end
  end
end
