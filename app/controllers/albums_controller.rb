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
    @album = Album.new(album_params)
    authorize @album
    @album.save
    respond_with @album
  end

  def edit
    @original_album = get_album
  end

  def update
    @original_album = get_album
    update_params = album_params

    if indices_to_remove = params.dig(:album, :remove_images)
      indices_to_remove.split(';').map!(&:to_i).sort!.reverse!.map do |i|
        remain_images = @album.images
        deleted_image = remain_images.delete_at(i)
        deleted_image.try(:remove!)
        @album.images = remain_images
      end
    end
    if new_images = update_params.delete(:images)
      images = @album.images
      images += new_images
      @album.images = images
    end
    @album.update(update_params)
    respond_with @album
  end

  def download
    respond_to do |format|
      format.html do
        compressed_filestream = ::Zip::OutputStream.write_buffer do |zos|
          @album.images.each_with_index do |image, i|
            zos.put_next_entry("#{i}#{File.extname(image.path)}")
            File.open(image.path, 'rb') { |file| zos.print(file.read) }
          end
        end
        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "#{@album.name_for_file}.zip"
      end
    end
  end

  def destroy
    @album.destroy
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
      :description,
      images: []
    )
  end
end
