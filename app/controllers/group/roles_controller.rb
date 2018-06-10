class Group::RolesController < ApplicationController
  before_action :load_group

  before_action :load_role,
                except: %I[index new create]

  enforce_login!

  def index
    @roles = policy_scope(@group.roles)
    authorize @roles
  end

  def show
  end

  def new
    @role = Group::Role.new(group: @group)
    authorize @role
  end

  def create
    @role = Group::Role.new(role_params.merge(group: @group))
    authorize @role
    @role.save
    respond_with @role, location: make_show_path
  end

  def edit
    @original_role = get_role
  end

  def update
    @original_role = get_role
    @role.update(role_params)
    respond_with @role, location: make_show_path
  end

  def destroy
    @role.destroy
    respond_with @role, action: 'edit'
  end

  protected
  def load_group
    @group = Group.find_by('LOWER(abbreviation) = LOWER(?)', params[:abbreviation]) || not_found
  end

  def load_role
    @role = get_role || not_found
    authorize @role
  end

  def get_role
    @group.roles.find_by('LOWER(name) = LOWER(?)', params[:name])
  end

  private
  def role_params
    params.require(:group_role).permit(
      :name,
      :can_edit_group,
      :can_edit_members
    )
  end

  def make_show_path
    ->{ group_role_path(@role.group, @role) }
  end
end
