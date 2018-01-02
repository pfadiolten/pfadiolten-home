module EventsHelper

  def icons
    @icons ||= {
      camp:     'map-signs',
      activity: 'rocket',
    }
  end

end
