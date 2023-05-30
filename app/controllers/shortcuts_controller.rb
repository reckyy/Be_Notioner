class ShortcutsController < ApplicationController
  skip_before_action :require_login
  def index
    @shortcuts = Shortcut.all.order(created_at: :desc)
  end
end
