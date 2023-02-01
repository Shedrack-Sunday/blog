class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes([:comments])
  end

  def show
    @user = User.find(params[:user_id])
    # @post = Post.includes(comments: [:user]).find(params[:id])
    @post = @user.posts.includes([:author]).find(params[:id])
    @comments = Comment.includes([:author]).where(post_id: params[:id]).order(created_at: :desc).limit(5)
  end

  def new
    @user = current_user
  end

  def create
    @post = current_user.posts.build(post_parameters)
    if @post.save
      redirect_to user_post_path(user_id: @post.user_id, id: @post.id)
    else
      render :new
    end
  end

  private

  def post_parameters
    params.require(:post).permit(:title, :text)
  end
end
