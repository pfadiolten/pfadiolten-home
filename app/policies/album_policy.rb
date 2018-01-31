class AlbumPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def download?
    show?
  end
end
