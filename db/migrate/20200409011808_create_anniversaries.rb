class CreateAnniversaries < ActiveRecord::Migration[5.2]
  def change
    create_table :anniversaries do |t|
		t.date	 	:date
		t.string 	:title
		t.text	 	:memo
    	t.integer	:portrait_id
      	t.timestamps
    end
  end
end
