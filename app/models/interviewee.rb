class Interviewee < ApplicationRecord
	has_one :interview, dependent: :destroy

	validates :email, presence: true, uniqueness: true, case_sensititve: false
end
