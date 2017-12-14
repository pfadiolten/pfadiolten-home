class EventGroup < ApplicationRecord
# Relations
  belongs_to :event,
             class_name: 'Event',
             foreign_key: :event_id,
             required: true

  belongs_to :group,
             class_name: 'Group',
             foreign_key: :group_id,
             required: true

# Validations
  validates :event_id,
            uniqueness: { scope: %i[ group_id ] }
end
