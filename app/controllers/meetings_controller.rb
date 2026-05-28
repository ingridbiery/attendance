class MeetingsController < ApplicationController
  before_action :set_art
  before_action :set_course
  before_action :set_meeting, only: %i[ show edit update destroy ]
  
  def show
    # who attended this meeting already
    @attended = @meeting.people.joins(ranks: :belt)
                        .where(belts: { art: @art })
                        .select("people.*, belts.level")
                        .order("belts.level DESC, last_name, first_name")
                        .distinct
  end
  
  def new
    @meeting = @course.meetings.build(date: Date.today)
    
    load_attendance_data
  end
  
  def create
    @meeting = @course.meetings.build(meeting_params)
    
    if @meeting.save
      create_attendances
      redirect_to [@art, @course, @meeting], notice: "Meeting was successfully created."
    else
      load_attendance_data
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    load_attendance_data
  end
  
  def update
    if @meeting.update(meeting_params)
      @meeting.attendances.destroy_all
      create_attendances
      redirect_to [@art, @course, @meeting], notice: "Meeting was successfully edited."
    else
      load_attendance_data
      render :edit, status: :unprocessable_entity
    end
    
  end
  
  def destroy
    @meeting.destroy
    
    redirect_to [@art, @course], notice: "Meeting was successfully destroyed."
  end
  
  private
    # get all of the data we need to fill the view
    def load_attendance_data
      @attended = @meeting.attended(params[:people_ids])
      @attended_last = @meeting.attended_previous - @attended
      @others = @meeting.eligible_people - @attended - @attended_last
    end
    
    # create the actual attendances
    def create_attendances
      person_ids = params[:person_ids] || []
      person_ids.each do |person_id|
        @meeting.attendances.create!(person_id: person_id)
      end
    end

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
