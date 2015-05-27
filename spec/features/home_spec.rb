# encoding: UTF-8
require 'rails_helper'

describe "User logs in", :type => :feature do
  before :each do
    ActiveRecord::Base.skip_callbacks = true
    # FactoryGirl.create(:admin)
    ActiveRecord::Base.skip_callbacks = false
    FactoryGirl.create(:group)
    # FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
    FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")
  end

  # it "then universe group is selected" do
  #   visit "/"
  #   ActiveRecord::Base.skip_callbacks = false
  #   universe = FactoryGirl.create(:group)

  #   user1 = FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
  #   user2 = FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")
  #   user_group = FactoryGirl.create(:user_group)
  #   user_group.characters.create user_id: user1.id, order: 1, is_admin: false
  #   user_group.characters.create user_id: user2.id, order: 1, is_admin: false
  # end
  
  it "logs in then universe group is selected", js: :true do
    # FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")

    User.create(name: "kucho", email: "jku856@gmail.com", password: "ever8253")
    
    # locale = I18n.locale
    # visit root_path(locale)
    visit '/'
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_css("div > #flash_alert")

    # save_screenshot('1_before_email.png')
    fill_in "user_email", with: "jku856@gmail.com"
    # save_screenshot('2_before_password.png')
    fill_in "user_password", with: "ever8253"
    # save_screenshot('3_after_password.png')
    click_button "로그인"

    save_screenshot('4_result.png')
    expect(current_path).to eq "/"
  end
end
