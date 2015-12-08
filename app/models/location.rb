class Location < ActiveRecord::Base
  validates :place_name, presence: true
  has_many :users
  has_many :events

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
end
