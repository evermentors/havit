module MyHelper
  def login_user(user1)
    visit "/"
    fill_in "user_email", with: user1.email
    fill_in "password", with: user1.password
    click_button "Sign in"
    expect(current_path).to eq "/"
    expect(page).to have_css("span > button > span")    
  end
end

RSpec.configure do |config|
  config.include MyHelper, :type => :request
end
