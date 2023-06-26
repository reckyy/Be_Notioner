class BookmarksController < ApplicationController
  before_action :require_login
  before_action :set_bookmarkable

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmark = current_user.bookmark(@bookmarkable)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def destroy
    @bookmarkable_type = @bookmarkable.class.to_s
    current_user.unbookmark(@bookmarkable)
    respond_to do |format|
      format.js { render :destroy }
    end
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