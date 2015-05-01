require 'rails_helper'

RSpec.describe DevisesController, type: :controller do
  include Devise::TestHelpers  
  describe "GET #sign_up" do
    it "signup responds successfully" do
      get :new
      expect(response).to_be_success
    end
  end
end
