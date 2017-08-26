class BadScorerAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.lowest_score_in_15_games < 11
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BadScorer", "description" => "Under 10 mål gjorda på 15 matcher", "score" => -10, "img" => "badscorer.png"}
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "BadScorer", "description" => "Under 10 mål gjorda på 15 matcher", "score" => -10, "img" => "badscorer.png"}
end

end