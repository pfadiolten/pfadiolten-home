class RecreateUploadedImages < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |user|
      next unless user.avatar?

      user.avatar.recreate_versions!
      user.save!
    end

    Album::Image.all.each do |image|
      image.file.recreate_versions!
      image.save!
    end

    Article.all.each do |article|
      next unless article.image?

      article.image.recreate_versions!
      article.save!
    end
  end
end
