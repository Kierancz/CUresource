class DepartmentsController < ApplicationController
	load_and_authorize_resource
	#Blocks these methods before a user is authenticated.
	before_action :authenticate_user!, only: [:create, :destroy, :new, :edit, :update]
	before_action :find_department

	def new
		@department = Department.new
	end

	def create
		@department = Department.create(department_params)

		if @department.save
			redirect_to @department
			flash[:success] = "The #{@department.title} department was created!"
		else 
			render 'new'
		end 
	end

	def index
		@departments = Department.all
		@department = Department.new

		@courses = Course.all
	end

	def show
		@postable = @department
		@posts = @department.posts

		@course = Course.new
		@course.department_id = @department
	end

	def edit
	end

	def update
		if @department.update_attributes(department_params)
			redirect_to @department
			flash[:success] = "#{@department.title} department was successfully updated!"
		else
			render action: 'edit'
		end
	end

	def destroy
		if @department.destroy()
			flash[:success] = "The #{@department.title} department was destroyed!"
		else
			flash[:danger] = "#{@department.title} failed to be destroyed. Please try again later."
		end
		redirect_to action: "index"
	end

	private
		def find_department
			@department = Department.find(params[:id]) unless params[:id].blank?
		end

		def department_params
			params.require(:department).permit(:subject, :title, :description, :banner, :info, :college, :type)
		end

end
