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

  def login
    skip_authorization
  end

  def login_create
    skip_authorization

    if params.permit!.dig(:homescouting, :password) == ENV['PFADIOLTEN_HOMESCOUTING_UPLOAD_KEY']
      session[:homescouting_auth] = ENV['PFADIOLTEN_HOMESCOUTING_UPLOAD_KEY']
      redirect_to action: :show
    else
      @failed = true
      render 'login'
    end
  end

  def logout
    skip_authorization

    session.delete(:homescouting_auth)
    redirect_to action: :show
  end

private
  def load_files
    page = params[:page]
    @files = policy_scope Homescouting::File.order(created_at: :desc).page(page)
  end

  def check_upload_permissions
    @has_session = session[:homescouting_auth] == ENV['PFADIOLTEN_HOMESCOUTING_UPLOAD_KEY']
    @allow_upload = @has_session || current_user.present?
  end
end