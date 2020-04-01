class BouquetsController < ApplicationController
	def create
		portrait = Portrait.find(params[:portrait_id])
        bouquet = current_user.bouquets.new(portrait_id: portrait.id)
        bouquet.save
        redirect_to portrait_path(portrait)
	end

	def destroy
		portrait = Portrait.find(params[:portrait_id])
        bouquet = current_user.bouquets.find_by(portrait_id: portrait.id)
        bouquet.destroy
        redirect_to portrait_path(portrait)
	end
end
