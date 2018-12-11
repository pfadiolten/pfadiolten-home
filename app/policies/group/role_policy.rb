class Group::RolePolicy < ApplicationPolicy
  def index?
    create?
  end

  def show?
    create?
  end

  def create?
    with_user do
      user.admin?
    end
  end
end
