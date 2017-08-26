class NoCleanSheetAchievement < Achievement

def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.against_score_streak > 9
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoCleanSheet!", "description" => "Släpp in mål i 10 matcher på rad", "score" => -10, "img" => "nocleansheet.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "NoCleanSheet!", "description" => "Släpp in mål i 10 matcher på rad", "score" => -10, "img" => "nocleansheet.png"}
end

end