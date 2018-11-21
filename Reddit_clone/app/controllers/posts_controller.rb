class PostsController < ApplicationController

  before_action :require_login
  def new
    @post = Post.new

    render :new
  end

  def create
    @post = Post.new(post_params)
    # @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id

    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end


  def edit
    @post = current_user.posts.find(params[:id])

    render :edit
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_url)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
