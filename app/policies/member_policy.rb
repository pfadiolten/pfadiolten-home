class MemberPolicy < ApplicationPolicy
  def create?
    admin_user?
  end

  def update?
    with_user do
      user.admin? || record.role.can_edit_roles
    end
  end

  def destroy?
    admin_user?
  end
end
