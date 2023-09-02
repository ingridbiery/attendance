class CoursesController < ApplicationController
  before_action :set_art
  before_action :set_course, except: %i[ new create ]

  def index
    @courses = @art.courses
  end

  def show
  end

  def new
    @course = @art.courses.build
  end

  def edit
  end

  def create
    @course = @art.courses.build(course_params)

    if @course.save
      redirect_to art_course_path(@art, @course), notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      redirect_to art_course_path(@course), notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy

    redirect_to @art, notice: "Course was successfully destroyed."
  end

  # attendance for one class meeting
  def attendance
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      if params[:id]
        @course = Course.find(params[:id])
      else
        @course = Course.find(params[:course_id])
      end
    end

    # get the art from params before doing anything else
    def set_art
      @art = Art.find(params[:art_id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:art_id, :day, :time)
    end
end
