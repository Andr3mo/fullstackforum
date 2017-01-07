class PostsController < ApplicationController
	# calls the method find_post before the show, edit, update and destroy methods
	# DRY Principle
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	
	# Creates the index method
	def index
	end

	# Shows the post
	def show	
	end

	# Creates the new post view
	def new
		@post = Post.new
	end

	# Creates the new post
	def create
		# Gets the parameters for the new post
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	# Creates the edit view
	def edit
	end

	# Updates the post
	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	# Deletes the post
	def destroy
		@post.destroy
		redirect_to root_path
	end

	# Methods bellow are private
	private

	# Finds a specific post
	def find_post
		@post = Post.find(params[:id])
	end

	# Gets the title and content of the post (DRY Principle)
	def post_params
		params.require(:post).permit(:title, :content)
	end
end
