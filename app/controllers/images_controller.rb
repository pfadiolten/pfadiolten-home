class ImagesController < ApplicationController

  def show
    authorize imageable, :update?
  end

  def create
    authorize imageable, :update?

    errors = []
    images = images_params[:images].map do |params|
      image = Image.new({ imageable: @org }.merge(params))
      errors += image.errors.full_messages unless image.valid?
      image
    end

    respond_to do |format|
      if errors.any?
        format.json { render json: { errors: errors }, status: :unprocessable_entity }
      else
        @org.images += images
        format.json { render json: { ok: true } }
      end
    end
  end

private
  def images_params
    params.permit(
      images: [
        :file
      ]
    )
  end
end