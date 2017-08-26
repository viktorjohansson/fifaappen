class GoalAgainstAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.goals_against_record > 5
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoKeeper", "description" => "Släpp in minst 6 mål", "score" => -10, "img" => "goalagainst.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoKeeper", "description" => "Släpp in minst 6 mål", "score" => -10, "img" => "goalagainst.png"}
end

end