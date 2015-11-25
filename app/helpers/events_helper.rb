module EventsHelper
  def event_not_locked?(event)
    event.start_time > DateTime.now
  end
end
