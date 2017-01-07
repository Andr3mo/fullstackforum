class PostsController < ApplicationController
	# calls the method find_post before the show, edit, update and destroy methods
	# DRY Principle
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	# Uses a method from Devise to force the user to login before any action other than view index and show pages
	before_action :authenticate_user!, except: [:index, :show]
	
	# Creates the index method
	def index
		@posts = Post.all.order("created_at DESC")
	end

	# Shows the post
	def show	
	end

	# Creates the new post view
	def new
		@post = current_user.posts.build
	end

	# Creates the new post
	def create
		# Gets the parameters for the new post
		@post = current_user.posts.build(post_params)

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
