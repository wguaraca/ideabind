class CommentsController < ApplicationController

	def index
		debugger
	end

	def create
		debugger
		@comment = Comment.new(comments_params)
		
		@idea = Idea.find(params[:idea_id])
		@update = Update.find(params[:update_id])

		@comment.user_id = current_user.id
		@comment.idea_id = @idea.id
		@comment.update_id = @update.id
		debugger
		
		if @comment.save
			flash[:success] = "Comment was added."
			@update.comments << @comment
			@update.save
			debugger

			redirect_to @idea
		else
			flash[:warning] = "Comment failed to save."
			redirect_to @idea
		end
	end

	private

	def comments_params
		params.require(:comment).permit(:content)
	end
end
