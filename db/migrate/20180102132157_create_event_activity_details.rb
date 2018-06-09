class CreateEventActivityDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :event_activity_details, id: :uuid do |t|
      #
      t.timestamps
    end
  end
end
