class PoorManAchievement < Achievement
def self.check_conditions_for(player)
  # Check if achievement is already awarded before doing possibly expensive
  # operations to see if the achievement conditions are met.
  @achievement = false
  if player.balance_under_500
    player.award(self)
    @achievement = true
  end
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "PoorMan", "description" => "Ha en Balance-totalt under -500", "score" => -10, "img" => "poorman.png"}
end

def self.hash_me
  @achievement_hash = { "HasIt" => @achievement, "type" => "shame", "name" => "PoorMan", "description" => "Ha en Balance-totalt under -500", "score" => -10, "img" => "poorman.png"}
end


end