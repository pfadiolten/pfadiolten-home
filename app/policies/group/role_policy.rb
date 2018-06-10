class Group::RolePolicy < ApplicationPolicy
  def index?
    with_user do
      user.admin?
    end
  end

  def show?
    super && with_user do
      user.admin?
    end
  end

  def create?
    with_user do
      user.admin?
    end
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
