class BigBetsAchievement < Achievement
    def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
      @achievement = false
      if player.double_games_record > 14
        player.award(self)
        @achievement = true
      end
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "Bigbets!", "description" => "Minst 15 spelade dubbelmatcher", "score" => 10, "img" => "bigbets.png"}
    end


    def self.hash_me
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "Bigbets!", "description" => "Minst 15 spelade dubbelmatcher", "score" => 10, "img" => "bigbets.png"}
    end
    
end