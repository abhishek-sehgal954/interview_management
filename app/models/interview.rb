class Interview < ApplicationRecord
  belongs_to :interviewee
  has_many :interview_interviewer
  has_many :interviewers, through: :interview_interviewer

  validates :title, presence: true
  validates :interviewee_id, uniqueness: true
  validate :atleast_one_interviewer_should_be_present
  validate :interviewee_should_be_present
  validate :interviewer_should_be_free

  def atleast_one_interviewer_should_be_present
  	if !interviewers.any?
  		errors.add(:interviewers, "atleast one interviewer should be present")
  	end  	
  end

  def interviewer_should_be_free
    interviewers.each do |interviewer|
      interviewer.interviews.each do |interview|
        if !( (date < interview.date and date + 3600 < interview.date) || (date > interview.date and date > interview.date + 3600) )
          errors.add(:scheduling_problem, "scheduling problem")
          break
        end 
      end
    end
  end

  def interviewee_should_be_present
  	if interviewee == nil
  		errors.add(:interviewee, "should be present")
  	end  	
  end

end
