class CreateEventCampDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :event_camp_details, id: :uuid do |t|
      #
      t.timestamps
    end
  end
end
