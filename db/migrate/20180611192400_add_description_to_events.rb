class AddDescriptionToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :description, :text, null: true
  end
end
