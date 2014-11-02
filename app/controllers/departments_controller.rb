class DepartmentsController < ApplicationController
	load_and_authorize_resource
	#Blocks these methods before a user is authenticated.
	before_action :authenticate_user!, only: [:create, :destroy, :new, :edit, :update]

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
		@newdepartment = Department.new
	end

	def show
		id = params[:id]
		@department = Department.find(id)
		@postable = @department
		@posts = @department.posts

		@course = Course.new
		@course.department_id = @department
	end

	def edit
		id = params[:id]
		@department = Department.find(id)
	end

	def update
		@department = Department.find(params[:id])
		if @department.update_attributes(department_params)
			redirect_to @department
			flash[:success] = "#{@department.title} department was successfully updated!"
		else
			render action: 'edit'
		end
	end

	def destroy
		@department = Department.find(params[:id])
		if @department.destroy()
			flash[:success] = "The #{@department.title} department was destroyed!"
		else
			flash[:danger] = "#{@department.title} failed to be destroyed. Please try again later."
		end
		redirect_to action: "index"
	end

	private
		def department_params
			params.require(:department).permit(:name, :title, :description, :banner, :info)
		end

end
