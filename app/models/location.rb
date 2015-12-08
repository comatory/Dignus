class Location < ActiveRecord::Base
  validates :place_name, presence: true
  has_many :users
  has_many :events
  reverse_geocoded_by :latitude, :longitude

  def self.check_location(params)
    existing_location = self.find_by(place_id: params[:place_id])

    if existing_location
      existing_location.id
    else
      location = self.create(place_id: params[:place_id], latitude: params[:place_lat], longitude: params[:place_lng],
                 place_name: params[:place_name], place_address: params[:place_address], place_website: params[:place_website],
                place_url: params[:place_url] )
      location.id
    end
  end

  def events_nearby(radius, now)
    nearby_events = nearby_resources(radius, :events).map do |event|
      if now
        if event.start_time >= DateTime.now
          event
        end
      else
        if event.end_time < DateTime.now
          event
        end
      end
    end
    nearby_events.compact
  end

  def users_nearby(radius)
    nearby_resources(radius, :users)
  end

  def nearby_resources(radius, resource)
    resources = Location.near(self, radius).map do |location|
      location.send(resource)
    end
    resources.compact.flatten
  end
end
