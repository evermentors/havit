# encoding: UTF-8
require 'rails_helper'
require 'byebug'

describe "User logs in", :type => :feature do
  before :each do
    #create admin user
    if User.find_by_email('evermentors@gmail.com').blank?
      ActiveRecord::Base.skip_callbacks = true
      havit_admin = User.create name: '에버멘토', email: 'evermentors@gmail.com', password: 'test4321', last_used_character: 1
      ActiveRecord::Base.skip_callbacks = false
    else
      havit_admin = User.find_by_email('evermentors@gmail.com')
    end

    #create universe group
    Group.disable_search_callbacks
    universe = FactoryGirl.create(:group, creator: havit_admin.id)
    Group.enable_search_callbacks

    #crate two users
    @user1 = FactoryGirl.create(:user, name: "kucho1", email: "jku856-1@gmail.com")
    @user2 = FactoryGirl.create(:user, name: "kucho2", email: "jku856-2@gmail.com")
    Group.disable_search_callbacks
    @group1 = FactoryGirl.create(:group, name: "Evermentors", creator: @user1.id, description: "This is evermentors group", password: "test4321", member_limit: 10)
    @group1.characters.create user_id: @user1.id, order: (@user1.characters.count + 1), is_admin: true
    Group.enable_search_callbacks
  end

  it "logs in and join group successfully", js: true do
    login_user(@user1)
    fill_in_goals_and_submit(@user1)

    page.find('.navbar-group-select.will-collapse > div.dropdown-toggle').click
    page.find('.navbar-group-select.will-collapse .group-name', :text => 'Evermentors').click

    fill_in_goals_and_submit(@user1)
    expect(page).to have_css(".metainfo")
  end
end
