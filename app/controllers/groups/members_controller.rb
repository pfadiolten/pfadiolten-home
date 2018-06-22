class Groups::MembersController < ApplicationController
  before_action :load_group

  before_action :load_member,
                only: %i[edit update destroy]

  enforce_login!

  def new
    @member = Group::Member.new(group: @group)
    authorize @member
  end

  def create
    @member = Group::Member.new(member_params.merge(group: @group))
    authorize @member
    @member.save
    respond_with @member, location: group_path
  end

  def edit
  end

  def update
    @member.update(params.require(:group_member).permit(:role_id))
    respond_with @member, location: group_path
  end

  def destroy
    @member.destroy
    respond_with @member, action: 'edit', location: group_path
  end

  protected
  def load_group
    @group = Group.find_by('LOWER(abbreviation) = LOWER(?)', params[:group_abbreviation]) || not_found
  end

  def load_member
    @member = get_member || not_found
    authorize @member
  end

  def get_member
    if scout_name = params[:scout_name]&.downcase
      @group.members.find { |it| it.user.scout_name.downcase == scout_name }
    end
  end

  private
  def member_params
    params.require(:group_member).permit(
      :user_id,
      :role_id
    )
  end
end
