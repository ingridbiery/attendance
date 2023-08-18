class PeopleController < ApplicationController
  before_action :set_family, except: :index
  before_action :set_person, only: %i[ show edit update destroy ]

  def index
    #@people = Person.includes(:family, :belts, :arts).joins(:arts).where("arts.abbrev" => "TKD")
    #@people = Person.includes(:family, :belts, :arts)
    @people = Hash.new
    Art.all.each do |art|
      @people[art] = art.people.includes(:family, :belts, :arts)
    end
  end

  def show
  end

  def new
    @person = @family.people.build
  end

  def edit
  end

  def create
    @person = @family.people.build(person_params)

    if @person.save
      redirect_to family_person_path(@family, @person), notice: "#{@person.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      redirect_to family_person_path(@family, @person), notice: "#{@person.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy

    redirect_to @family, notice: "#{@person.name} was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # get the family from params before doing anything else
    def set_family
      @family = Family.find(params[:family_id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:family_id, :first_name, :last_name, :dob)
    end
end
