class BeltsController < ApplicationController
  before_action :set_art
  before_action :set_belt, only: %i[ show edit update destroy ]

  # make sure image exists
  before_action :image_exists_create, only: %i[ create ]
  before_action :image_exists_update, only: %i[ update ]

  def show
  end

  def new
    @belt = @art.belts.build
  end

  def edit
  end

  def create
    @belt = @art.belts.build(belt_params)

    if @belt.save
      redirect_to art_belt_path(@art, @belt), notice: "#{@belt.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @belt.update(belt_params)
      redirect_to art_belt_path(@art, @belt), notice: "#{@belt.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @belt.destroy

    redirect_to @art, notice: "#{@belt.name} was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_belt
      @belt = Belt.find(params[:id])
    end

    # get the art from params before doing anything else
    def set_art
      @art = Art.find(params[:art_id])
    end

    # make sure the image exists, if an image file is given
    def image_exists_create
      unless image_exists
        @belt = @art.belts.build(belt_params)  # so the form has the user’s input
        flash.now[:alert] = "Image file not found"
        render :new, status: :unprocessable_entity
        return
      end
    end
    def image_exists_update
      unless image_exists
        redirect_to edit_art_belt_path(@art, @belt), alert: "Image file not found" and return
      end
    end

    def image_exists
      img = belt_params[:img]
      return true if img.blank?

      image_path = Rails.root.join("app/assets/images", img)

      File.exist?(image_path)
    end

    # Only allow a list of trusted parameters through.
    def belt_params
      params.require(:belt).permit(:art_id, :name, :img, :level)
    end
end