class Search < ActiveRecord::Base

  def self.search(query)
    event_results = Event.fuzzy_search({venue: query, description: query, name: query}, false)
    self.set_fuzzy_search(0.1)
    names = Content.where(content_type: 1).fuzzy_search({content: query}, false) 
    self.set_fuzzy_search(0.1)
    descriptions = Content.where(content_type: 2).fuzzy_search({content: query}, false) 
    self.set_fuzzy_search(0.1)
    by_location = User.fuzzy_search({location: query}, false)

    user_results = self.get_user_objects(names + descriptions)
    collection = (event_results + user_results + by_location).flatten.uniq

    @results = generate_search_data(collection)
  end

  def self.get_user_objects(search_data)
    users = search_data.map do |index|
      User.where(id: index.user_id )
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
