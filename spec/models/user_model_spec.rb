require "rails_helper"
require "helpers/user_helper"

RSpec.describe User, :type => :model do
  include UserHelper 

  before :each do
    @organizer = create(:user)
    @organizer.id = 100
    @organizer.organizer = true
    @organizer.performer = false 
    @organizer.contents.create(role: 0, content_type: 1, content: "Jack")
    @organizer.contents.create(role: 0, content_type: 2, content: "Hello world")
    @performer = create(:user, email: "whatever@whatever.com")
    @performer.organizer = false
    @performer.performer = true
    @performer.id = 101

    @organizer.contents.create(role: 0, content_type: 4, 
                               content: "www.youtube.com/video1")
    @organizer.contents.create(role: 0, content_type: 5, 
                               content: "www.organizer.com")
    @performer.contents.create(role: 1, content_type: 4, 
                               content: "www.youtube.com/video2")
    @performer.contents.create(role: 1, content_type: 5, 
                               content: "www.performer.com")
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

    it "generates user data hash for view" do
      e1 = create(:event, user_id: @organizer.id)
      i1 = create(:invitation, to: @performer.id, user_id: @organizer.id, event_id: e1.id, accepted: true)


      allow(DateTime).to receive(:now).and_return(forward_time_days(10))
      e2 = create(:event, user_id: @organizer.id, start_time: DateTime.now + 2, end_time: DateTime.now + 4)
      i2 = create(:invitation, to: @performer.id, user_id: @organizer.id, event_id: e2.id, accepted: true)

      organizer_hash = @organizer.generate_user_data()
      expect(organizer_hash).to be_kind_of(Hash)
      expect(organizer_hash[:performances][:past].count).to eq(0)
      expect(organizer_hash[:performances][:scheduled].count).to eq(0)
      expect(organizer_hash[:events][:past].count).to eq(1)
      expect(organizer_hash[:events][:scheduled].count).to eq(1)
      expect(organizer_hash[:website]).to eq('www.organizer.com')
      expect(organizer_hash[:youtube]).to eq('www.youtube.com/video1')
      expect(organizer_hash[:audio]).to be_empty
      expect(organizer_hash[:rating]).to be_zero

      performer_hash = @performer.generate_user_data()
      expect(performer_hash).to be_kind_of(Hash)
      expect(performer_hash[:performances][:past].count).to eq(1)
      expect(performer_hash[:performances][:scheduled].count).to eq(1)
      expect(performer_hash[:events][:past].count).to eq(0)
      expect(performer_hash[:events][:scheduled].count).to eq(0)
      expect(performer_hash[:website]).to eq('www.performer.com')
      expect(performer_hash[:youtube]).to eq('www.youtube.com/video2')
      expect(performer_hash[:audio]).to be_empty
      expect(performer_hash[:rating]).to be_zero
    end

    it "has a rating expressed in integer" do
      create(:review, user_id: @organizer.id, to: @performer.id, rating: 3)
      create(:review, user_id: 10, to: @performer.id, rating: 4)
      create(:review, user_id: 11, to: @performer.id, rating: 5)
      create(:review, user_id: 12, to: @performer.id, rating: 2)
      expect(@performer.rating).to eq(3)
    end

    it "has a rating of 0 without any reviews" do
      expect(@performer.rating).to be_zero
    end

    it "generates content hash for edit content view" do
      content_hash = @performer.generate_content_data
      expect(content_hash).to be_kind_of(Hash)
      expect(content_hash.has_key?(:website)).to be true
      expect(content_hash.has_key?(:youtube)).to be true
      expect(content_hash.has_key?(:audio)).to be true
      expect(content_hash[:website].content).to eq('www.performer.com')
      expect(content_hash[:youtube].content).to eq('www.youtube.com/video2')
      expect(content_hash[:audio].count).to eq(0)
    end

  end

  context "every organizer" do

    before :each do
      create(:event, user_id: @organizer.id)
      create(:event, user_id: @organizer.id)
    end

    it "can have scheduled events" do
      expect(@organizer.scheduled_events.count).to eq(2)
    end

    it "can have past events" do
      allow(DateTime).to receive(:now).and_return(forward_time_days(10))
      expect(@organizer.past_events.count).to eq(2)
      expect(@organizer.scheduled_events.count).to eq(0)
    end

  end

  context "every performer" do

    before :each do
      e1 = create(:event, user_id: @organizer.id)
      e2 = create(:event, user_id: @organizer.id)

      create(:invitation, user_id: @performer.id, to: @organizer.id, 
             event_id: e1.id, accepted: true, id: 1 )
      create(:invitation, user_id: @performer.id, to: @organizer.id, 
             event_id: e2.id, accepted: true, id: 2)
    end

    it "can have own invitations" do
      expect(@performer.invitations.count).to eq(2)
    end

    it "has scheduled performances" do
      expect(@performer.scheduled_performances.count).to eq(2)
    end

    it "has past performances" do
      allow(DateTime).to receive(:now).and_return(forward_time_days(10))
      expect(@performer.past_performances.count).to eq(2)
      expect(@performer.scheduled_performances.count).to eq(0)
    end

    it "has events not invited to by organizer" do
      e1 = create(:event, user_id: @organizer.id)
      e2 = create(:event, user_id: @organizer.id)
      e3 = create(:event, user_id: @organizer.id)
      e4 = create(:event, user_id: @organizer.id)

      create(:invitation, user_id: @performer.id, to: @organizer.id, 
             event_id: e1.id, accepted: false, responded: true)
      create(:invitation, user_id: @organizer.id, to: @performer.id, 
             event_id: e2.id, accepted: true, responded: false)
      create(:invitation, user_id: @organizer.id, to: @performer.id, 
             event_id: e3.id, accepted: false, responded: true)
      create(:invitation, user_id: @performer.id, to: @organizer.id, 
             event_id: e4.id, accepted: true, responded: true)

      events_not_invited_to = @organizer.events_not_invited_to(@performer)
      expect(events_not_invited_to.count).to eq(2)
      expect(events_not_invited_to).to include(e1, e3)
      expect(events_not_invited_to[0]).to be_an_instance_of(Event)
    end

  end


end


