class GamingWeekAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.game_nights_week_record > 1
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GamingWeek", "description" => "Spela 2 kvällar på en vecka", "score" => 10, "img" => "gaminweek.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "GamingWeek", "description" => "Spela 2 kvällar på en vecka", "score" => 10, "img" => "gaminweek.png"}
end

end