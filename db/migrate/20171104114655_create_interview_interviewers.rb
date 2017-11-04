class CreateInterviewInterviewers < ActiveRecord::Migration[5.1]
  def change
    create_table :interview_interviewers do |t|
      t.references :interview, foreign_key: true
      t.references :interviewer, foreign_key: true

      t.timestamps
    end
  end
end
