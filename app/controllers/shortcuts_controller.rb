class ShortcutsController < ApplicationController
  def index
    @shortcuts = Shortcut.all.order(created_at: :desc)
  end
end
