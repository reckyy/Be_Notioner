class ProfilesController < ApplicationController
  before_action :set_user,only: %i[edit update show destroy]

  def edit; end

  def update
    if @user.update(user_params)
      @user.avatar.attach(params[:user][:avatar]) if @user.avatar.blank? #ユーザーが画像選択しなかった場合、sampleに戻ってしまうため。
      redirect_to profile_path, success: (t '.profile_update_success')
    else
      flash.now[:danger] = (t '.profile_update_failed')
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @user.destroy!
    redirect_to root_path, status: :see_other, info: (t '.user_deleted')
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email,:name, :introduction, :avater,:avater_cache)
  end
end
