class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render plain: "404 Not Found", status: :not_found
  end
  include SessionsHelper

  private

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    return if logged_in?

    redirect_to login_url
  end
end
