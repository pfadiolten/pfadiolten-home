class OrganizationsController < ApplicationController
  before_action :load_org,
                except: %i[ index new create ]

  def index
    @orgs = policy_scope Organization.all.order(name: 'asc')
  end

  def show
  end

  def new
    @org = Organization.new
    authorize @org
  end

  def create
    @org = Organization.new(org_params)
    authorize @org
    @org.save
    respond_with @org
  end

  def edit
    @original_org = get_org
  end

  def udpate
    @original_org = get_org
  end

protected
  def load_org
    @org = get_org || not_found
    authorize @org
  end

  def get_org
    Organization.find_by_abbreviation(params[:abbreviation])
  end

private
  def org_params
    params.require(:organization).permit(
      :name,
      :abbreviation,
    )
  end
end
