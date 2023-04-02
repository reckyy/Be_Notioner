RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome
#selenium_chrome_headlessにするとブラウザを開かないヘッドレスドライバにできる
  end
end