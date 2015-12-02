require "rails_helper"

RSpec.describe UsersController, type: 'controller' do

  describe "anonymous user" do

    before :each do
      # This simulates an anonymous user
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
      login_with nil
    end

    it "should be redirected to sign in at /users/:id/edit " do
      get :edit, id: 3
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should see performers at /performers" do
      get :index_performers
      expect(response).to be_success
    end

    it "should see user profile at /users/:id" do
      user = create(:user)
      @user_data = {}
      get :show, id: user.id 
      expect(response).to be_success
    end

  end

  describe "signed in user" do

    before :each do
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
      @user = create(:user)
      login_with @user 
    end

    it "should be able to edit at /users/:id/edit" do
      @user.id = 10
      get :edit, id: @user.id 
      expect(response).to be_success
    end

  end

end
