class Location < ActiveRecord::Base
  validates :place_name, presence: true
  has_many :users
  has_many :events
  reverse_geocoded_by :latitude, :longitude

  def self.check_location(params)
    params_location = params[:location] || params[:venue]
    if params[:place_id].empty?
      loc_name = self.custom_location_name(params_location)

      if loc_name.kind_of?(Array)
        pl_name = loc_name[0]
        pl_address = loc_name[1]
      else
        pl_name, pl_address = loc_name, loc_name
      end

      location = self.find_by(place_name: pl_name, place_address: pl_address) 
      location ? location : location = self.create(place_name: pl_name, place_address: pl_address)
    else
      location = self.find_by(place_id: params[:place_id])

      if location.nil?
        location = self.create(place_id: params[:place_id], latitude: params[:place_lat], longitude: params[:place_lng],
                   place_name: params[:place_name], place_address: params[:place_address], place_website: params[:place_website],
                  place_url: params[:place_url] )
      end
    end

    location.id
  end

  def self.custom_location_name(location)
    if location.include?(',')
      loc_name = location.split(',')
      [loc_name[0], loc_name[1..-1].join(', ')]
    else
      location
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
    nearby_resources(radius, :users) - [User.find_by(location_id: self.id)]
  end

  def nearby_resources(radius, resource)
    resources = Location.near(self, radius).map do |location|
      location.send(resource)
    end
    resources.compact.flatten
  end
end
