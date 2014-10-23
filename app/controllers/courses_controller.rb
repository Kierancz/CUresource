class CoursesController < ApplicationController
	load_and_authorize_resource

	def new
		@course = Course.new
	end

	def create
		@department = Department.find(params[:department_id])
		@course = @department.courses.create(course_params)
		if @course.save
			redirect_to @course
			flash[:success] = "Course: #{@course.title} was successfully created!"
		else 
			render 'new'
		end 
	end

	def index
		@courses = Course.all
		@newcourse = Course.new
	end

	def show
		@course = Course.find(params[:id])
		@postable = @course
		@posts = @course.posts

		@department = Department.find(@course.department_id)
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		if @course.update_attributes(course_params)
			redirect_to @course
			flash[:success] = "Course was updated!"
		else
			render action: 'edit'
		end
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.destroy()
			flash[:success] = "Course #{@course} was successfully destroyed!"
		else
			flash[:danger] = "Course failed to be destroyed. Please try again later."
		end
		redirect_to action: 'index'
	end

	private
		def course_params
			params.require(:course).permit(:department_name, :number, :title, :description, :banner, :info)
		end

end

