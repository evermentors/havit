require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
  end
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #sign_up" do
    # user = User.create :email => "foo@example.com", :password => "password", :password_confirmation => "password"
    it "signup responds successfully" do
      get '/users/sign_up/'
      expect(response).to be_success
    end
  end
end
