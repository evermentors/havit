module Helpers
  def login_user(user)
    visit "/"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    page.find('.btn.submit-btn.btn-block.btn-havit-inverted').click
    expect(current_path).to eq "/"
    expect(page).to have_css("span > button > span")
  end
end
