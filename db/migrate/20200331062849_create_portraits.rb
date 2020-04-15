class CreatePortraits < ActiveRecord::Migration[5.2]
  def change
    create_table :portraits do |t|

    	t.integer	:user_id
    	t.string	:image_id
    	t.string 	:name        ,null: false, default: ""
    	t.string 	:gender
    	t.integer	:age
    	t.string	:species
    	t.date	    :birthday
    	t.date	    :anniversary
    	t.string	:likes_and_dislikes
    	t.string	:interest
    	t.string	:specialty
    	t.string	:family
    	t.string	:personality
    	t.string	:found
    	t.text		:more_about_me

      t.timestamps
    end
  end
end
