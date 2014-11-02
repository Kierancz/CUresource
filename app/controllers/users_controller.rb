class UsersController < ApplicationController
	load_and_authorize_resource 

	def new
		@user = User.new
	end

	def create
		@user =User.new(params[:user])
	end

	def show
		@user = User.find(params[:id])
		@user.role = params[:role]
		#sets user roles based on entered role key
	end

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			sign_in(@user, bypass: true) if @user == current_user
			redirect_to @user, flash[:success] = 'User was successfully updated.'
		else
			render action: 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path, flash[:sucess] = 'User was successfully deleted.'
	end
end
