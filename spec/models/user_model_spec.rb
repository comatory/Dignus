require "rails_helper"

RSpec.describe User, :type => :model do

  before :each do
    @organizer = create(:user, confirmed_at: Time.now)
    @organizer.id = 100
    @organizer.organizer = true
    @organizer.performer = false 
    @organizer.contents.create(role: 0, content_type: 1, content: "Jack")
    @organizer.contents.create(role: 0, content_type: 2, content: "Hello world")
    @performer = create(:user, email: "whatever@whatever.com", confirmed_at: Time.now)
    @performer.organizer = false
    @performer.performer = true
    @performer.id = 101

  end

  context "every user" do

    it "has a role" do
      expect(@organizer.role).to eq(0)
      expect(@organizer.role_name).to eq("Organizer")
    end

    it "has a name" do
      expect(@organizer.name).to eq("Jack")
    end

    it "can change name" do
      @organizer.set_name("John")
      expect(@organizer.name).to eq("John")
    end
    
    it "has a description" do
      expect(@organizer.description).to eq("Hello world")
    end

    it "can change description" do
      @organizer.set_description("Goodbye")
      expect(@organizer.description).to eq("Goodbye")
    end

  end

  context "every organizer" do

    it "has performer invitations" do
      invitation = create(:invitation)
      invitation.accepted = true
      @organizer.invitations.create(user_id: @organizer.id, accepted: true, to: @performer.id, event_id: 1, responded: false)
      expect(@organizer.performer_invitations.count).to eq(1)
    end

  end

  context "every performer" do

    before :each do
      @present_event = create(:event, user_id: @organizer.id)
      @present_event.id = 1
      @past_event = create(:event, id: 2, user_id: @organizer.id)
      
      @present_event.start_time = DateTime.now + 2
      @present_event.end_time = DateTime.now + 3

      @past_event.start_time = DateTime.now - 5
      @past_event.end_time = DateTime.now - 4

      create(:invitation, user_id: @performer.id, to: @organizer.id, event_id: @past_event.id, accepted: true, id: 1 )
      create(:invitation, user_id: @performer.id, to: @organizer.id, event_id: @present_event.id, accepted: true, id: 2)
    end

    it "can have own invitations" do
      expect(@performer.invitations.count).to eq(2)
    end

    it "has scheduled performances" do
      expect(@performer.scheduled_performances.count).to eq(1)
    end

    xit "has past performances" do
      expect(@performer.past_performances.count).to eq(1)
    end

  end

end


