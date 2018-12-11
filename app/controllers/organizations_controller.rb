class OrganizationsController < ApplicationController
  def index
    @organizations = policy_scope Organization.all.order(name: 'asc')
  end
end
