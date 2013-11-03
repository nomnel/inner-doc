class UsersController < ApplicationController
  def new
    redirect_to articles_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    pw = @user.password
    if @user.save
      login(@user.email, pw)
      redirect_to articles_url, notice: t('registered_successfully')
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :password_confirmation
      )
    end
end
