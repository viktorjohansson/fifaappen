class DoubleBigLoseAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.huge_double_lose
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "HugeDoubleLose", "description" => "Förlora en dubbelmatch med minst 5 i målskillnad", "score" => -10, "img" => "doublebiglose.png"}
end


def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "HugeDoubleLose", "description" => "Förlora en dubbelmatch med minst 5 i målskillnad", "score" => -10, "img" => "doublebiglose.png"}
end

end