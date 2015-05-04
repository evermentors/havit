require 'rails_helper'

feature "Home page" do
  scenario "visit" do
    visit "/"
    expect(page).to have_title "Havit"
  end
end
