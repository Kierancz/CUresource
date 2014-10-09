class PostsController < ApplicationController
	before_filter :load_postable
	load_and_authorize_resource

	def new
		@post = @postable.posts.new
	end

	def create
		@post = @postable.posts.create(post_params)
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			redirect_to @post
			flash[:success] = "Post was updated!"
		else
			render action: :edit
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy()
			flash[:sucess] = "Post #{@post} was sucessfully destroyed!"
		else
			flash[:danger] = "Post failed to be destroyed. Please try again later."
		end
		redirect_to departments_path #change later
	end

	private
		def post_params
			params.require(:post).permit(:title, :description, :content)
		end

		def load_postable	#gets the type of post to create (department post or course post)
			@type = params[:postable_type].capitalize.constantize
			@postable = @type.find(parms[:postable_id])
		end
end
