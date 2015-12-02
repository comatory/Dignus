require "rails_helper"

RSpec.describe "Route tests", :type => :routing do

  describe "sites controller routes" do

    it "get / routes to sites#index" do
      expect(get('/')).to route_to('sites#index')
    end

  end

  describe "search controller routes" do
    it "get /search routes to search#index" do
      expect(get('/search')).to route_to('search#index')
    end

    it "post /search routes to search#create" do
      expect(post('/search')).to route_to('search#create')
    end
  end

  describe "events controller routes" do

    it "get /events routes to events#index_all" do
      expect(get('/events')).to route_to('events#index_all')
    end

    it "get /events/past routes to events#index_past" do
      expect(get('/events/past')).to route_to('events#index_past')
    end

    it "get /users/1/events/1 to events#show" do
      expect(get('/users/1/events/1')).to route_to(controller: 'events', action: 'show',
                                                  user_id: '1', id: '1')
    end

    it "patch /users/1/events/1 to events#update" do
      expect(patch('/users/1/events/1')).to route_to(controller: 'events', action: 'update',
                                                    user_id: '1', id: '1')
    end

    it "delete /users/1/events/1 to events#destroy" do
      expect(delete('/users/1/events/1')).to route_to(controller: 'events', action: 'destroy',
                                                    user_id: '1', id: '1')
    end

    it "get /users/1/events/ to events#index" do
      expect(get('/users/1/events')).to route_to(controller: 'events', action: 'index',
                                                  user_id: '1')
    end

    it "get /users/1/events/new to events#new" do
      expect(get('/users/1/events/new')).to route_to(controller: 'events', action: 'new',
                                                  user_id: '1')
    end

    it "post /users/1/events/ to events#index" do
      expect(post('/users/1/events')).to route_to(controller: 'events', action: 'create',
                                                  user_id: '1')
    end
    
    it "get /users/1/events/1/edit to events#edit" do
      expect(get('/users/1/events/1/edit')).to route_to(controller: 'events', action: 'edit',
                                                    user_id: '1', id: '1')
    end

  end

  describe "users controller routes" do

    it "get /users/1 routes to users#show" do
      expect(get('/users/1')).to route_to(controller: 'users', action: 'show', 
                                          id: '1')
    end

    it "get /users/1/edit routes to users#edit" do
      expect(get('/users/1/edit')).to route_to(controller: 'users', action: 'edit',
                                              id: '1')
    end

    it "patch /users/1 routes to users#update" do
      expect(patch('/users/1')).to route_to(controller: 'users', action: 'update',
                                         id: '1')
    end
  end

  describe "content controller routes" do

    it "get /users/1/contents to contents#edit" do
      expect(get('/users/1/contents')).to route_to(controller: 'contents', action: 'edit',
                                                  user_id: '1')
    end

    it "post /users/1/contents to contents#update" do
      expect(post('/users/1/contents')).to route_to(controller: 'contents', action: 'update',
                                                  user_id: '1')
    end

    it "delete /users/1/contents to contents#update" do
      expect(delete('/users/1/contents')).to route_to(controller: 'contents', action: 'destroy',
                                                  user_id: '1')
    end
  end

  describe "invitation controller routes" do

    it "post /invitations routes to invitations#create" do
      expect(post('/invitations')).to route_to(controller: 'invitations', action: 'create')
    end

    it "patch /invitations/1 to invitations#update" do
      expect(patch('/invitations/1')).to route_to(controller: 'invitations', action: 'update',
                                                id: '1')
    end

    it "delete /invitations/1 to invitations#destroy" do
      expect(delete('/invitations/1')).to route_to(controller: 'invitations', action: 'destroy',
                                                id: '1')
    end

  end


end
