class Old::Event::CampDetail < Old::Event::Detail
  self.table_name = 'old_event_camp_details'

  def handle
    :camp
  end
end
