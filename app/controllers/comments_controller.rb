class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = @post.id
    @comment.comment_id = params[:parent_id] ? params[:parent_id] : @comment.id
    @comment.reply_depth = params[:reply_depth]
    @comment.user_name = current_user.name
    @comment.save()
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
    
  def voteup
    vote(1)
  end
   
  def votedown
    vote(-1)
  end

  def vote(i)
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.find_or_create_by(user: current_user)
    if !@vote.points || i * @vote.points < 0
      @vote.points = i * current_user.vote_weight || 1
      @vote.save()
    end
    
    @comment.vote_points = @comment.votes.all.inject(0){|sum, c| sum += c.points} 
    @comment.save
    respond_to do |format|
      format.html { redirect_to @comment.post }
      format.js
    end
  end
    
  private
    def comment_params
      params.require(:comment).permit(:text, :post_id)
    end
end
