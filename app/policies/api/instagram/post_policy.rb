class Api::Instagram::PostPolicy < ApplicationPolicy
  def recent?
    true
  end
end