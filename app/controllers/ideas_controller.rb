class IdeasController < ApplicationController
	def create
		@idea = Idea.new(idea_params)
		@idea.owner_id = current_user.id

		if @idea.save
			@idea.build_ideatags

			flash[:success] = "Created Idea successfully."
			redirect_to @idea
		else
			flash[:warning] = "Please make sure to provide Title, Location, and Description."
			# render ideas_path	
			render "pages/home"
			# respond_to do |format|
			  # if @idea.save
			  # 	format.js { render "shared/valid" }
			  # else
		      # format.html { render "pages/home" }
		      # format.js
		    # end
	    # end
		end
	end

	def show
		@idea = Idea.find(params[:id])  # Hmmm?
		@update = Update.new()
		upd_id = params[:update_id] 
		upd_id ||= @idea.updates.first

		if upd_id.nil?
			@update_to_show = nil
		else
			@update_to_show = Update.find(upd_id)
		end
		respond_to do |format|
			format.html {}
			format.js {}
		end
		# redirect_to @idea
	end

	private

	def idea_params
		params.require(:idea).permit(:title, :location, :description, :tags_tmp, :collaborators_tmp)
	end


end
