module LoginSupport
  def login(user)
    visit root_path
    click_link "Login"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Login"
  end
end