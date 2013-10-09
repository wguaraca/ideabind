class IdeasController < ApplicationController
	def create
		@idea = Idea.new(idea_params)
		@idea.owner_id = current_user.id

		respond_to do |format|
			if @idea.save
				@idea.build_ideatags
				@update_to_show = nil
				flash[:success] = "Created Idea successfully."
				
				format.html { redirect_to @idea}
				format.js {}
			else
				
				format.html { render "pages/home" }
				format.js {}
		  end
		end
	end

	def show
		# debugger
		@idea = Idea.find(params[:id])  # Hmmm?
		@update = Update.new()
		upd_id = params[:update_id] 
		upd_id ||= @idea.updates.first

		respond_to do |format|
			if upd_id.nil?
				@update_to_show = nil
				format.html {}
				format.js{}
			else
				@update_to_show = Update.find(upd_id)
				format.html {}
				format.js {}
			end
			
			
			
		end
	end

	private

	def idea_params
		params.require(:idea).permit(:title, :location, :description, :tags_tmp, :collaborators_tmp)
	end


end
