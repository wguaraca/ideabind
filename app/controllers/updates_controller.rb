class UpdatesController < ApplicationController

	def create
		debugger
		@update = Update.new(update_params)
		@update.idea_id = params[:idea_id]
		@update.user_id = current_user.id
		if @update.save
			flash[:success] = "Successfully created update."
			redirect_to @update.idea
		else
			flash[:warning] = "Please make sure to fill out both title and description."
			idea = Idea.find(params[:idea_id])
			redirect_to idea
		end
	end

	def show
		debugger
		@idea = Idea.find(params[:idea_id])
		@update_to_show = Update.find(params[:update_id])
		redirect_to @idea
	end

	private

	def update_params
		params.require(:update).permit(:title, :description, :idea_id)
	end

end
