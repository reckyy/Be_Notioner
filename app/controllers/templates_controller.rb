class TemplatesController < ApplicationController
  skip_before_action :require_login

  def index
    @templates = Template.all.includes(:user).order(created_at: :desc)
  end
end
