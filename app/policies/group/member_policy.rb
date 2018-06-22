class Group::MemberPolicy < ApplicationPolicy
  def create?
    admin_user?
  end

  def update?
    with_user do
      user.admin?
    end
  end

  def destroy?
    admin_user?
  end
end
