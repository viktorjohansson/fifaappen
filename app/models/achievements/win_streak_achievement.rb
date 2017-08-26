class WinStreakAchievement < Achievement

  def self.check_conditions_for(player)
    # Check if achievement is already awarded before doing possibly expensive
    # operations to see if the achievement conditions are met.
    @achievement = false
    if player.streak_record > 4
      player.award(self)
      @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "WinStreak", "description" => "Vinn 5 matcher i rad", "score" => 10, "img" => "winstreak.png"}
  end

  def self.hash_me
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "WinStreak", "description" => "Vinn 5 matcher i rad", "score" => 10, "img" => "winstreak.png"}
  end
  

end