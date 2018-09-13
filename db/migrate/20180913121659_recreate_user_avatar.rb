class RecreateUserAvatar < ActiveRecord::Migration[5.2]
  def change
    puts "--- remove this file after deploying to production"

    User.all.each do |user|
      return unless user.avatar?

      user.avatar.recreate_versions!
      user.save!
    end
  end
end
