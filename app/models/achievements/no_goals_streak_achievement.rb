class NoGoalsStreakAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.no_score_streak < 1
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoGoals", "description" => "Inga mål gjorde på 5 matcher i rad", "score" => -10, "img" => "nogoals.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoGoals", "description" => "Inga mål gjorde på 5 matcher i rad", "score" => -10, "img" => "nogoals.png"}
end

end