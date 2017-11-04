json.extract! interview, :id, :title, :date, :time, :interviewee_id, :created_at, :updated_at
json.url interview_url(interview, format: :json)
