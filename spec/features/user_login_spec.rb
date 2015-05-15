# encoding: UTF-8

require 'rails_helper'

describe "User logs in", :type => :feature do
  before :each do
    # create admin and user
    ActiveRecord::Base.skip_callbacks = true
    FactoryGirl.create(:admin)
    ActiveRecord::Base.skip_collbacks = false
    FactoryGirl.create(:group)
    FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
    FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")
  end

  it "then universe group is selected" do
    visit "/"
    ActiveRecord::Base.skip_callbacks = false
    universe = FactoryGirl.create(:group)
    user1 = FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
    user2 = FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")

    user_group = FactoryGirl.create(:user_group)
    user_group.characters.create user_id: user1.id, order: 1, is_admin: false
    user_group.characters.create user_id: user2.id, order: 1, is_admin: false
  end

  it "logs in then universe group is selected" do
    locale = I18n.locale
    visit root_path(locale)
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_css("div > #flash_alert")

    # fill in sign in form
    fill_in "user_email", with: "jku856-1@gmail.com"
    fill_in "user_password", with: "ever8253"
    click_button "로그인"

    expect(current_path).to eq "/"
    expect(page).to have_css("span > button > span")

    # save page
    # Capybara::Screenshot.screenshot_and_save_page
  end

  it "notifications from my groups" do
    # kucho1: login
    # kucho1: create group named 'Evermentors'
      # click
    # kucho1: logout
    # kucho2: login
    # kucho2: group find and join
    # kucho2: click notification icon
    # kucho2: see if there's one notification from 'EverMentors' group

    # kucho1: login
    visit "/"
    fill_in "user_email", with: "jku856-1@gmail.com"
    fill_in "user_password", with: "ever8253"
    click_button "로그인"
    expect(current_path).to eq "/"

    #kucho1: create group named 'Evermentors'
    page.find('div.dropdown-toggle').click
    expect(page).to have_css(".group-name")
    page.find('.create-new-group>a.menuitem').click
    expect(page).to have_css(".string.required")
    fill_in "group_name", with: "Evermentors"
    fill_in "group_description", with: "This is evermentors group"
    fill_in "group_password", with: "ever8253"
    fill_in "group_member_limit", with: 10
    click_button "그룹 만들기"
    expect(page).to have_css(".panel-heading > .panel-title")
    
    #kucho1: create a post
    page.find('.navbar-group-select.will-collapse > div.dropdown-toggle').click
    Capybara::Screenshot.screenshot_and_save_page
    page.find('.navbar-group-select.will-collapse .group-name', :text => 'Evermentors').find(:xpath, '..').click

    fill_in "monthly_goal_description", with: "user1's monthly goal description"
    fill_in "weekly_goal_description", with: "user1's weekly goal description"
    fill_in "daily_goal_description", with: "user1's daily goal description"
    page.find('.btn.btn-primary.btn-sm.submit-btn').click

    fill_in "status_description", with: "kucho1 status description"
    fill_in "next_daily_goal", with: "kucho1 next daily goal"
    page.find('.status-footer > .btn.submit-btn.btn-havit-white').click

    #kucho1: logout
    page.find('.sign-out-li > .glyphicon.glyphicon-off').click
    expect(current_path).to eq "/users/sign_in"
    
    #kucho2: login
    visit "/"
    fill_in "user_email", with: "jku856-2@gmail.com"
    fill_in "user_password", with: "ever8253"
    click_button "로그인"
    expect(current_path).to eq "/"
    
    #kucho2: goals setting
    expect(page).to have_css('#weekly_goal_description')
    page.find('#monthly_goal_description').set('kucho2, monthly goal')
    page.find('#weekly_goal_description').set('kucho2, weekly goal')
    page.find('#daily_goal_description').set('kucho2, daily goal')
    click_button "등록"
    
    page.find('input.form-control.search-input').set('Evermentors')
    page.find('nav.navbar-default button.btn').click

    # kucho2: check if there's a notification
    # do it later because it requires js: true
    # expect(page).to have_css('span.notifications-count', :text => '1')
    # page.find('.glyphicon-bell').click
    # expect(page).to have_css('.noti-what')

    #kucho2: move Evermentors group
    page.find('.navbar-group-select.will-collapse > div.dropdown-toggle').click

    page.find('.navbar-group-select.will-collapse .group-name', :text => 'Evermentors').find(:xpath, '..').click

    fill_in "monthly_goal_description", with: "user2's monthly goal description"
    fill_in "weekly_goal_description", with: "user2's weekly goal description"
    fill_in "daily_goal_description", with: "user2's daily goal description"
    page.find('.btn.btn-primary.btn-sm.submit-btn').click
  end
end
