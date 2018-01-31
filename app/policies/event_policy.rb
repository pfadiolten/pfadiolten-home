class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    user.present? || !record.private?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.present?
        scope.all
      else
        scope.where(private?: false)
      end
    end
  end
end