module RoundsHelper

  def winodds(teamone, teamtwo)
    @player1 = Player.find_by(name: teamone[0])
    @player2 = Player.find_by(name: teamone[1])
    @player3 = Player.find_by(name: teamtwo[0])
    @player4 = Player.find_by(name: teamtwo[1])
    
    @players = [@player1, @player2, @player3, @player4]
    # for holding players with win/lose ratio
    @win_lose_ratios = []
    
    @players.each do |player|
      if player.statistic_all_times.last != nil
        # check if they have atleast one win and one lose
        if player.statistic_all_times.last.wins > 0 && player.statistic_all_times.last.losses > 0
          @wins = player.statistic_all_times.last.wins.to_f
          @losses = player.statistic_all_times.last.losses.to_f
          @win_lose_ratio = (@wins / @losses)
          # push players win/lose ratio
          @win_lose_ratios.push(@win_lose_ratio)
        end
      end
    end
    # check for nil values
    if @win_lose_ratios.length == 4
      # getting teams ratio instead of players ratio
      @team_one_ratio = (@win_lose_ratios[0] + @win_lose_ratios[1]) / 2
      @team_two_ratio = (@win_lose_ratios[2] + @win_lose_ratios[3]) / 2
      # divide team ratio with total ratio to get team win odds and multiply by 100 to get percentage
      @winodds_team_one = (@team_one_ratio / (@team_one_ratio + @team_two_ratio)) * 100
      @winodds_team_two = (@team_two_ratio / (@team_one_ratio + @team_two_ratio)) * 100
      @winodds_array = [@winodds_team_one.round(3).to_s + "% to Win", @winodds_team_two.round(3).to_s + "% to Win"]
    end
    return @winodds_array
  end
  
end