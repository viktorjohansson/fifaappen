class OpenNetAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.against_score_in_10_games > 24
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "OpenNet", "description" => "Släpp in 25 mål på 10 matcher", "score" => -10, "img" => "opennet.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "OpenNet", "description" => "Släpp in 25 mål på 10 matcher", "score" => -10, "img" => "opennet.png"}
end

end