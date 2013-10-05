class CommentsController < ApplicationController

	def create
		comment = Comment.new(comments_params)
		comment.user_id = current_user.id
		@idea = Idea.find(params[:idea_id])
		@update = Update.find(params[:update_id])

		if @comment.save
			flash[:success] = "Comment was added."
			@update.comments << @comment
			@update.save
			debugger

			render @idea
		else
			flash[:warning] = "Comment failed to save."
			render @idea
		end
	end

	private

	def comments_params
		params.require(:comments).permit(:content)
	end
end
