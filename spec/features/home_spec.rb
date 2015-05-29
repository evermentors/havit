# encoding: UTF-8
require 'rails_helper'
require 'byebug'

describe "User logs in", :type => :feature do
  before :each do
    ActiveRecord::Base.skip_callbacks = true
    FactoryGirl.create(:admin)
    ActiveRecord::Base.skip_callbacks = false
    Group.disable_search_callbacks
    universe = FactoryGirl.create(:group)
    Group.enable_search_callbacks

    @user1 = FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
    @user2 = FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")
    Group.disable_search_callbacks
    @group1 = FactoryGirl.create(:group, name: "Evermentors", creator: @user1.id, description: "This is evermentors group", password: "ever8253", member_limit: 10)
    @group1.characters.create user_id: @user1.id, order: (@user1.characters.count + 1), is_admin: true
    Group.enable_search_callbacks
  end

  it "notifications from my groups", js: :true do
    # kucho1: login
    visit "/"
    fill_in "user_email", with: "jku856-1@gmail.com"
    fill_in "user_password", with: "ever8253"
    click_button "로그인"
    expect(current_path).to eq "/"

    fill_in "monthly_goal_description", with: "user1's monthly goal description"
    fill_in "weekly_goal_description", with: "user1's weekly goal description"
    fill_in "daily_goal_description", with: "user1's daily goal description"
    page.find('.btn.btn-primary.btn-sm.submit-btn').click

    page.find('.notification-btn > .glyphicon.glyphicon-bell').click

    page.find('.navbar-group-select.will-collapse > div.dropdown-toggle').click
    page.find('.navbar-group-select.will-collapse .group-name', :text => 'Evermentors').click

    fill_in "monthly_goal_description", with: "user1's monthly goal description"
    fill_in "weekly_goal_description", with: "user1's weekly goal description"
    fill_in "daily_goal_description", with: "user1's daily goal description"
    page.find('.btn.btn-primary.btn-sm.submit-btn').click
    save_screenshot('panel-title-screenshot.png')
    expect(page).to have_css(".metainfo")
  end
end
