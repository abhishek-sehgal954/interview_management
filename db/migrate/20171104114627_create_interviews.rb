class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.string :title
      t.datetime :date
      t.references :interviewee, foreign_key: true

      t.timestamps
    end
  end
end
