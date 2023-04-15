require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user){ create(:user) }


  describe "プロフィールのリンク関連の処理" do

    
  
    context "退会処理" do
      it "退会するを押すとconfirmが表示されて退会処理が成功する" do
        login(user)
        click_link "退会する"
        expect{
          expect(page.accept_confirm).to eq "本当に退会しますか？"
          expect(page).to have_content "退会しました"
        }
      end
    end

  end
end
