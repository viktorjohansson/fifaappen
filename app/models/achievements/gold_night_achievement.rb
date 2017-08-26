class GoldNightAchievement < Achievement

  def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
    @achievement = false
    if player.gold_night
      player.award(self)
      @achievement = true
    end
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GoldNight!", "description" => "Vinn över 200:- på en kväll", "score" => 10, "img" => "goldnight.png"}
  end
  
  def self.hash_me
    @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GoldNight!", "description" => "Vinn över 200:- på en kväll", "score" => 10, "img" => "goldnight.png"}
  end
  
end
