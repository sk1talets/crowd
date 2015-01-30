class VotesController < ApplicationController
  before_filter :is_authenticated
  
  def show
    @vote = Vote.find(params[:id])
  end
  
  def update
    @vote = current_user.votes.where(:object_id => params[:item_id], :object_type => vote_params[:item_type]).first_or_create(object_id: params[:item_id], )
    if !@vote.points || @vote.points * params[:value].to_i < 0
      @vote.points = vote_params[:points].to_i
    end
    respond_to do |format|
      format.html { redirect_to @vote }
      format.js
    end
  end
end
