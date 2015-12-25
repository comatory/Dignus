module EventsHelper
  def event_not_locked?(event)
    event.start_time > DateTime.now
  end

  def event_start_time_min
    start_time = DateTime.now + (4.0 / 24)
    momentjs_formatted(start_time)
  end

  def event_end_time_min
    end_time = DateTime.now + (8.0 / 24)
    momentjs_formatted(end_time)
  end

  def momentjs_formatted(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
end
