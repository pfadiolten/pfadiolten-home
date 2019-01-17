class Organizations::ImagesController < ::ImagesController
  def imageable
    @org ||= (Organization.find_by_abbreviation(params[:organization_abbreviation]) || not_found)
  end
end
