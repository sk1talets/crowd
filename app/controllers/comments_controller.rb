class CommentsController < ApplicationController
  include CommentsHelper
  before_filter :is_authenticated

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @post = Post.find(comment_params[:post_id])
    parent_id = comment_params[:parent_id].to_i
    parent = parent_id > 0 ? Comment.find(parent_id) : nil 
    
    @comment.parent_id = parent_id
    @comment.thread = (parent ? parent.thread + '/' : '') + int_to_alphadecimal(@comment.id)
    @comment.reply_depth = parent ? parent.reply_depth + 1 : 0
    @comment.post_id = @post.id
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
      params.require(:comment).require(:text)
      params.require(:comment).require(:post_id)
      params.require(:comment).require(:parent_id)
      params.require(:comment).permit!
    end
end
