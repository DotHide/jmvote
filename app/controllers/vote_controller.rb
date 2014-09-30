class VoteController < ApplicationController
  def new
  	redirect_to user_enroll_path if params[:user_id].nil?
  	@user_id = params[:user_id]
  	redirect_to user_home_path(params[:user_id]) if params[:round].nil? && !params[:user_id].nil?
  	@round = params[:round]
    @round_title = get_title_by_round(params[:round])
  	@vote = Vote.new
  	@vote.round = params[:round]
  	# @candidates = User.all
    @class_no = get_class_no_by_round(params[:round])
    @candidates = Candidate.where(:class_name => @class_no)
  	@class_name = get_class_name_by_round(params[:round])
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
    if params[:half] == "1"
      @half = "上半场"
    elsif params[:half] == "2"
      @half = "下半场"
    else
      @half = "测试轮"
    end
    @top10_candidates_all_rounds = []
    @vote_titles = []
    if params[:half] == "0"
      top10_candidates_vote_count = []
      top10_candidates_name = []
      round = 0;
      sql_hash = Vote.select("candidate_id").where(:class_name => get_class_no_by_round(round.to_s), :round => round).group('candidate_id').order('count_candidate_id').limit(10).count
      sql_hash.each_pair  do |key, value|
          top10_candidates_vote_count << value
          top10_candidates_name << Candidate.find(key).name
          top10_candidates_all_round = {:count => top10_candidates_vote_count, :name => top10_candidates_name}
          vote_title = "#{get_class_name_by_round(round.to_s)} 丨 第 #{round} 轮 - #{get_title_by_round(round.to_s)}"
          @top10_candidates_all_rounds << { top10: top10_candidates_all_round, title: vote_title }
      end
    else
      4.times do |index|
        top10_candidates_vote_count = []
        top10_candidates_name = []
        round = params[:half] == "2" ? (index + 5) : (index + 1);
        sql_hash = Vote.select("candidate_id").where(:class_name => get_class_no_by_round(round.to_s), :round => round).group('candidate_id').order('count_candidate_id').limit(10).count
        
        # 如果得出的结果不足10人，则在图标上显示"-"，以用于站位
        # if sql_hash.count < 10
        #   delta = 10 - sql_hash.count
        #   delta.times do |index|
        #     # sql_hash["-#{index}"] = "-"
        #   end
        # end
        sql_hash.each_pair do |key, value|
          top10_candidates_vote_count << value
          top10_candidates_name << Candidate.find(key).name
          top10_candidates_all_round = {:count => top10_candidates_vote_count, :name => top10_candidates_name}
          vote_title = "#{get_class_name_by_round(round.to_s)} 丨 第 #{round} 轮 - #{get_title_by_round(round.to_s)}"
          @top10_candidates_all_rounds << { top10: top10_candidates_all_round, title: vote_title }
        end
      end
    end
  end

  private
  	def vote_params
  		params.require(:vote).permit(:user_id, :round, :candidate_id, :class_name)
  	end

    def get_class_no_by_round(round)
      case round
      when "0"
        "E"
      when "1"
        "E"
      when "2"
        "E"
      when "3"
        "W"
      when "4"
        "W"
      when "5"
        "W"
      when "6"
        "W"
      when "7"
        "E"
      when "8"
        "E"
      end
    end

    def get_class_name_by_round(round)
      case round
      when "0"
        "儿科"
      when "1"
        "儿科"
      when "2"
        "儿科"
      when "3"
        "五大"
      when "4"
        "五大"
      when "5"
        "五大"
      when "6"
        "五大"
      when "7"
        "儿科"
      when "8"
        "儿科"
      end
    end

    def get_title_by_round(round)
      case round
      when "0"
        "试玩一下哦~ (^_^)"
      when "1"
        "青春偶像奖"
      when "2"
        "青春偶像奖"
      when "3"
        "青春偶像奖"
      when "4"
        "青春偶像奖"
      when "5"
        "最具风度奖"
      when "6"
        "最具风韵奖"
      when "7"
        "最具风度奖"
      when "8"
        "最具风韵奖"
      end
    end
end
