class UserController < ApplicationController
  def enroll
  	@user = User.new
    @signin = params[:signin]
  end

  def do_enroll
    # 判断手机号用户是否已存在（不存在则注册，存在则登录）
    user_taken = User.find_by_mobile(user_params[:mobile])
    if !user_taken.nil?
      # 登录
      @user = user_taken
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
  end

  def signin
    @user = User.find(params[:id])
  end

  private 
    def user_params
      params.require(:user).permit(:name, :mobile, :class_name)
    end
end
