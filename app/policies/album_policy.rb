class AlbumPolicy < ApplicationPolicy
  def download?
    show?
  end
end
