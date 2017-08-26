class GoldStreakAchievement < Achievement

  def self.check_conditions_for(player)
    # Check if achievement is already awarded before doing possibly expensive
    # operations to see if the achievement conditions are met.
    @achievement = false
    if player.gold_streak
      player.award(self)
      @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GoldStreak", "description" => "Vinn över 100:- 3 kvällar på rad", "score" => 10, "img" => "goldstreak.png"}
  end
  
  def self.hash_me
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GoldStreak", "description" => "Vinn över 100:- 3 kvällar på rad", "score" => 10, "img" => "goldstreak.png"}
  end
  
end