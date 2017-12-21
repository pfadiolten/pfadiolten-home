class RolePolicy < ApplicationPolicy
  def index?
    with_user do
      user.admin? || can_edit_every_role?
    end
  end

  def show?
    super && with_user do
      user.admin? || find_member_with_editing_rights
    end
  end

  def create?
    with_user do
      user.admin? || find_member_with_editing_rights.present?
    end
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

private
  def find_member_with_editing_rights
    user.members.find do |member|
      member.role.can_edit_roles &&
        member.group.id == record.group.id
    end
  end

  def can_edit_every_role?
    tested_group_ids = []
    record.each do |role|
      next if tested_group_ids.include?(role.group.id)

      if group = user.groups.find { |group| group.id == role.id }
        if member = user.members.find { |member| member.group.id == group }
          if member.role.can_edit_roles
            tested_group_ids << group.id
            next
          end
        end
      end
      return false
    end
    true
  end
end
