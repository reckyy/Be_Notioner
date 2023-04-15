require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user){ create(:user) }


  describe 'プロフィールのリンク関連の処理' do

    context 'プロフィールの更新' do
      it '名前がない状態では更新できないこと' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        fill_in '名前', with: ''
        click_on '更新'
        expect(page).to have_content '更新に失敗しました'
      end

      it '名前がない状態では更新できないこと' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        fill_in 'メールアドレス', with: ''
        click_on '更新'
        expect(page).to have_content '更新に失敗しました'
      end
    end

  
    context '退会処理'do
      it '退会するを押すとconfirmが表示されて退会処理が成功する' do
        login(user)
        click_link '退会する'
        expect{
          expect(page.accept_confirm).to eq '本当に退会しますか？'
          expect(page).to have_content '退会しました'
        }
      end
    end

  end
end
