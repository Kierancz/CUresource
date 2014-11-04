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
		@department = Department.find(@course.department_id)
		@postable = @course
		@posts = @course.posts
	end

	def favorite
		@course = Course.find(params[:id])
		type = params[:type]
	
		if type == "favorite"
			current_user.favorites.build(favoritable: @course)
			redirect_to :back
			flash[:success] = "#{@course.title} was added to your courses!"
		elsif type == "unfavorite"
			current_user.favorites.delete(@course)
			redirect_to :back
		else #type missing
			redirect_to :back, notice: 'Nothing happend'
		end
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

