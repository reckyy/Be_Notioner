class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  private

  def not_authenticated
    flash.now[:danger] = (t 'defaults.require_login')
    redirect_to login_path
  end
end
