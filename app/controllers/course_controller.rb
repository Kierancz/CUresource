class CourseController < ApplicationController
	load_and_authorize_resource

	def new
		@course = course.new
	end

	def create
		@course = courses.create(course_params)
		if @course.save
			redirect_to @course
			flash[:success] = "Course: #{@course.title} was successfully created!"
		else 
			render 'new'
		end 
	end

	def index
		@courses = course.all
	end

	def show
		id = params[:id]
		@course = course.find(id)
	end

	def edit
		id = params[:id]
		@course = course.find(id)
	end

	def update
		@course = course.find(params[:id])
		if @course.update_attributes(course_params)
			redirect_to @course
			flash[:success] = "Course was successfully updated!"
		else
			render :action => 'edit'
		end
	end

	def destroy
		@course = course.find(params[:id])
		if @course.destroy()
			flash[:success] = "Course #{@course} was successfully destroyed!"
		else
			flash[:danger] = "Course failed to be destroyed. Please try again later."
		end
		redirect_to action: "index"
	end

	private
		def course_params
			params.require(:course).permit(:title, :description)
		end

end

