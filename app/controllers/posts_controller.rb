class PostsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_postable
	load_and_authorize_resource 

	def new
		@post = @postable.posts.new(user: current_user)
	end

	def create
		@post = @postable.posts.build(params[:post])
		@post.user = current_user

		if @post.save
			redirect_to	request.referer + '#posts'
			flash[:success] = "#{@post.title} was sucessfully created!"
		else
			redirect_to request.referer + '#createpost'
			flash[:danger] = "#{@post.title} requires a Title and Content."
		end
	end

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.build
		@comments = @post.comments.recent
	end

	def index
		@posts = @postable.posts
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			redirect_to @postable
			flash[:success] = "#{@post.title} was updated!"
		else
			render action: :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy()
			flash[:success] = "Post #{@post.title} was sucessfully destroyed!"
		else
			flash[:danger] = "Post failed to be destroyed. Please try again later."
		end
		id = @postable.id
		if @postable = "Department"
			redirect_to path_to_url(department_path(id)) + '#posts'
		else
			redirect_to path_to_url(course_path(id)) + '#posts'
		end
	end

	private
		def post_params
			params.require(:post).permit(:title, :description, :content)
		end

		def find_postable	#gets the type of post to create
			params.each do |name, value|
				if name =~ /(.+)_id$/
					@postable = $1.classify.constantize.find(value)
				end
			end
			nil
		end

		def path_to_url(path)
  	"#{request.protocol}#{request.host_with_port.gsub(/:80$/,"")}/#{path.sub(/^\//,"")}"
		end

end
