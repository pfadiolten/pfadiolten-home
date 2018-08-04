module EventsHelper

  def icons
    @icons ||= {
      camp:     'compass',
      activity: 'zap',
    }
  end

  def calculate_position(time)
    (100.0 / (60 * 24)) * (time.min + (time.hour * 60))
  end

end
