class CommentsController < ApplicationController
	load_and_authorize_resource
	before_filter :find_commentable

	def new
		@comment = @commentable.comments.new(user: current_user)
	end

	def create
		@comment = @commentable.comments.build(params[:comment])
		@comment.user = current_user

		if @comment.save
			redirect_to	request.referer + '#posts'
			flash[:success] = "Your comment was sucessfully created!"
		else
			redirect_to request.referer + '#posts'
			flash[:danger] = "Comment failed to be created. Please try again later.."
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:comment, :user_id, :commentable_id, :commentable_type)
		end

		def find_commentable	#gets the type of comment to create
			params.each do |name, value|
				if name =~ /(.+)_id$/
					@commentable = $1.classify.constantize.find(value)
				end
			end
			nil
		end

end
