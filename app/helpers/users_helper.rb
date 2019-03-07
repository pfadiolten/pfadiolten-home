module UsersHelper
  def user_avatar_path(user, size:, &process)
    if user.stored_avatar.nil?
      image_path("fallback/avatar/x#{size}.jpg")
    else
      avatar = user.stored_avatar.process.resize_to_fill(size, size)
      avatar = process.(avatar) if block_given?
      url_for(avatar)
    end
  end
end
