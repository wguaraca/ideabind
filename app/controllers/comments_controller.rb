class CommentsController < ApplicationController

	def index
		# debugger
	end

	def expand 
		respond_to do |format|
			@comment = Comment.find(params[:comment])
			format.js {}
		end
	end

	def fold 
		respond_to do |format|
			@comment = Comment.find(params[:comment])
			format.js {}
		end
	end

	def create

		@comment = Comment.new(comments_params)
		
		@idea = Idea.find(params[:idea_id])
		@update = Update.find(params[:update_id])

		@comment.user_id = current_user.id
		@comment.idea_id = @idea.id
		@comment.update_id = @update.id
		@update_to_show = @update
		# debugger

		respond_to do |format|
			if @comment.save
				flash[:success] = "Comment was added."
				@update.comments << @comment
				@update.save
				# debugger

				format.html { redirect_to @idea }
				format.js {}
			else
				flash[:warning] = "Comment failed to save."
				
				format.html { redirect_to @idea }
				format.js {}
			end
		end
	end

	private

	def comments_params
		params.require(:comment).permit(:content)
	end
end
