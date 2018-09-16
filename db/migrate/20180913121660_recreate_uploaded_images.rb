class RecreateUploadedImages < ActiveRecord::Migration[5.2]
  def change
    puts "--- remove this file after deploying to production"

    User.all.each do |user|
      next unless user.avatar?

      user.avatar.recreate_versions!
      user.save!
    end

    Album::Image.all.each do |image|
      image.file.recreate_versions!
      image.save!
    end
  end
end
