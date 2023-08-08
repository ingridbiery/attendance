class BeltsController < ApplicationController
  before_action :set_art
  before_action :set_belt, only: %i[ show edit update destroy ]

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

    # Only allow a list of trusted parameters through.
    def belt_params
      params.require(:belt).permit(:art_id, :level, :img, :rank)
    end
end
