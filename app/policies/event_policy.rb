class EventPolicy < ApplicationPolicy
  def show?
    user.present? || !record.private?
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