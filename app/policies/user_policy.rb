class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    admin_user? || User.count.none?
  end

  def update?
    with_user do
      user.admin? || user.id == record.id || find_member_with_editing_rights.present?
    end
  end

  def edit_image?
    update_image?
  end

  def update_image?
    update?
  end

  def edit_password?
    update_password?
  end

  def update_password?
    update?
  end

  def edit_admin?
    update_admin?
  end

  def update_admin?
    User.count == 1 || with_user do
      user.admin?
    end
  end

  def destroy?
    create? && with_user { user.id != record.id }
  end

  def destroy_image?
    update_image?
  end

  def forgot_password?
    true
  end

  def send_recover_token?
    forgot_password?
  end

private
  def find_member_with_editing_rights
    user.members.find do |member|
      member.role.can_edit_members &&
        record.groups.any? { |group| group.id == member.group.id }
    end
  end
end