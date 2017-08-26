class ScoreEveryMatchAchievement < Achievement
    def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
      @achievement = false
      if player.score_streak > 9
        player.award(self)
        @achievement = true
      end
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "TopNotchScorer", "description" => "Gör mål 10 matcher i rad", "score" => 10, "img" => "Scoreeverymatch.png"}
    end
    
    def self.hash_me
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "TopNotchScorer", "description" => "Gör mål 10 matcher i rad", "score" => 10, "img" => "Scoreeverymatch.png"}
    end
    
  end