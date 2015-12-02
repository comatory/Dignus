require 'rails_helper'

RSpec.describe EventsController, type: 'controller' do

  describe "anonymous user" do

    before :each do
      # This simulates an anonymous user
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
      login_with nil
    end

    it "should see events at /events" do
      get :index_all
      expect(response).to be_success
    end

    it "should see all past events at /events/past" do
      get :index_past
      expect(response).to be_success
    end

    it "should see individual event at /events/:user_id/events/:id" do
      create(:event, user_id: 1, id: 1)
      get :show, user_id: 1, id: 1
      expect(response).to be_success
    end

    it "should be redirected when trying to create new event at /users/:user_id/events/new" do
      create(:event, user_id: 1)
      get :new, user_id: 1
      expect(response.status).to redirect_to(new_user_session_path) 
    end

    it "should be redirected when trying to edit event at /users/:user_id/events/:id/edit" do
      create(:event, user_id: 1, id: 1)
      get :edit, user_id: 1, id: 1
      expect(response.status).to redirect_to(new_user_session_path) 
    end

  end

  describe "signed in user" do

    before :each do
      request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
      @user = create(:user)
      login_with @user 
    end

    it "should be able to create new events when organizer at /users/:user_id/events/new" do
      @user.organizer = true
      @user.id = 3
      create(:event, user_id: @user.id)
      get :new, user_id: @user.id
      expect(response).to be_success
    end

    it "should not be able to create new events as a performer at /users/:user_id/events/new" do
      @user.organizer = false 
      @user.performer = true 
      @user.id = 6
      create(:event, user_id: @user.id)
      get :new, user_id: @user.id
      expect(response).to redirect_to(root_path) 
    end

    it "should be able to edit its own event at /users/:user_id/events/:id/edit" do
      @user.id = 10
      event = create(:event, user_id: @user.id, id: 1)
      get :edit, user_id: event.user_id , id: event.id 
      expect(response).to be_success
    end

    it "should not be able to edit else's events at /users/:user_id/events/:id/edit" do
      event_owner = double(:user, id: 1, organizer: true, name: "Mike")
      random_organizer = double(:user, id: 2, organizer: true, name: "Jack")
      event = create(:event, user_id: event_owner.id, id: 100)
      login_with random_organizer
      get :edit, user_id: event_owner.id, id: event.id 
      expect(response).to redirect_to(root_path)
    end

  end

end
