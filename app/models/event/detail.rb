class Event::Detail < ApplicationRecord
  self.abstract_class = true

  has_one :event,
          class_name: 'Event',
          foreign_key: :detail_id
end
