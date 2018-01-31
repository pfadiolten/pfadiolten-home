class Event::Detail < ApplicationRecord
  self.abstract_class = true

# Relations
  has_one :event,
          class_name: 'Event',
          foreign_key: :detail_id

# Actions
  def handle
    raise 'abstract method'
  end
end
