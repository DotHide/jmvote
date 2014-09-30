class UserController < ApplicationController
  def enroll
    if params[:half].nil?
      @user = User.new
      @signin = params[:signin]
    else
      half = params[:half]
      # 判断cookies是否存在
      if !cookies[:mobile].nil?
        @user = User.find_by_mobile(cookies[:mobile])
        redirect_to user_home_path(@user, :half => half)
      else
        @user = User.new
      end
    end
  end

  def do_enroll
    # 判断手机号用户是否已存在（不存在则注册，存在则登录）
    user_taken = User.find_by_mobile(user_params[:mobile])
    if !user_taken.nil?
      # 登录
      @user = user_taken
      cookies[:mobile] = user_params[:mobile]
      # 判断是否是签到动作
      if params[:signin] == "1"
        redirect_to user_signin_path(@user)
      else
        # 判断姓名或者班级是否变更
        if @user.name != user_params[:name] || @user.class_name != user_params[:class_name]
          if @user.update(user_params)
            redirect_to user_home_path(@user)
          else
            render :enroll
          end
        else
          redirect_to user_home_path(@user)
        end
      end
    else
      # 注册
      @user = User.new(user_params)
      if @user.save
        redirect_to user_signin_path(@user)
      else
        render :enroll
      end
    end
  end

  def home
    @user = User.find(params[:id])
    if params[:half] == "1"
      @rounds = [{id: 1, title: "儿科-青春偶像"}, {id: 2, title: "儿科-青春偶像"}, {id: 3, title: "五大-青春偶像"}, {id: 4, title: "五大-青春偶像"}]
    elsif params[:half] == "2"
      @rounds = [{id: 5, title: "儿科-青春偶像"}, {id: 6, title: "儿科-青春偶像"}, {id: 7, title: "五大-青春偶像"}, {id: 8, title: "五大-青春偶像"}]
    else
      @rounds = [{id: 0, title: "投票测试"}]
    end
  end

  def signin
    @user = User.find(params[:id])
  end

  def lottery
    @user = User.all
  end

  private 
    def user_params
      params.require(:user).permit(:name, :mobile, :class_name)
    end
end
