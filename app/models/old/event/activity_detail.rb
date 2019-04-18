class Old::Event::ActivityDetail < Old::Event::Detail
  self.table_name = 'old_event_activity_details'

  def handle
    :activity
  end
end
