class OldEventGroup < ApplicationRecord
# Relations
  belongs_to :old_event,
             class_name: 'OldEvent',
             foreign_key: :old_event_id,
             required: true

  belongs_to :group,
             class_name: 'Group',
             foreign_key: :group_id,
             required: true

# Validations
  validates :old_event_id,
            uniqueness: { scope: %i[ group_id ] }
end
