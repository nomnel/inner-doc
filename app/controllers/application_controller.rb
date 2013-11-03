class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    def not_authenticated
      redirect_to signin_path, alert: t("please_sign_in_first")
    end
end
