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
    user_id = @vote.user_id
    round = @vote.round + 1
    @next_round_vote_path = vote_new_path(:user_id => user_id, :round => round)
  end

  def results
    top10_candidates_all = []
    8.times do |index|
      sql_hash = Vote.select("candidate_id").where(:class_name => params[:class_name], :round => index + 1).group('candidate_id').count
      top10_candidates = []
      sql_hash.each_pair do |key, value|
        candidate_hash = {}
        candidate_hash[:value] = value
        candidate_hash[:name] = User.find(key).name
        top10_candidates << candidate_hash
      end
      top10_candidates_all << top10_candidates
    end
    @top10_candidates = top10_candidates_all
  end

  private
  	def vote_params
  		params.require(:vote).permit(:user_id, :round, :candidate_id, :class_name)
  	end
end
