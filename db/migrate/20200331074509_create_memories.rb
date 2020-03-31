class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
    	t.integer	:user_id
    	t.integer	:portrait_id
    	t.string	:title
    	t.string	:when
    	t.text		:memory
    	t.string	:image_id

      t.timestamps
    end
  end
end
