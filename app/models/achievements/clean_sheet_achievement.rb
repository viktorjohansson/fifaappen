class CleanSheetAchievement < Achievement
    def self.check_conditions_for(player)
      # Check if achievement is already awarded before doing possibly expensive
      # operations to see if the achievement conditions are met.
      @achievement = false
      if player.clean_sheet_record > 5
        player.award(self)
        @achievement = true
      end
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "CleanSheets", "description" => "Håll nollan 5 matcher i rad", "score" => 10, "img" => "cleansheets.png"}
    end
    
    def self.hash_me
      @achievement_hash = { "HasIt" => @achievement, "type" => "fame", "name" => "CleanSheets", "description" => "Håll nollan 5 matcher i rad", "score" => 10, "img" => "cleansheets.png"}
    end
    
  end