class Organizations::MembersController < ApplicationController
  def new
    @member = Organization::Member.new(organization: get_org)
    authorize @member
  end

  def create
    @member = Organization::Member.new(member_params.merge(organization: get_org))
    authorize @member
    @member.save
    respond_with @member, location: ->{ url_for(@member.organization) }
  end

  def edit
    @member = (@original_member = get_member)
    authorize @member
  end

  def update
    @member          = get_member
    @original_member = get_member
    authorize @member
    @member.update(member_params)
    respond_with @member, location: ->{ url_for(@member.organization) }
  end

  def destroy
    @member = get_member
    authorize @member
    @member.destroy
    respond_with @member, action: 'edit', location: ->{ url_for(@member.organization) }
  end

private
  def member_params
    params.require(:organization_member).permit(
      :first_name,
      :last_name,
      :scout_name,
      :role,
      avatar_attributes: [
        :file,
        :id,
        :_destroy,
      ],
    )
  end

  def get_org
    org_name = params.fetch(:organization_abbreviation)
    Organization.find_by_abbreviation(org_name) || not_found
  end

  def get_member
    name = params.fetch(:name)
    get_org.members.find_by_name(name) || not_found
  end
end
