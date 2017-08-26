class BigWinsNightAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.big_score_by_night
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "BigWins", "description" => "Vinn 3 matcher med minst 5 mål på en kväll", "score" => 10, "img" => "bigwins.png"}
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "BigWins", "description" => "Vinn 3 matcher med minst 5 mål på en kväll", "score" => 10, "img" => "bigwins.png"}
end


end