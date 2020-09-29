class RemovePinFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :is_pinned, :boolean
    remove_column :articles, :pinned_till, :date
  end
end
