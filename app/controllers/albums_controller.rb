require 'zip'

class AlbumsController < ApplicationController
  before_action :load_album, except: %i[ index new create ]

  enforce_login! except: %i[ index show download ]

  def index
    @albums = policy_scope(Album)
    authorize @albums
  end

  def show
  end

  def new
    @album = Album.new
    authorize @album
  end

  def create
    @album                = Album.new(album_params)
    @album.new_images     = uploaded_images
    authorize @album
    @album.save_with_images
    respond_with @album
  end

  def edit
    @original_album = get_album
  end

  def update
    @original_album       = get_album
    @album.deleted_images = deleted_images
    @album.new_images     = uploaded_images
    @album.assign_attributes(album_params)
    @album.save_with_images
    respond_with @album
  end

  def download
    send_file @album.archive.file.path, filename: @album.archive.filename, type: @album.archive.mimetype
  end

  def destroy
    @album.destroy_with_images
    respond_with @album, action: 'edit'
  end

protected
  def load_album
    @album = get_album || not_found
    authorize @album
  end

  def get_album
    Album.find_by('LOWER(name) = LOWER(?)', CGI::unescape(params[:name]))
  end

private
  def album_params
    params.require(:album).permit(
      :name,
      :description
    )
  end

  def uploaded_images
    params.permit![:album][:new_images]
  end

  def deleted_images
    ids = params.permit![:album][:deleted_images].split(';')
    Album::Image.where(id: ids, album_id: @album.id)
  end

  def delete_with_versions!(image)
    image.remove!
    image.versions.each_pair do |_name, version|
      delete_with_versions!(version)
    end
  end
end
