class GoogleLoginApiController < ApplicationController
  require "googleauth/id_tokens/errors"
  require 'googleauth/id_tokens/verifier'

  skip_before_action :require_login

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    if params[:credential].present?
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV['DATA_CLIENT_ID'])
      user = User.find_or_initialize_by(email: payload['email'])

      if user.save
        auto_login(user)
        redirect_to root_path, success: (t '.success')
      else
        redirect_to login_path, warning: (t '.fail')
      end

    else
      redirect_to login_path, warning: (t '.fail')
    end

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      redirect_to root_path, warning: (t '.fail')
    end
  end
end
