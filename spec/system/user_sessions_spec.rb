require 'rails_helper'

RSpec.describe "UserSessions", type: :system do


  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力が正常' do
      it 'ログイン成功' do
        login(user)
        expect(page).to have_content 'ログインに成功しました'
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end

    context 'メールアドレスが未入力' do
      it 'ログイン失敗' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト成功' do
        login(user)
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトに成功しました'
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end
  end
end
