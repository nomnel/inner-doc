class SessionsController < ApplicationController
  def new
    redirect_to articles_path if logged_in?
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      redirect_back_or_to root_path, notice: t('signed_in_successfully')
    else
      flash.now.alert = t('invalid_email_or_password')
      render :new
    end
  end

  def destroy
    redirect_to signin_path unless logged_in?
    logout
    redirect_to root_path, notice: t('signed_out_successfully')
  end
end
