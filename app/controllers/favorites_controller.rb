class FavoritesController < ApplicationController
	#before_action :set_course
	before_action :set_model

	#def create
	#	if Favorite.create(favoritable: @course, user: current_user)
	#		redirect_to @course, notice: 'Course has been favorited'
	#	else
	#		redirect_to @course, alert: 'Something went wrong... check back later'
	#	end
	#end

	def create
		if Favorite.create(favoritable: @model, user: current_user)
			redirect_to :back, notice: " #{@model.title} has been favorited!"
		else
			redirect_to :back, alert: 'Something went wrong... check back later'
		end
	end

	#def destroy
	#	Favorite.where(favoritable_id: @course.id, user_id: current_user.id).first.destroy
	#	redirect_to @course, notice: 'Course is no longer in favorites'
	#end

	def destroy
		Favorite.where(favoritable_id: @model.id, user_id: current_user.id).first.destroy
		redirect_to :back, notice: "#{@model.title} is no longer in favorites."
	end

	private

	#def set_course
	#	@course = Course.find(params[:course_id] || params[:id])
	#nd

	def set_model
		params.each do |name, value|
			if name =~ /(.+)_id$/
				@model = $1.classify.constantize.find(value)
			end
		end
		nil
	end

end
