class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews
  # POST /interviews.json
  def create
    @interview = Interview.new(interview_params)

    interviewee_email = params[:interviewee_email]

    interviewee = Interviewee.find_by_email(interviewee_email)

    if interviewee
      @interview.interviewee = interviewee
    else
      begin
        @interview.interviewee = Interviewee.create!(email: interviewee_email)
      rescue Exception => e
        @interview.errors.add(:interviewer, "should be present")
      end
    end

    interviewer_emails = params[:interviewer_emails]
    interviewer_emails = interviewer_emails.split(' ')

    interviewer_emails.each do |interviewer_email|
      interviewer = Interviewer.find_by_email(interviewer_email)
      if interviewer
        @interview.interviewers << interviewer
      else
        @interview.interviewers << Interviewer.create(email: interviewer_email)
      end
    end

    respond_to do |format|
      if @interview.save
        format.html { redirect_to root_path, notice: 'Interview was successfully created.' }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    interviewee_email = params[:interviewee_email]

    interviewee = Interviewee.find_by_email(interviewee_email)

    if interviewee
      @interview.interviewee = interviewee
    else
      begin
        @interview.interviewee = Interviewee.create!(email: interviewee_email)
      rescue Exception => e
        @interview.errors.add(:interviewer, "should be present")
      end
    end

    interviewer_emails = params[:interviewer_emails]
    interviewer_emails = interviewer_emails.split(' ')

    @interview.interviewers = []
    interviewer_emails.each do |interviewer_email|
      interviewer = Interviewer.find_by_email(interviewer_email)
      if interviewer
        @interview.interviewers << interviewer
      else
        @interview.interviewers << Interviewer.create(email: interviewer_email)
      end
    end

    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to root_path, notice: 'Interview was successfully updated.' }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url, notice: 'Interview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:title, :date, :time)
    end
end
