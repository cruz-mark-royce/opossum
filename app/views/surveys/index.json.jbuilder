json.array!(@surveys) do |survey|
  json.extract! survey, :id, :user_id, :title, :description, :published
  json.url survey_url(survey, format: :json)
end
