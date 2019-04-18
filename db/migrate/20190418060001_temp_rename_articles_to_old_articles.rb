class TempRenameArticlesToOldArticles < ActiveRecord::Migration[5.2]
  def change
    rename_table :articles, :old_articles
  end
end
