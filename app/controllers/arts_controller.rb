class ArtsController < ApplicationController
  before_action :set_art, only: %i[ show edit update destroy ]

  def index
    @arts = Art.all.order(:name)
  end

  def show
  end

  def new
    @art = Art.new
  end

  def edit
  end

  def create
    @art = Art.new(art_params)

    if @art.save
      redirect_to art_url(@art), notice: "#{@art.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @art.update(art_params)
      redirect_to art_url(@art), notice: "#{@art.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @art.destroy

    redirect_to arts_url, notice: "#{@art.name} was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_art
      @art = Art.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def art_params
      params.require(:art).permit(:name, :abbrev)
    end
end
