class LoseStreakAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.lose_streak_record > 5
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "LoseStreak", "description" => "Förlora 5 matcher i rad", "score" => -10, "img" => "losestreak.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "LoseStreak", "description" => "Förlora 5 matcher i rad", "score" => -10, "img" => "losestreak.png"}
end

end