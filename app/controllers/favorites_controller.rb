class FavoritesController < ApplicationController
	before_action :set_model

	def create
		if Favorite.create(favoritable: @model, user: current_user)
			redirect_to	request.referer + '#posts', notice: " #{@model.title} has been favorited!"
		else
			redirect_to :back, alert: 'Something went wrong... check back later'
		end
	end

	def destroy
		Favorite.where(favoritable_id: @model.id, user_id: current_user.id).first.destroy
		redirect_to request.referer + '#posts', notice: "#{@model.title} is no longer in favorites."
	end

	private

	def set_model
		params.each do |name, value|
			if name =~ /(.+)_id$/
				@model = $1.classify.constantize.find(value)
			end
		end
		nil
	end

end
