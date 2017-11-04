class Interviewer < ApplicationRecord
	has_many :interview_interviewer, dependent: :destroy
  	has_many :interviews, through: :interview_interviewer

	validates :email, presence: true, uniqueness: true, case_sensititve: false
end
