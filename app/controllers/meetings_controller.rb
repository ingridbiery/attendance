class MeetingsController < ApplicationController
  before_action :set_art
  before_action :set_course
  before_action :set_meeting, only: %i[ show destroy ]

  def show
  end

  def new
    @meeting = @course.meetings.build
    @date = Time.zone.today
  end

  def create
    @meeting = @course.meetings.build(meeting_params)

    if @meeting.save
      redirect_to @art, notice: "Meeting was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting.destroy

    redirect_to [@art, @course], notice: "Meeting was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # get the art from params before doing anything else
    def set_art
      @art = Art.find(params[:art_id])
    end

    # get the course from params before doing anything else
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:course_id, :art_id, :date)
    end
end
