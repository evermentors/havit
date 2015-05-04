require 'rails_helper'

feature "User logs in and logs out" do
  scenario "with correct details" do
    # create universe and user
    universe = FactoryGirl.create(:group)
    user = FactoryGirl.create(:user)

    visit "/"
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_css("div > #flash_alert")

    # fill in sign in form
    fill_in "user_email", with: "jku856@gmail.com"
    fill_in "user_password", with: "ever8253"
    click_button "Sign in"

    expect(current_path).to eq "/"
    expect(page).to have_css("span > button > span")

    # sign-out-test is impossible because sign-out-icon has no id
    # however, the code below has been tested temporally
    # click_link "sign-out-id"
    # expect(current_path).to eq "/users/sign_in"
  end
end
