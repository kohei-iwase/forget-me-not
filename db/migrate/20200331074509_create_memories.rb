class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
    	t.integer	:portrait_id
    	t.string	:title, null: false, default: ""
    	t.string	:when
    	t.text		:memory
    	t.string	:image_id

      t.timestamps
    end
      add_index :memories, :portrait_id
      add_index :memories, :title
  end
end
