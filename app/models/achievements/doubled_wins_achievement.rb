class DoubledWinsAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.double_games_by_night
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "DoubleWins", "description" => "Vinn 3 dubbelmatcher på en kväll", "score" => 10, "img" => "doubledwins.png"}
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "DoubleWins", "description" => "Vinn 3 dubbelmatcher på en kväll", "score" => 10, "img" => "doubledwins.png"}
end

end