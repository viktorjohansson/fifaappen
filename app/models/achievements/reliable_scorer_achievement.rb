class ReliableScorerAchievement < Achievement
    def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
      @achievement = false
      if player.score_in_five_games > 12
        player.award(self)
        @achievement = true
      end
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "ReliableScorer", "description" => "Över 12 mål på 5 matcher", "score" => 10, "img" => "reliablescorer.png"}
    end


    def self.hash_me
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "ReliableScorer", "description" => "Över 12 mål på 5 matcher", "score" => 10, "img" => "reliablescorer.png"}
    end
    
  end