class StatisticsController < ApplicationController
  skip_before_filter :authorize


  def index
  end

  def teams


    @teams = Team.all
    @team_stats = []
    @team_stats_last = []




    @teams.each do |t|
      @goals_for = [0]
      @goals_against = [0]
      @wins = [0]
      @losses = [0]
      @ties = [0]
      @win_streak = [0]
      @lose_streak = [0]
      @tie_streak = [0]
      @goal_difference = [0]
      @bet = [0]

      @goals_for_last = [0]
      @goals_against_last = [0]
      @wins_last = [0]
      @losses_last = [0]
      @ties_last = [0]
      @win_streak_last = [0]
      @lose_streak_last = [0]
      @tie_streak_last = [0]
      @goal_difference_last = [0]
      @bet_last = [0]



      t.matches.each do |g|
        if last_day_check(g)
          @wins_last.push(g.wins(t))
          @losses_last.push(g.losses(t))
          @ties_last.push(g.ties(t))
          @goals_for_last.push(g.goals_for(t))
          @goals_against_last.push(g.goals_against(t))
          @goal_difference_last.push(g.goal_difference(t))
          @bet_last.push([g.goal_difference(t), g.bet])
        end
        @wins.push(g.wins(t))
        @losses.push(g.losses(t))
        @ties.push(g.ties(t))
        @goals_for.push(g.goals_for(t))
        @goals_against.push(g.goals_against(t))
        @goal_difference.push(g.goal_difference(t))
        @bet.push([g.goal_difference(t), g.bet])
      end


      @stats_hash = { "team_name" => t, "games_played" => @wins.inject(:+) + @losses.inject(:+) + @ties.inject(:+),
                      "wins" => @wins.inject(:+), "losses" => @losses.inject(:+), "ties" => @ties.inject(:+),
                      "points" => @wins.inject(:+) * 3 + @ties.inject(:+), "goals_for" => @goals_for.inject(:+),
                      "goals_against" => @goals_against.inject(:+), "streak" => (t.streak[0].to_s + " " + t.streak[1].to_s),
                      "balance" => balance(@bet).inject(:+) * 20}


      @stats_last_hash = { "team_name" => t, "games_played" => @wins_last.inject(:+) + @losses_last.inject(:+) + @ties_last.inject(:+),
                           "wins" => @wins_last.inject(:+), "losses" => @losses_last.inject(:+), "ties" => @ties_last.inject(:+),
                           "points" => @wins_last.inject(:+) * 3 + @ties_last.inject(:+), "goals_for" => @goals_for_last.inject(:+),
                           "goals_against" => @goals_against_last.inject(:+), "balance" => balance(@bet_last).inject(:+) * 20}


      @team_stats.push(@stats_hash)
      @team_stats_last.push(@stats_last_hash)


    end

    @team_stats_sorted = @team_stats.sort_by { |k| k["balance"] }.reverse
    @team_stats_last_sorted = @team_stats_last.sort_by { |k| k["balance"] }.reverse

  end


  def players
    @players = Player.all
    @player_stats = []
    @player_stats_last = []


    @players.each do |p|
      @goals_for = [0]
      @goals_against = [0]
      @wins = [0]
      @losses = [0]
      @ties = [0]
      @win_streak = [0]
      @lose_streak = [0]
      @tie_streak = [0]
      @goal_difference = [0]
      @bet = [0]

      @goals_for_last = [0]
      @goals_against_last = [0]
      @wins_last = [0]
      @losses_last = [0]
      @ties_last = [0]
      @win_streak_last = [0]
      @lose_streak_last = [0]
      @tie_streak_last = [0]
      @goal_difference_last = [0]
      @bet_last = [0]



      p.teams.each do |t|
        t.matches.each do |g|
          if last_day_check(g)
            @wins_last.push(g.wins(t))
            @losses_last.push(g.losses(t))
            @ties_last.push(g.ties(t))
            @goals_for_last.push(g.goals_for(t))
            @goals_against_last.push(g.goals_against(t))
            @goal_difference_last.push(g.goal_difference(t))
            @bet_last.push([g.goal_difference(t), g.bet])
          end
          @wins.push(g.wins(t))
          @losses.push(g.losses(t))
          @ties.push(g.ties(t))
          @goals_for.push(g.goals_for(t))
          @goals_against.push(g.goals_against(t))
          @goal_difference.push(g.goal_difference(t))
          @bet.push([g.goal_difference(t), g.bet])
        end
      end


      @stats_hash = { "player_name" => p, "games_played" => @wins.inject(:+) + @losses.inject(:+) + @ties.inject(:+),
                      "wins" => @wins.inject(:+), "losses" => @losses.inject(:+), "ties" => @ties.inject(:+),
                      "points" => @wins.inject(:+) * 3 + @ties.inject(:+), "goals_for" => @goals_for.inject(:+),
                      "goals_against" => @goals_against.inject(:+), "streak" => (p.streak[0].to_s + " " + p.streak[1].to_s),
                      "balance" => balance(@bet).inject(:+) * 20}


      @stats_last_hash = { "player_name" => p, "games_played" => @wins_last.inject(:+) + @losses_last.inject(:+) + @ties_last.inject(:+),
                           "wins" => @wins_last.inject(:+), "losses" => @losses_last.inject(:+), "ties" => @ties_last.inject(:+),
                           "points" => @wins_last.inject(:+) * 3 + @ties_last.inject(:+), "goals_for" => @goals_for_last.inject(:+),
                           "goals_against" => @goals_against_last.inject(:+), "balance" => balance(@bet_last).inject(:+) * 20}


      @player_stats.push(@stats_hash)
      @player_stats_last.push(@stats_last_hash)




    end

    @player_stats_sorted = @player_stats.sort_by { |k| k["balance"] }.reverse
    @player_stats_last_sorted = @player_stats_last.sort_by { |k| k["balance"] }.reverse


  end

  def show_team
    @team = Team.find(params[:id])
    @games = @team.matches
    @goals_for = [0]
    @highscore_goals_for = [0]
    @hs_goalsf_team = [0]
    @goals_against = [0]
    @wins = [0]
    @losses = [0]
    @ties = [0]
    @win_streak = [0]
    @lose_streak = [0]
    @tie_streak = [0]
    @cash = [0]
    @goal_difference = [0]
    @streak = @team.streak
    @bet = [0]


    @games.each do |g|
      @wins.push(g.wins(@team))
      @losses.push(g.losses(@team))
      @ties.push(g.ties(@team))
      @goals_for.push(g.goals_for(@team))
      @goals_against.push(g.goals_against(@team))
      @highscore_goals_for.push(g.highscore_goals_for(@team))
      @goal_difference.push(g.goal_difference(@team))
      @bet.push([g.goal_difference(@team), g.bet])
    end

    @balance = balance(@bet).inject(:+) * 20


  end

  def show_player
    @player = Player.find(params[:id])
    @player_achievements = Achievement.where(params[:player_id])
    @player_achievement_hash_array = []
    @player_achievement_hash_array.push(BadBetsAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(BadScorerAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(BigBetsAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(CleanSheetAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(DesertedAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(DoubleBigLoseAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(DoubledWinsAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(GamingWeekAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(GoalAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(GoalAgainstAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(GoldNightAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(GoldStreakAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(LoseStreakAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(MarriedAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(NoCleanSheetAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(NoGoalsStreakAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(OpenNetAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(PoorManAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(ReliableScorerAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(RichManAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(ScoreEveryMatchAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(SolidMonthAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(TrueWinnerAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(WinStreakAchievement.check_conditions_for(@player))
    @player_achievement_hash_array.push(WinnerNightAchievement.check_conditions_for(@player))

    @teams = @player.teams
    @goals_for = [0]
    @highscore_goals_for = [0]
    @hs_goalsf_team = [0]
    @goals_against = [0]
    @wins = [0]
    @losses = [0]
    @ties = [0]
    @win_streak = [0]
    @lose_streak = [0]
    @tie_streak = [0]
    @cash = [0]
    @goal_difference = [0]
    @bet = [0]
    @balance_collect_teams = [0]
    @streak = @player.streak

    @teams.each do |t|
      t.matches.each do |g|
          @wins.push(g.wins(t))
          @losses.push(g.losses(t))
          @ties.push(g.ties(t))
          @goals_for.push(g.goals_for(t))
          @goals_against.push(g.goals_against(t))
          @highscore_goals_for.push(g.highscore_goals_for(t))
          @goal_difference.push(g.goal_difference(t))
          @bet.push([g.goal_difference(t), g.bet])
      end
    end

    @games = @wins.inject(:+) + @losses.inject(:+) + @ties.inject(:+)
    @balance = balance(@bet).inject(:+) * 20

  end
  
  def score_board
    @players = Player.all
    @all_time_players = []
    @last_time_players = []
    @last_season_players = []
    @players.each do |player|
      if player.statistic_all_times.any?
        @all_time_players.push({"player" => player, "player_stats" => player.statistic_all_times.last, "player_balance" => player.statistic_all_times.last.balance})
      end
      if player.statistic_last_times.any?
        if (player.statistic_last_times.last.created_at + 1.days) > StatisticLastTime.last.created_at
          @last_time_players.push({"player" => player, "player_stats" => player.statistic_last_times.last, "player_balance" => player.statistic_last_times.last.balance})
        end
      end
      if player.statistic_last_seasons.any?
        @last_season_players.push({"player" => player, "player_stats" => player.statistic_last_seasons.last, "player_balance" => player.statistic_last_seasons.last.balance})
      end
    end
    
    @all_time_players_sorted = @all_time_players.sort_by { |k| k["player_balance"] }.reverse
    @last_time_players_sorted = @last_time_players.sort_by { |k| k["player_balance"] }.reverse
    @last_season_players_sorted = @last_season_players.sort_by { |k| k["player_balance"] }.reverse
    
    @all_time_players_index = []
    @all_time_players_sorted.each_with_index do |player, index|
      @all_time_players_index.push([player["player"].name, (index + 1)])
    end
    @all_time_players_changed_index = []
    @all_time_players_new_index = []
    @all_time_players_sorted.reverse.each_with_index do |player, index|
      @all_time_players_index.each do |oldplayer|
        if oldplayer[0] == player["player"].name
          @players_past = []
          @players_past_me = []
          $i = 0
          while $i < (oldplayer[1] - (index + 1)).abs do
            if (oldplayer[1] - (index + 1)) > 0
              @players_past.push(@all_time_players_index.reverse[($i - (oldplayer[1] - (index + 1)))])
            else
              @players_past_me.push(@all_time_players_index.reverse[($i + (oldplayer[1] - (index + 1)))])
            end
            $i += 1
          end
          @player_past_by = @players_past
          if @players_past.count < @players_past_me.count
            @player_past_by = @players_past_me
          end 
          @all_time_players_changed_index.push([oldplayer[0], (index + 1), (oldplayer[1] - (index + 1)), @player_past_by])
        end
      end
    end
end
  
  def player_score_board
    @player = Player.find(params[:id])
  end
  
  def achievement_check
    @player = Player.find(params[:id])
    BadBetsAchievement.check_conditions_for(@player)
    BadScorerAchievement.check_conditions_for(@player)
    BigBetsAchievement.check_conditions_for(@player)
    BigWinsNightAchievement.check_conditions_for(@player)
    CleanSheetAchievement.check_conditions_for(@player)
    DesertedAchievement.check_conditions_for(@player)
    DoubleBigLoseAchievement.check_conditions_for(@player)
    DoubledWinsAchievement.check_conditions_for(@player)
    GamingWeekAchievement.check_conditions_for(@player)
    GoalAchievement.check_conditions_for(@player)
    GoalAgainstAchievement.check_conditions_for(@player)
    GoldNightAchievement.check_conditions_for(@player)
    GoldStreakAchievement.check_conditions_for(@player)
    LoseStreakAchievement.check_conditions_for(@player)
    MarriedAchievement.check_conditions_for(@player)
    NoCleanSheetAchievement.check_conditions_for(@player)
    NoGoalsStreakAchievement.check_conditions_for(@player)
    OpenNetAchievement.check_conditions_for(@player)
    PoorManAchievement.check_conditions_for(@player)
    ReliableScorerAchievement.check_conditions_for(@player)
    RichManAchievement.check_conditions_for(@player)
    ScoreEveryMatchAchievement.check_conditions_for(@player)
    SolidMonthAchievement.check_conditions_for(@player)
    TrueWinnerAchievement.check_conditions_for(@player)
    WinStreakAchievement.check_conditions_for(@player)
    WinnerNightAchievement.check_conditions_for(@player)
  end
  
  def achievement_check_all
    @players = Player.all
    @players.each do |player|
      if player.matches.any?
        BadBetsAchievement.check_conditions_for(player)
        BadScorerAchievement.check_conditions_for(player)
        BigBetsAchievement.check_conditions_for(player)
        BigWinsNightAchievement.check_conditions_for(player)
        CleanSheetAchievement.check_conditions_for(player)
        DesertedAchievement.check_conditions_for(player)
        DoubleBigLoseAchievement.check_conditions_for(player)
        DoubledWinsAchievement.check_conditions_for(player)
        GamingWeekAchievement.check_conditions_for(player)
        GoalAchievement.check_conditions_for(player)
        GoalAgainstAchievement.check_conditions_for(player)
        GoldNightAchievement.check_conditions_for(player)
        GoldStreakAchievement.check_conditions_for(player)
        LoseStreakAchievement.check_conditions_for(player)
        MarriedAchievement.check_conditions_for(player)
        NoCleanSheetAchievement.check_conditions_for(player)
        NoGoalsStreakAchievement.check_conditions_for(player)
        OpenNetAchievement.check_conditions_for(player)
        PoorManAchievement.check_conditions_for(player)
        ReliableScorerAchievement.check_conditions_for(player)
        RichManAchievement.check_conditions_for(player)
        ScoreEveryMatchAchievement.check_conditions_for(player)
        SolidMonthAchievement.check_conditions_for(player)
        TrueWinnerAchievement.check_conditions_for(player)
        WinStreakAchievement.check_conditions_for(player)
        WinnerNightAchievement.check_conditions_for(player)
      end
    end
    redirect_to :back
  end
end



