require 'spec_helper'

describe UserController, :type => :controller do

  describe '用户参与(enroll)' do
    it "应该分配一个新用户实例" do
      get :enroll
      expect(assigns(:user)).to be_a_new(User)
    end
    it "应该渲染'用户参与'页面" do
      get :enroll
      expect(response).to render_template(:enroll)
    end
  end

  describe '用户提交参与(do_enroll)' do
    context '缺少完整参数时' do
      before(:each) do
        @user = attributes_for(:invalid_user)
      end
      it "应该不会改变数据库" do
        expect { 
          post :do_enroll, :user => @user
         }.to_not change(User, :count)
      end
      it "应该重新渲染'用户参与'页面" do
        post :do_enroll, :user => @user
        expect(response).to render_template(:enroll)
      end
    end
    context '带完整参数时' do
      context '用户注册（首次参与时）' do
        before(:each) do
          @user = attributes_for(:user)
        end

        it "应该在用户表中新增一条数据" do
          expect { 
            post :do_enroll, :user => @user
           }.to change(User, :count).by(1)
        end

        it "应该跳转至用户首页" do
          post :do_enroll, :user => @user
          expect(response).to redirect_to user_home_path(assigns[:user])
        end
      end

      context '用户登录（非首次参与时）' do
        context '如果姓名变更时' do
          it "用户姓名字段数据应该更新" do
            @modify_user = create(:user)
            patch :do_enroll, :id => @modify_user, :user => attributes_for(:modify_user)
            @modify_user.reload
            expect(@modify_user.name).to eq('李四')
          end
        end
        context '如果班级变更时' do
          it "用户班级字段数据应该更新" do
            @modify_user = create(:user)
            patch :do_enroll, :id => @modify_user, :user => attributes_for(:modify_user)
            @modify_user.reload
            expect(@modify_user.class_name).to eq('B')
          end
        end
        context '如果用户姓名和班级均未变更时' do
          it "应该跳转至用户首页" do
            post :do_enroll, :user => attributes_for(:user)
            expect(response).to redirect_to user_home_path(assigns[:user])
          end
        end
      end
    end
  end

  describe '用户首页' do
    it "应该持有已注册或登录的用户" do
      user = create(:user)
      get :home, :id => user
      expect(assigns(:user)).to eq user
    end

    it "应该渲染'用户首页'页面" do
      user = create(:user)
      get :home, :id => user
      expect(response).to render_template :home
    end
  end

end
