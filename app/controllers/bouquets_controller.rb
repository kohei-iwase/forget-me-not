class BouquetsController < ApplicationController
	def create
	portrait = Portrait.find(params[:portrait_id])
        bouquet = current_user.bouquets.new(portrait_id: portrait.id)
        bouquet.save
        # redirect_to portrait_path(portrait)
        # portrait.create_notification_bouquet!(current_user)
	end

	def destroy
	portrait = Portrait.find(params[:portrait_id])
        bouquet = current_user.bouquets.find_by(portrait_id: portrait.id)
        bouquet.destroy
        # redirect_to portrait_path(portrait)
	end
end
