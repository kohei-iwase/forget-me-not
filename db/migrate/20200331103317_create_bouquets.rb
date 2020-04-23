class CreateBouquets < ActiveRecord::Migration[5.2]
  def change
    create_table :bouquets do |t|
    	t.integer	:user_id
    	t.integer	:portrait_id

      t.timestamps
    end

    add_index :bouquets, :user_id
    add_index :bouquets, :portrait_id
  end
end
