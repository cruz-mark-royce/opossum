json.array!(@questions) do |question|
  json.extract! question, :id, :survey_id, :order, :question_type, :value
  json.url question_url(question, format: :json)
end
