module Helpers
  def login_user(user)
    visit "/"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    page.find('.btn.submit-btn.btn-block.btn-havit-inverted').click
    expect(current_path).to eq "/"
    expect(page).to have_css("span > button > span")
  end

  def fill_in_goals_and_submit(user)
    fill_in "monthly_goal_description", with: "#{user.name}'s monthly goal description"
    fill_in "weekly_goal_description", with: "#{user.name}'s weekly goal description"
    fill_in "daily_goal_description", with: "#{user.name}'s daily goal description"
    page.find('.btn.btn-primary.btn-sm.submit-btn').click
  end
end
