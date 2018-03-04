class ContactController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization
  end
end
