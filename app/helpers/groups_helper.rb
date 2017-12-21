module GroupsHelper
  def current_member
    @current_member ||=
      current_user.members.find { |member| member.group.id == @group.id } if user_signed_in?
  end
end
