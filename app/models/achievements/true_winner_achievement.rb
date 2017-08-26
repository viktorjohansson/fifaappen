class TrueWinnerAchievement < Achievement


  def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
    @achievement = false
    if player.win_against_record > 5
        player.award(self)
        @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "TrueWinner", "description" => "Vinn mot minst 6 spelare i Systemet med minst 5 mål", "score" => 10, "img" => "truewinner.png"}
  end
  
  def self.hash_me
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "TrueWinner", "description" => "Vinn mot minst 6 spelare i Systemet med minst 5 mål", "score" => 10, "img" => "truewinner.png"}
  end
  
end