class ProfilesController < ApplicationController
  before_action :set_user,only: %i[edit update show destroy]

  def edit
    redirect_to root_path unless current_user == @user
  end

  def update
    if @user.update(user_params)
      @user.avatar.attach(params[:user][:avatar]) if @user.avatar.blank? #ユーザーが画像選択しなかった場合、sampleに戻ってしまうため。
      redirect_to profile_path(@user), success: (t '.profile_update_success')
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
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :avatar, :avatar_cache)
  end
end
