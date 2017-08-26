class GoalAchievement < Achievement

  def self.check_conditions_for(player)
    # Check if achievement is already awarded before doing possibly expensive
    # operations to see if the achievement conditions are met.
    @achievement = false
    if player.goals_scored_record > 5
      player.award(self)
      @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GOALS!!!", "description" => "Gör minst 6 mål på en match", "score" => 10, "img" => "goal.png"}
  end
    
  def self.hash_me
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GOALS!!!", "description" => "Gör minst 6 mål på en match", "score" => 10, "img" => "goal.png"}
  end
    
end