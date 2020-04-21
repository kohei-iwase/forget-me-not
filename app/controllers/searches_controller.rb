class SearchesController < ApplicationController
	def search
		@user = User.new
		@portrait = Portrait.new
		@anniversaries = current_user.anniversaries.page(params[:page])
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@how = params["search"]["how"]
		@datas = search_for(@how, @model, @content)
	end


	private
		#部分一致以外も作ったが、わりと不便なので使わない予定
	# def match(model, content)
	# 	if model == 'user'
	# 		User.where(name: content)
	# 	elsif model == 'product'
	# 		Product.where(name: content)
	# 	else model == 'memory'
	# 		Memoly.where(title: content)
	# 	end
	# end

	# def forward(model, content)
	# 	if model == 'user'
	# 		User.where("name like ?", "#{content}%")
	# 	elsif model == 'product'
	# 		Product.where("name like ?", "#{content}%")
	# 	else model == 'memory'
	# 		Memory.where("title like ?", "#{content}%")
	# 	end
	# end

	# def backward(model, content)
	# 	if model == 'user'
	# 		User.where("name like ?", "%#{content}")
	# 	elsif model == 'product'
	# 		Product.where("name like ?", "%#{content}")
	# 	else model == 'memory'
	# 		Memory.where("title like ?", "%#{content}")
	# 	end
	# end

	def partical(model, content)
		if model == 'user'
			User.where("name like ?", "%#{content}%")
		elsif model == 'portrait_name'
			Portrait.where("name like ?", "%#{content}%")
		elsif model == 'portrait_species'
			Portrait.where("species like ?", "%#{content}%")
		else model == 'memory'
			Memory.where("title like ?", "%#{content}%")
		end
	end

	def search_for(how, model, content)
	  case how
		# when 'match'
		# 	match(model, content)
		# when 'forward'
		# 	forward(model, content)
		# when 'backward'
		# 	backward(model, content)
		when 'partical'
			partical(model, content)
	  end
	end
end
