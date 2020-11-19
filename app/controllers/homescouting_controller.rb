class HomescoutingController < ApplicationController
  before_action :load_files

  before_action :check_upload_permissions

  def show
    skip_authorization
  end

  def create
    raise ActionController::BadRequest.new('not authorized') unless @allow_upload

    params.permit![:homescouting_file][:file].each do |image_file|
      image_file_path = image_file.tempfile.path
      ImageProcessing::MiniMagick.source(image_file_path)
        .resize_to_limit(1024, 1024)
        .call(destination: image_file_path)

      file = Homescouting::File.new(file: image_file)
      authorize file
      file.save

      image_file.tempfile.delete
    end

    render :show
  end

private
  def load_files
    page = params[:page]
    @files = policy_scope Homescouting::File.page(page).order(created_at: :desc)
  end

  def check_upload_permissions
    @allow_upload = current_user.present? || (params[:upload] == ENV['PFADIOLTEN_HOMESCOUTING_UPLOAD_KEY'])
  end
end