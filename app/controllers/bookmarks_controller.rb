class BookmarksController < ApplicationController
  before_action :require_login

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmarkable = find_bookmarkable
    current_user.bookmark(@bookmarkable)
    redirect_to qiita_articles_path
  end

  def destroy
    @bookmarkable = find_bookmarkable
    current_user.unbookmark(@bookmarkable)
    redirect_to qiita_articles_path
  end

  private

  def find_bookmarkable
    params[:bookmarkable_type].constantize.find(params[:bookmarkable_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_type, :bookmarkable_id)
  end
end
