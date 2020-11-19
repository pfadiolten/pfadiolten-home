class CreateHomescoutingFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :homescouting_files, id: :uuid do |t|

      t.timestamps
    end
  end
end
