class BookmarksController < ApplicationController
  before_action :require_login
  before_action :set_bookmarkable

  def index
    @user = User.find(params[:user_id])
    @bookmarks = @user.bookmarks
  end

  def create
    if current_user.bookmark(@bookmarkable)
      redirect_back fallback_location: root_path, success: (t '.success')
    else
      flash.now[:danger] = (t '.danger')
      redirect_back fallback_location: root_path, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.unbookmark(@bookmarkable)
    redirect_back fallback_location: root_path, status: :see_other, success: (t '.success')
  end

  private

  def set_bookmarkable
    @bookmarkable = if params[:bookmarkable_type] == 'QiitaArticle'
                      QiitaArticle.find(params[:bookmarkable_id])
                    elsif params[:bookmarkable_type] == 'ZennArticle'
                      ZennArticle.find(params[:bookmarkable_id])
                    else
                      # その他のブックマーク可能なオブジェクトを追加
                    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_type, :bookmarkable_id)
  end
end