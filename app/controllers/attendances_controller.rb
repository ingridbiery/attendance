class AttendancesController < ApplicationController
  before_action :set_art
  before_action :set_course
  before_action :set_meeting

  # POST /arts/:art_id/courses/:course_id/meetings/:meeting_id/attendances
  def create
    @meeting.attendances.destroy_all

    person_ids = params[:person_ids] || []
    person_ids.each do |person_id|
      @meeting.attendances.create!(person_id: person_id)
    end

    redirect_to art_course_meeting_path(@art, @course, @meeting), notice: "Attendance saved."
  end

  # DELETE /arts/:art_id/courses/:course_id/meetings/:meeting_id/attendances/:id
  def destroy
    @attendance = @meeting.attendances.find(params[:id])
    @attendance.destroy
    redirect_to art_course_meeting_path(@art, @course, @meeting), notice: "Attendance removed."
  end

  private
    def set_art
      @art = Art.find(params[:art_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_meeting
      @meeting = Meeting.find(params[:meeting_id])
    end

    def attendance_params
      params.require(:attendance).permit(:person_ids)
    end
end
