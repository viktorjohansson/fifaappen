class BadBetsAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
    if player.lost_double_games_by_night
      player.award(self)
      @achievement = true
    end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BadBets", "description" => "Förlora 3 dubbelmatcher på en kväll", "score" => 10, "img" => "badbets.png"}
  
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BadBets", "description" => "Förlora 3 dubbelmatcher på en kväll", "score" => 10, "img" => "badbets.png"}
end

end