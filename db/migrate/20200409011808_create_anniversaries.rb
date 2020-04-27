class CreateAnniversaries < ActiveRecord::Migration[5.2]
  def change
    create_table :anniversaries do |t|
		t.date	 	:date
		t.string 	:title
		t.text	 	:memo
    t.integer	:portrait_id
    t.integer	:user_id
      	t.timestamps
    end

        add_index :anniversaries, :title
        add_index :anniversaries, :portrait_id
        add_index :anniversaries, :user_id
  end
end
