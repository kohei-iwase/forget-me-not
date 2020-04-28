class AnniversariesController < ApplicationController
	def index
		@user = current_user
		@anniversaries = @user.anniversaries.page(params[:page]).per(10)
	end

	def edit
		@user = current_user
		@portrait = Portrait.find(params[:portrait_id])
		if @portrait.anniversary.nil?
			@anniversary = Anniversary.new
		else
			@anniversary = @portrait.anniversary
		end
	end

	def create
    	@portrait = Portrait.find(params[:portrait_id])
    	@anniversary = Anniversary.new(anniversary_params)
	    @anniversary.portrait_id = @portrait.id
	    @user = current_user
	    @anniversary.user_id = @user.id
    	if @anniversary.save
    		flash[:success] = "供養日を設定しました"
    		redirect_to portrait_anniversaries_path(@portrait)
    	else
    		flash[:danger] = "供養日設定に失敗しました"
    		render :edit
    	end
    end

	def update
    	@portrait = Portrait.find(params[:portrait_id])
    	@anniversary = Anniversary.find(params[:id])
	    @anniversary.portrait_id = @portrait.id
	    @anniversary.user_id = current_user.id
    	if @anniversary.update
    		 flash[:success] = "供養日を設定しました"
    		redirect_to portrait_anniversaries_path(@portrait)
    	else
    		 flash[:danger] = "供養日設定に失敗しました"
    		render :edit
    	end
    end

    def destroy
        @portrait = Portrait.find(params[:portrait_id])
        @anniversary = Anniversary.find(params[:id])
        if @anniversary.destroy
        flash[:success] = "供養日を設定しました"
        redirect_to portrait_anniversaries_path(@portrait)
        end
    end


    def reminder #一周忌にuserにメールを送る(未実装)
    	if one_anniversary.exist?
    	@one_anniversary = one_anniversary
    	@user = @one_anniversary.user
    	NotificationMailer.remind_to_user(@user).deliver
    end
    end

    private
		def anniversary_params
    		params.require(:anniversary).permit(:title, :memo, :portrait_id, :user_id,:date)
		end

		def one_anniversary #通知用の一周忌の前日を定義
			Anniversary.where("DATE(date) ='#{Date.yesterday.since(1.years)}'")
			#Anniversary.date.yesterday<= date.since(1.years) && date.since(1.years) < Anniversary.date.today
  		end

end