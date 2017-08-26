class SolidMonthAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.game_nights_month_record > 2
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "SolidMonth", "description" => "Minst 3 spelkvällar på en månad", "score" => 10, "img" => "solidmonth.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "SolidMonth", "description" => "Minst 3 spelkvällar på en månad", "score" => 10, "img" => "solidmonth.png"}
end


end