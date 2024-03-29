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

      it 'メールアドレスがない状態では更新できないこと' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        fill_in 'メールアドレス', with: ''
        click_on '更新'
        expect(page).to have_content '更新に失敗しました'
      end

      it '自己紹介を埋めて更新に成功すること' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        fill_in '自己紹介', with: 'よろしくお願いします！'
        click_on '更新'
        expect(page).to have_content '更新に成功しました'
      end

      it '自己紹介を埋めなくても更新に成功すること' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        fill_in '自己紹介', with: ''
        click_on '更新'
        expect(page).to have_content '更新に成功しました'
      end
    end

    context '画像の更新' do
      it '画像の更新に成功' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        attach_file'user[avatar]', "#{Rails.root}/spec/fixtures/images/user_image.jpg"
        click_on '更新'
        expect(page).to have_content '更新に成功しました'
        expect(page).to have_selector("img[src$='user_image.jpg']")
        expect(page).to have_current_path profile_path, ignore_query: true
      end

      it '画像を更新した後、次は画像を選択しなくてもそのまま最初の画像が表示されていること' do
        login(user)
        click_link 'プロフィール'
        click_link '編集'
        attach_file'user[avatar]', "#{Rails.root}/spec/fixtures/images/user_image.jpg"
        click_on '更新'
        click_link '編集'
        click_on '更新'
        expect(page).to have_content '更新に成功しました'
        expect(page).to have_selector("img[src$='user_image.jpg']")
        expect(page).to have_current_path profile_path, ignore_query: true
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
