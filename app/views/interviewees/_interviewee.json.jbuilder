json.extract! interviewee, :id, :name, :email, :created_at, :updated_at
json.url interviewee_url(interviewee, format: :json)
