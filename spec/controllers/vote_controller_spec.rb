require 'spec_helper'

describe VoteController, :type => :controller do

  describe "创建投票记录(new)" do
    it "应该分配一个新投票记录的实例" do
      get :new, :round => 1, :user_id => 1
      vote = Vote.new(:round => 1)
      expect(assigns(:vote).round).to eq vote.round
    end
    it "应该渲染'创建投票记录'页面" do
      get :new, :round => 1, :user_id => 1
      expect(response).to render_template :new
    end
    it "应该持有所有候选人参数" do
      get :new, :round => 1, :user_id => 1
      candidates = User.all
      expect(assigns(:candidates)).to eq candidates
    end
    it "如果参数round未提供，应该回到用户首页" do
      get :new, :user_id => 1
      expect(response).to redirect_to user_home_path(assigns[:user_id])
    end
    it "如果参数user_id未提供，应该回到用户参与页面" do
      get :new
      expect(response).to redirect_to user_enroll_path
    end
  end

  describe "提交投票成功(create)" do
    context '带有完整的参数' do
      context '如果该用户在该轮还未投票' do
        it "应该在投票记录中新增一条数据" do
          expect { 
            post :create, vote: attributes_for(:vote)
           }.to change(Vote, :count).by(1)
        end
        it "应该跳转至'投票成功'页面" do
          post :create, vote: attributes_for(:vote)
          expect(response).to redirect_to vote_path(assigns[:vote])
        end
      end
      context '如果该用户在该轮已经投票' do
        it "不应该更新数据库" do
          @vote = create(:vote)
          expect { 
            post :create, vote: attributes_for(:modify_vote)
           }.to_not change(Vote, :count)

        end
        it "应该跳转至'投票成功'页面（提示已经投票）" do
          @vote = create(:vote)
          post :create, vote: attributes_for(:modify_vote)
          expect(response).to redirect_to vote_path(assigns[:vote])
        end
        # it "应该在投票记录中更新原来的记录" do
        #   @vote = create(:vote)
        #   patch :update, id: @vote, :vote => attributes_for(:modify_vote)
        #   @vote.reload
        #   expect(@vote.candidate_id).to '2'
        # end
        # it "应该跳转至'投票成功'页面" do
          
        # end
      end
    end

    context '缺少完整的参数' do
      it "应该不修改数据库" do
        expect { 
          post :create, vote: attributes_for(:invalid_vote)
         }.to_not change(Vote, :count)
      end
      it "重绘创建投票界面" do
        post :create, vote: attributes_for(:invalid_vote)
        expect(response).to render_template :new
      end
    end
  end

  describe "投票成功(show)" do
    it "应该持有投票记录" do
      vote = create(:vote)
      get :show, :id => vote
      expect(assigns(:vote)).to eq vote
    end
    it "应该渲染'投票成功'页面" do
      vote = create(:vote)
      get :show, :id => vote
      expect(response).to render_template :show
    end
    it "应该持有下一轮链接地址" do
      vote = create(:vote)
      get :show, :id => vote
      user_id = assigns(:vote).user_id
      round = assigns(:vote).round + 1
      expect(assigns(:next_round_vote_path)).to eq vote_new_path(:user_id => user_id, :round => round)
    end
  end

  describe "投票结果(result)" do
    it "应该持有top10数据(查看某班某轮全部投票结果)" do
      get :results, :class_name => 'A'
      top10_candidates = []
      8.times do |index|
        top10_candidates << Vote.select("candidate_id").where(:class_name => assigns[:class_name], :round => index + 1).group('candidate_id').count
      end
      expect(assigns(:top10_candidates)).to eq top10_candidates
    end
  end
end
