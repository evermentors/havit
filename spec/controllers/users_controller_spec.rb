require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @user = User.new name: 'kucho', password: "ever8253", email: 'jku856@gmail.com'
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
