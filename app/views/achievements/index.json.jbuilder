json.array!(@achievements) do |achievement|
  json.extract! achievement, :id, :player_id, :type
  json.url achievement_url(achievement, format: :json)
end
