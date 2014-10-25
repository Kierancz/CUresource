class UsersController < ApplicationController
	load_and_authorize_resource 

	def show
		@user = User.find(params[:id])

		#sets user roles based on entered role key
		if @user.rolekey == ENV["INSTRUCTOR_ROLE"]
			@user.instructor
		end
		if @user.rolekey == ENV["ADMIN_ROLE"]
			@user.admin
		end
	end

	def index
		@users = User.all
	end
end
