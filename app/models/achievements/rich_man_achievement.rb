class RichManAchievement < Achievement
    def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
      @achievement = false
      if player.balance_over_500
        player.award(self)
        @achievement = true
      end
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "RichMan", "description" => "Ha en Balance-totalt över 500", "score" => 10, "img" => "richman.png"}
    end

    def self.hash_me
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "RichMan", "description" => "Ha en Balance-totalt över 500", "score" => 10, "img" => "richman.png"}
    end
    

  end