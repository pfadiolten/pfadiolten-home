class GroupPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    admin_user?
  end

  def update?
    with_user do
      user.admin? || find_member_with_editing_rights.present?
    end
  end

  def edit_order?
    update_order?
  end

  def update_order?
    create?
  end

  def destroy?
    create?
  end

private
  def find_member_with_editing_rights
    user.members.find do |member|
      member.role.can_edit_group &&
        member.group.id == record.id
    end
  end
end