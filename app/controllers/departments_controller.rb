class DepartmentsController < ApplicationController
	load_and_authorize_resource
	#Blocks these methods before a user is authenticated.
	before_action :authenticate_user!, only: [:create, :destroy, :new, :edit, :update]
	before_action :find_department

	include SmartListing::Helper::ControllerExtensions
	helper  SmartListing::Helper

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
		@department = Department.new

		q = params[:q]
		@departments = Department.search(title_cont: q).result
		@courses = Course.search(title_cont: q).result
		@posts = Post.search(title_cont: q).result

		#@alldepartments = smart_listing_create(:departments, Department.all, partial: "departments/sortdep", default_sort: {title: "asc"})
		@alldepartments = Department.alph

		@allcourses = Course.recent.limit(10)
	end

	def show
		@postable = @department
		@posts = @department.posts
		@pinned_posts = @department.posts.where(pin: true)

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

	def pin
		@department = Department.find(params[:department_id])
		@department.pin = true
		@department.save!
		redirect_to @department
		flash[:success] = "#{@department.title} was pinned! "
	end

	def deletepin
		@department = Department.find(params[:department_id])
		@department.pin = false
		@department.save!
		redirect_to @department
		flash[:success] = "#{@department.title} was unpinned! "
	end


	private
		def find_department
			@department = Department.find(params[:id]) unless params[:id].blank?
		end

		def department_params
			params.require(:department).permit(:subject, :title, :description, :banner, :info, :college, :type, :pin)
		end

end
