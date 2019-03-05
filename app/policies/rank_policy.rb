class RankPolicy < ApplicationPolicy
  def update?
    policy(record.rankable).update?
  end
end