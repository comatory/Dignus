class Search < ActiveRecord::Base

  def self.search(query)
    event_results = Event.fuzzy_search({description: query, name: query}, false)

    self.set_fuzzy_search(0.2)
    event_tag_results = Event.tagged_with(query.split, any: true, on: :tags)
    user_tag_results = User.tagged_with(query.split, any: true, on: :tags)
    names = Content.where(content_type: 1).fuzzy_search({content: query}, false) 

    self.set_fuzzy_search(0.2)
    descriptions = Content.where(content_type: 2).fuzzy_search({content: query}, false) 

    self.set_fuzzy_search(0.1)
    location_search_data = Location.fuzzy_search({place_name: query, place_address: query}, false)

    location_results = self.get_objects_by_location(location_search_data)
    user_results = self.get_user_objects(names + descriptions)
    collection = (event_results + event_tag_results + user_tag_results + user_results + location_results).flatten.uniq

    @results = generate_search_data(collection)
  end

  def self.get_user_objects(search_data)
    users = search_data.map do |user|
        User.where(id: user.user_id )
    end
  end

  def self.get_objects_by_location(search_data)
    results = search_data.map do |location|
      location.events.each do |event|
        return Event.where(location_id: location.id)
      end
      location.users.each do |user|
        return User.where(location_id: location.id)
      end
    end
  end

  def self.set_fuzzy_search(amount)
    ActiveRecord::Base.connection.execute("SELECT set_limit(#{amount});")
  end

  def self.generate_search_data(collection)
    search_ary = []

    collection.each do |item|
      search_data = {}

      if item.class == User
        search_data[item.name] = {
          description: item.description,
          link: Rails.application.routes.url_helpers.user_path(item.id),
        }

        if item.performer
          search_data[item.name][:role] = 'performer'
        elsif item.organizer
          search_data[item.name][:role] = 'organizer'
        end 

      elsif item.class == Event
        search_data[item.name] = {
          description: item.description,
          link: Rails.application.routes.url_helpers.user_event_path(item.user_id, item.id),
          role: 'event'
        }
      end
      search_ary << search_data
    end

    search_ary 
  end

end
