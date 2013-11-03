class SessionsController < ApplicationController
  def new
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
    logout
    redirect_to root_path, notice: t('signed_out_successfully')
  end
end
