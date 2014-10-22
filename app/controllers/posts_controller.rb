class PostsController < ApplicationController
	before_filter :find_postable
	load_and_authorize_resource 

	def new
		@postable = find_postable
		@post = @postable.posts.new(user: current_user)
	end

	def create
		@postable = find_postable
		@post = @postable.posts.build(params[:post])
		@post.user = current_user

		if @post.save
			flash[:success] = "#{@post.title} was sucessfully created!"
			redirect_to	@postable #id: nil		#redirects back to the current index action
		else
			flash[:danger] = "#{@post.title} failed to be created. Please try again later"
			render action: 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def index
		@postable = find_postable
		@posts = @postable.posts
	end

	def edit
		@postable = find_postable
		@post = Post.find(params[:id])
	end

	def update
		@postable = find_postable
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			redirect_to @postable
			flash[:success] = "Post was updated!"
		else
			render action: :edit
		end
	end

	def destroy
		@postable = find_postable
		@post = Post.find(params[:id])
		if @post.destroy()
			flash[:sucess] = "Post #{@post.title} was sucessfully destroyed!"
		else
			flash[:danger] = "Post failed to be destroyed. Please try again later."
		end

		if @postable == "Department"
			redirect_to department_path #change later
		elsif @postable == "Course"
			redirect_to department_course_path
		else
			redirect_to departments_path
		end
	end

	private
		def post_params
			params.require(:post).permit(:title, :description, :content)
		end

		def find_postable	#gets the type of post to create
			params.each do |name, value|
				if name =~ /(.+)_id$/
					return $1.classify.constantize.find(value)
				end
			end
			nil
		end

end
