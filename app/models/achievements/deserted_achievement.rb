class DesertedAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.games_per_night
    if player.games_per_night < 5
      player.award(self)
      @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BigToffel", "description" => "Lämna en spelkväll med mindre än 5 spelade matcher", "score" => -10, "img" => "deserter.png"}
  end
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BigToffel", "description" => "Lämna en spelkväll med mindre än 5 spelade matcher", "score" => -10, "img" => "deserter.png"}
end

end