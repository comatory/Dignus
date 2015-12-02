require "rails_helper"

RSpec.describe UsersController, type: 'controller' do
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:user)
  end

  before :each do
    request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
    @user = build(:user)
    @user.id = 1
  end

  describe "GET user show" do

    xit "assigns @user" do
      user = build(:user) 
      user.id = 1
      user_data = {'something': 'something'}
      get :show, id: user.id
      expect(assigns(:user)).to eq([user])
      expect(assigns(:user_data)).to eq([user_data])
    end
  end

  describe "GET user edit" do

    it "redirects when not signed in" do
      get :edit, id: 3
      expect(response.status).to eq(302) 
      expect(response).to redirect_to(new_user_session_path)
    end

    it "lets signed in user in" do
      binding.pry
      sign_in @user
      get :edit, {id: @user.id}
      expect(assigns(:user)).to eq([@user])
    end
  end

end
