require "rails_helper"
require "helpers/user_helper"

RSpec.describe Event, :type => :model do
  include UserHelper

  context "Every event" do

    it "must have name, start_time, end_time, location" do
      start_time = '3000-01-01 00:00:00'
      end_time = '3000-01-02 15:45:00'
      event = create(:event, name: 'New event',
                     start_time: DateTime.parse(start_time),
                     end_time: DateTime.parse(end_time),
                    location_id: 1)
      expect(event).to be_valid
      expect(event.start_time.month).to eq(1)
      expect(event.end_time.year).to eq(3000)
      expect(event.location_id).to eq(1)
      expect(event.name).to eq('New event')

      invalid_event = build(:event, start_time: nil)
      expect(invalid_event).to be_invalid
      expect(invalid_event.save).to be false
    end

    it "can have performers" do
      e1 = create(:event)
      e2 = create(:event)
      p1 = create(:user, performer: true)
      p2 = create(:user, performer: true, email: Faker::Internet.email)
      p3 = create(:user, performer: true, email: Faker::Internet.email)
      create(:invitation, event_id: e1.id, to: p1.id)
      create(:invitation, event_id: e1.id, to: p2.id)
      create(:invitation, event_id: e2.id, to: p3.id)
      expect(e1.performers).to be_kind_of(Hash)
      expect(e2.performers).to be_kind_of(Hash)
      expect(e1.performers.keys.count).to eq(2)
      expect(e2.performers.keys.count).to eq(1)
    end
  end

  context "Events" do

    it ".events_participated will list user's events" do
      u = create(:user, performer: true)
      e1 = create(:event)
      e2 = create(:event)
      create(:invitation, event_id: e1.id, to: u.id)
      create(:invitation, event_id: e2.id, to: u.id)
      allow(DateTime).to receive(:now).and_return(forward_time_days(10))
      # this is present event and should not be included
      e3 = create(:event, end_time: DateTime.now + 10)
      create(:invitation, event_id: e3.id, to: u.id)
      expect(Event.events_participated(u).count).to eq(2)
    end

  end
end
