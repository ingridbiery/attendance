class BeltsController < ApplicationController
  before_action :set_art
  before_action :set_belt, only: %i[ show edit update destroy ]

  # make sure image exists
  before_action :image_exists, only: %i[create update]

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
      redirect_to art_belt_path(@art, @belt), notice: "#{@belt.level} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @belt.update(belt_params)
      redirect_to art_belt_path(@art, @belt), notice: "#{@belt.level} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @belt.destroy

    redirect_to @art, notice: "#{@belt.level} was successfully destroyed."
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
    def image_exists
      if not File.exist?("app/assets/images/" + belt_params[:img])
        redirect_to edit_art_belt_path
      end
    end

    # Only allow a list of trusted parameters through.
    def belt_params
      params.require(:belt).permit(:art_id, :level, :img, :rank)
    end
end
