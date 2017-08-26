class MarriedAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.days_since_last_game
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "Married", "description" => "Spela inga matcher på 90 dagar", "score" => -10, "img" => "married.png"}
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "Married", "description" => "Spela inga matcher på 90 dagar", "score" => -10, "img" => "married.png"}
end

end