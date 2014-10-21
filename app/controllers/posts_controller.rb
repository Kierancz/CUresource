class PostsController < ApplicationController
	before_filter :find_postable
	load_and_authorize_resource 

	def new
		@postable = find_postable
		@post = @postable.posts.new
	end

	def create
		@postable = find_postable
		@post = @postable.posts.build(params[:post])

		if @post.save
			flash[:success] = "#{@post.title} was sucessfully created!"
			redirect_to	department_path #id: nil		#redirects back to the current index action
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

		def find_postable	#gets the type of post to create
			params.each do |name, value|
				if name =~ /(.+)_id$/
					return $1.classify.constantize.find(value)
				end
			end
			nil
		end

end
