class PostsController < ApplicationController
  before_filter :is_authenticated
  skip_before_filter :is_authenticated, :only => [:index]
  
  def index
      @posts = Post.all
  end
  
  def show
      @post = Post.find(params[:id])
      @comments = @post.comments.all.order("thread")
  end

  def new
      @post = Post.new
  end
 
  def edit
      @post = Post.find(params[:id])
  end
  
  def create
      @post = current_user.posts.build(post_params)
      @post.user_name = current_user.name
      if @post.save
          redirect_to @post
      else
          render 'new'
      end
  end

  def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
          redirect_to @post
      else
          render 'edit'
      end
  end

  def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path
  end

  def voteup
    vote(1)
  end
 
  def votedown
    vote(-1)
  end

  def vote(i)
    @post = Post.find(params[:id])
    @vote = @post.votes.find_or_create_by(user: current_user)
    if !@vote.points || i * @vote.points < 0
      @vote.points = i * current_user.vote_weight || 1
      @vote.save()
    end

    @post.vote_points = @post.votes.all.inject(0){|sum, c| sum += c.points}
    @post.save()

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
  
  private
      def post_params
          params.require(:post).permit(:text)
      end
end
