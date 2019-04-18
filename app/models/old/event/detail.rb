class Old::Event::Detail < ApplicationRecord
  self.abstract_class = true

# Relations
  has_one :old_event,
          class_name: 'Old::Event',
          foreign_key: :detail_id

# Actions
  def handle
    raise 'abstract method'
  end

  def handles
    handle.to_s.pluralize.to_sym
  end
end
