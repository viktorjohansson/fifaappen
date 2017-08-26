json.array!(@players) do |player|
  json.extract! player, :id, :name, :pass, :mail
  json.url player_url(player, format: :json)
end
