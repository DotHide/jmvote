class VoteController < ApplicationController
  def new
  	redirect_to user_enroll_path if params[:user_id].nil?
  	@user_id = params[:user_id]
  	redirect_to user_home_path(params[:user_id]) if params[:round].nil? && !params[:user_id].nil?
  	@round = params[:round]
  	@vote = Vote.new
  	@vote.round = params[:round]
  	@candidates = User.all
  	@class_name = User.find(@user_id).class_name if User.count > 0
  end

  def create
    if Vote.where(:user_id => vote_params[:user_id], :round => vote_params[:round]).count == 0
      @vote = Vote.new(vote_params)
      if @vote.save
        redirect_to vote_path(@vote)
      else
        render :new
      end
    else
      @vote = Vote.find_by(:round => vote_params[:round], :user_id => vote_params[:user_id])
      redirect_to vote_path(@vote)
    end
  end

  def update
  	if @vote.update(vote_params)
  		redirect_to vote_path(@vote)
  	else
  		render :new
  	end
  end

  def show
  	@vote = Vote.find(params[:id])
  end

  private
  	def vote_params
  		params.require(:vote).permit(:user_id, :round, :candidate_id, :class_name)
  	end
end
