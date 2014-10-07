class DepartmentsController < ApplicationController
	load_and_authorize_resource

	def new
		@department = Department.new
	end

	def create
		@department = Department.create(department_params)
		if @department.save
			redirect_to @department
			flash[:success] = "Department: #{@department.title} was successfully created!"
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
			flash[:success] = "Department was successfully updated!"
		else
			render :action => 'edit'
		end
	end

	def destroy
		@department = Department.find(params[:id])
		if @department.destroy()
			flash[:success] = "Department #{@department} was successfully destroyed!"
		else
			flash[:danger] = "Department failed to be destroyed. Please try again later."
		end
		redirect_to action: "index"
	end

	private
		def department_params
			params.require(:department).permit(:name, :title, :description, :banner, :info)
		end

end
