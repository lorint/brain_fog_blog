class PhotosController < ApplicationController
	def new
		@post = Post.where(id: params[:post_id]).first
		@photo = @post.photos.new
	end

	def create
		post = Post.where(id: params[:post_id]).first
		photo = post.photos.create(params.require(:photo).permit(:caption, :image))
		if photo.save
			redirect_to posts_path
		end
	end
end
