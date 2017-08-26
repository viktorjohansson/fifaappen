json.array!(@matches) do |match|
  json.extract! match, :id, :home, :away
  json.url match_url(match, format: :json)
end
