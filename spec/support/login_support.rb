module LoginSupport
  def login(user)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: 'testiaoaaoon'
    click_on "ログイン"
  end
end