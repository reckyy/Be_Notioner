class BookmarksController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @bookmarks = @user.bookmarks
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_back fallback_location: root_path, success: (t '.success')
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_back fallback_location: root_path, status: :see_other, success: (t '.success')
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_type, :bookmarkable_id)
  end
end