class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  respond_to :js, :html, :json

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
      if @match.save
        # destroying first record in schedule for displaying current match in view
        @thisround = Round.last
        @thisround.schedule.shift
        @thisround.save
        @team_one = @match.team_ids.first
        @team_two = @match.team_ids.last
        @player_one_id = Team.find(@team_one).players.first.id
        @player_two_id = Team.find(@team_one).players.last.id
        @player_three_id = Team.find(@team_two).players.first.id
        @player_four_id = Team.find(@team_two).players.last.id
  
        @team_one_wins = 0
        @team_one_losses = 0
        @team_one_ties = 0
        @team_one_goals_for = @match.home
        @team_one_goals_against = @match.away
        
        @team_two_wins = 0
        @team_two_losses = 0
        @team_two_ties = 0
        @team_two_goals_for = @match.away
        @team_two_goals_against = @match.home
  
        @match_balance = 0
        
        
        
        if @match.home > @match.away
          @team_one_wins = 1
          @team_two_losses = 1
          @goal_difference = @match.home - @match.away
        end
        if @match.home < @match.away
          @team_one_losses = 1 
          @team_two_wins = 1
          @goal_difference = @match.away - @match.home

        end
        if @match.home == @match.away
          @team_one_ties = 1    
          @team_two_ties = 1
          @goal_difference = 0
        end
        if @goal_difference > 0
          @match_balance = (@goal_difference.fdiv(2).round(0) * 20)
        end
        if @match.bet == 1
          @match_balance += 20
        end
        
        
        
        @statistic_player_one_all_time = StatisticAllTime.where("player_id = #{@player_one_id}").last
        @statistic_player_two_all_time = StatisticAllTime.where("player_id = #{@player_two_id}").last
        @statistic_player_three_all_time = StatisticAllTime.where("player_id = #{@player_three_id}").last
        @statistic_player_four_all_time = StatisticAllTime.where("player_id = #{@player_four_id}").last
        
        @statistic_player_one_last_time = StatisticLastTime.where("player_id = #{@player_one_id}").last
        @statistic_player_two_last_time = StatisticLastTime.where("player_id = #{@player_two_id}").last
        @statistic_player_three_last_time = StatisticLastTime.where("player_id = #{@player_three_id}").last
        @statistic_player_four_last_time = StatisticLastTime.where("player_id = #{@player_four_id}").last
        
        @statistic_player_one_last_season = StatisticLastSeason.where("player_id = #{@player_one_id}").last
        @statistic_player_two_last_season = StatisticLastSeason.where("player_id = #{@player_two_id}").last
        @statistic_player_three_last_season = StatisticLastSeason.where("player_id = #{@player_three_id}").last
        @statistic_player_four_last_season = StatisticLastSeason.where("player_id = #{@player_four_id}").last
   
        if @statistic_player_one_all_time == nil
          @statistic_player_one_all_time = StatisticAllTime.create(player_id: @player_one_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_two_all_time == nil
          @statistic_player_two_all_time = StatisticAllTime.create(player_id: @player_two_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_three_all_time == nil
          @statistic_player_three_all_time = StatisticAllTime.create(player_id: @player_three_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_four_all_time == nil
          @statistic_player_four_all_time = StatisticAllTime.create(player_id: @player_four_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        
        if @statistic_player_one_last_time == nil || (@statistic_player_one_last_time.created_at + 16.hours) < Time.now 
          @statistic_player_one_last_time = StatisticLastTime.create(player_id: @player_one_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_two_last_time == nil || (@statistic_player_two_last_time.created_at + 16.hours) < Time.now 
          @statistic_player_two_last_time = StatisticLastTime.create(player_id: @player_two_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_three_last_time == nil || (@statistic_player_three_last_time.created_at + 16.hours) < Time.now 
          @statistic_player_three_last_time = StatisticLastTime.create(player_id: @player_three_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_four_last_time == nil || (@statistic_player_four_last_time.created_at + 16.hours) < Time.now 
          @statistic_player_four_last_time = StatisticLastTime.create(player_id: @player_four_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        
        if @statistic_player_one_last_season == nil || (@statistic_player_one_last_season.created_at + 365.days) < Time.now 
          @statistic_player_one_last_season = StatisticLastSeason.create(player_id: @player_one_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_two_last_season == nil || (@statistic_player_two_last_season.created_at + 365.days) < Time.now 
          @statistic_player_two_last_season = StatisticLastSeason.create(player_id: @player_two_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_three_last_season == nil || (@statistic_player_three_last_season.created_at + 365.days) < Time.now 
          @statistic_player_three_last_season = StatisticLastSeason.create(player_id: @player_three_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        if @statistic_player_four_last_season == nil || (@statistic_player_four_last_season.created_at + 365.days) < Time.now 
          @statistic_player_four_last_season = StatisticLastSeason.create(player_id: @player_four_id, wins: 0, losses: 0, ties: 0, goals_for: 0, goals_against: 0, win_streak: 0, lose_streak: 0, tie_streak: 0, balance: 0)
        end
        
        
        @statistic_player_one_all_time = StatisticAllTime.where("player_id = #{@player_one_id}").last
        @statistic_player_two_all_time = StatisticAllTime.where("player_id = #{@player_two_id}").last
        @statistic_player_three_all_time = StatisticAllTime.where("player_id = #{@player_three_id}").last
        @statistic_player_four_all_time = StatisticAllTime.where("player_id = #{@player_four_id}").last
        
        @statistic_player_one_last_time = StatisticLastTime.where("player_id = #{@player_one_id}").last
        @statistic_player_two_last_time = StatisticLastTime.where("player_id = #{@player_two_id}").last
        @statistic_player_three_last_time = StatisticLastTime.where("player_id = #{@player_three_id}").last
        @statistic_player_four_last_time = StatisticLastTime.where("player_id = #{@player_four_id}").last
        
        @statistic_player_one_last_season = StatisticLastSeason.where("player_id = #{@player_one_id}").last
        @statistic_player_two_last_season = StatisticLastSeason.where("player_id = #{@player_two_id}").last
        @statistic_player_three_last_season = StatisticLastSeason.where("player_id = #{@player_three_id}").last
        @statistic_player_four_last_season = StatisticLastSeason.where("player_id = #{@player_four_id}").last
        
        #this part is saving stats-table pre-match for sending info to event 
        @players = Player.all
        @all_time_players = []
        @last_time_players = []
        @last_season_players = []
        @players.each do |player|
          if player.statistic_all_times.any?
            @all_time_players.push({"player" => player, "player_balance" => player.statistic_all_times.last.balance})
          end
          if player.statistic_last_times.any?
            @last_time_players.push({"player" => player, "player_balance" => player.statistic_last_times.last.balance})
          end
          if player.statistic_last_seasons.any?
            @last_season_players.push({"player" => player, "player_balance" => player.statistic_last_seasons.last.balance})
          end
        end
        @all_time_players_sorted = @all_time_players.sort_by { |k| k["player_balance"] }.reverse
        @last_time_players_sorted = @last_time_players.sort_by { |k| k["player_balance"] }.reverse
        @last_season_players_sorted = @last_season_players.sort_by { |k| k["player_balance"] }.reverse
        
        #<-----

        
      if @team_one_wins > 0
        
        @statistic_player_one_all_time.update_attributes(wins: @statistic_player_one_all_time.wins + @team_one_wins, losses: @statistic_player_one_all_time.losses + @team_one_losses, ties: @statistic_player_one_all_time.ties + @team_one_ties, goals_for: @statistic_player_one_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_all_time.goals_against + @team_one_goals_against, win_streak: @statistic_player_one_all_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_one_all_time.balance + @match_balance)
        @statistic_player_two_all_time.update_attributes(wins: @statistic_player_two_all_time.wins + @team_one_wins, losses: @statistic_player_two_all_time.losses + @team_one_losses, ties: @statistic_player_two_all_time.ties + @team_one_ties, goals_for: @statistic_player_two_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_all_time.goals_against + @team_one_goals_against, win_streak: @statistic_player_two_all_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_two_all_time.balance + @match_balance)
        @statistic_player_three_all_time.update_attributes(wins: @statistic_player_three_all_time.wins + @team_two_wins, losses: @statistic_player_three_all_time.losses + @team_two_losses, ties: @statistic_player_three_all_time.ties + @team_two_ties, goals_for: @statistic_player_three_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_all_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_three_all_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_three_all_time.balance - @match_balance)
        @statistic_player_four_all_time.update_attributes(wins: @statistic_player_four_all_time.wins + @team_two_wins, losses: @statistic_player_four_all_time.losses + @team_two_losses, ties: @statistic_player_four_all_time.ties + @team_two_ties, goals_for: @statistic_player_four_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_all_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_four_all_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_four_all_time.balance - @match_balance)
        
        @statistic_player_one_last_time.update_attributes(wins: @statistic_player_one_last_time.wins + @team_one_wins, losses: @statistic_player_one_last_time.losses + @team_one_losses, ties: @statistic_player_one_last_time.ties + @team_one_ties, goals_for: @statistic_player_one_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_time.goals_against + @team_one_goals_against, win_streak: @statistic_player_one_last_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_one_last_time.balance + @match_balance)
        @statistic_player_two_last_time.update_attributes(wins: @statistic_player_two_last_time.wins + @team_one_wins, losses: @statistic_player_two_last_time.losses + @team_one_losses, ties: @statistic_player_two_last_time.ties + @team_one_ties, goals_for: @statistic_player_two_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_time.goals_against + @team_one_goals_against, win_streak: @statistic_player_two_last_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_two_last_time.balance + @match_balance)
        @statistic_player_three_last_time.update_attributes(wins: @statistic_player_three_last_time.wins + @team_two_wins, losses: @statistic_player_three_last_time.losses + @team_two_losses, ties: @statistic_player_three_last_time.ties + @team_two_ties, goals_for: @statistic_player_three_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_three_last_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_three_last_time.balance - @match_balance)
        @statistic_player_four_last_time.update_attributes(wins: @statistic_player_four_last_time.wins + @team_two_wins, losses: @statistic_player_four_last_time.losses + @team_two_losses, ties: @statistic_player_four_last_time.ties + @team_two_ties, goals_for: @statistic_player_four_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_four_last_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_four_last_time.balance - @match_balance)
        
        @statistic_player_one_last_season.update_attributes(wins: @statistic_player_one_last_season.wins + @team_one_wins, losses: @statistic_player_one_last_season.losses + @team_one_losses, ties: @statistic_player_one_last_season.ties + @team_one_ties, goals_for: @statistic_player_one_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_season.goals_against + @team_one_goals_against, win_streak: @statistic_player_one_last_season.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_one_last_season.balance + @match_balance)
        @statistic_player_two_last_season.update_attributes(wins: @statistic_player_two_last_season.wins + @team_one_wins, losses: @statistic_player_two_last_season.losses + @team_one_losses, ties: @statistic_player_two_last_season.ties + @team_one_ties, goals_for: @statistic_player_two_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_season.goals_against + @team_one_goals_against, win_streak: @statistic_player_two_last_season.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_two_last_season.balance + @match_balance)
        @statistic_player_three_last_season.update_attributes(wins: @statistic_player_three_last_season.wins + @team_two_wins, losses: @statistic_player_three_last_season.losses + @team_two_losses, ties: @statistic_player_three_last_season.ties + @team_two_ties, goals_for: @statistic_player_three_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_season.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_three_last_season.lose_streak + 1, tie_streak: 0, balance: @statistic_player_three_last_season.balance - @match_balance)
        @statistic_player_four_last_season.update_attributes(wins: @statistic_player_four_last_season.wins + @team_two_wins, losses: @statistic_player_four_last_season.losses + @team_two_losses, ties: @statistic_player_four_last_season.ties + @team_two_ties, goals_for: @statistic_player_four_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_season.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: @statistic_player_four_last_season.lose_streak + 1, tie_streak: 0, balance: @statistic_player_four_last_season.balance - @match_balance)
     
      end
      if @team_one_losses > 0
        
        @statistic_player_one_all_time.update_attributes(wins: @statistic_player_one_all_time.wins + @team_one_wins, losses: @statistic_player_one_all_time.losses + @team_one_losses, ties: @statistic_player_one_all_time.ties + @team_one_ties, goals_for: @statistic_player_one_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_all_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_one_all_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_one_all_time.balance - @match_balance)
        @statistic_player_two_all_time.update_attributes(wins: @statistic_player_two_all_time.wins + @team_one_wins, losses: @statistic_player_two_all_time.losses + @team_one_losses, ties: @statistic_player_two_all_time.ties + @team_one_ties, goals_for: @statistic_player_two_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_all_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_two_all_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_two_all_time.balance - @match_balance)
        @statistic_player_three_all_time.update_attributes(wins: @statistic_player_three_all_time.wins + @team_two_wins, losses: @statistic_player_three_all_time.losses + @team_two_losses, ties: @statistic_player_three_all_time.ties + @team_two_ties, goals_for: @statistic_player_three_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_all_time.goals_against + @team_two_goals_against, win_streak: @statistic_player_three_all_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_three_all_time.balance + @match_balance)
        @statistic_player_four_all_time.update_attributes(wins: @statistic_player_four_all_time.wins + @team_two_wins, losses: @statistic_player_four_all_time.losses + @team_two_losses, ties: @statistic_player_four_all_time.ties + @team_two_ties, goals_for: @statistic_player_four_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_all_time.goals_against + @team_two_goals_against, win_streak: @statistic_player_four_all_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_four_all_time.balance + @match_balance)
      
        @statistic_player_one_last_time.update_attributes(wins: @statistic_player_one_last_time.wins + @team_one_wins, losses: @statistic_player_one_last_time.losses + @team_one_losses, ties: @statistic_player_one_last_time.ties + @team_one_ties, goals_for: @statistic_player_one_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_one_last_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_one_last_time.balance - @match_balance)
        @statistic_player_two_last_time.update_attributes(wins: @statistic_player_two_last_time.wins + @team_one_wins, losses: @statistic_player_two_last_time.losses + @team_one_losses, ties: @statistic_player_two_last_time.ties + @team_one_ties, goals_for: @statistic_player_two_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_two_last_time.lose_streak + 1, tie_streak: 0, balance: @statistic_player_two_last_time.balance - @match_balance)
        @statistic_player_three_last_time.update_attributes(wins: @statistic_player_three_last_time.wins + @team_two_wins, losses: @statistic_player_three_last_time.losses + @team_two_losses, ties: @statistic_player_three_last_time.ties + @team_two_ties, goals_for: @statistic_player_three_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_time.goals_against + @team_two_goals_against, win_streak: @statistic_player_three_last_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_three_last_time.balance + @match_balance)
        @statistic_player_four_last_time.update_attributes(wins: @statistic_player_four_last_time.wins + @team_two_wins, losses: @statistic_player_four_last_time.losses + @team_two_losses, ties: @statistic_player_four_last_time.ties + @team_two_ties, goals_for: @statistic_player_four_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_time.goals_against + @team_two_goals_against, win_streak: @statistic_player_four_last_time.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_four_last_time.balance + @match_balance)
        
        @statistic_player_one_last_season.update_attributes(wins: @statistic_player_one_last_season.wins + @team_one_wins, losses: @statistic_player_one_last_season.losses + @team_one_losses, ties: @statistic_player_one_last_season.ties + @team_one_ties, goals_for: @statistic_player_one_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_season.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_one_last_season.lose_streak + 1, tie_streak: 0, balance: @statistic_player_one_last_season.balance - @match_balance)
        @statistic_player_two_last_season.update_attributes(wins: @statistic_player_two_last_season.wins + @team_one_wins, losses: @statistic_player_two_last_season.losses + @team_one_losses, ties: @statistic_player_two_last_season.ties + @team_one_ties, goals_for: @statistic_player_two_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_season.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: @statistic_player_two_last_season.lose_streak + 1, tie_streak: 0, balance: @statistic_player_two_last_season.balance - @match_balance)
        @statistic_player_three_last_season.update_attributes(wins: @statistic_player_three_last_season.wins + @team_two_wins, losses: @statistic_player_three_last_season.losses + @team_two_losses, ties: @statistic_player_three_last_season.ties + @team_two_ties, goals_for: @statistic_player_three_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_season.goals_against + @team_two_goals_against, win_streak: @statistic_player_three_last_season.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_three_last_season.balance + @match_balance)
        @statistic_player_four_last_season.update_attributes(wins: @statistic_player_four_last_season.wins + @team_two_wins, losses: @statistic_player_four_last_season.losses + @team_two_losses, ties: @statistic_player_four_last_season.ties + @team_two_ties, goals_for: @statistic_player_four_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_season.goals_against + @team_two_goals_against, win_streak: @statistic_player_four_last_season.win_streak + 1, lose_streak: 0, tie_streak: 0, balance: @statistic_player_four_last_season.balance + @match_balance)
        
      end
      if @team_one_ties > 0
        
        @statistic_player_one_all_time.update_attributes(wins: @statistic_player_one_all_time.wins + @team_one_wins, losses: @statistic_player_one_all_time.losses + @team_one_losses, ties: @statistic_player_one_all_time.ties + @team_one_ties, goals_for: @statistic_player_one_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_all_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_one_all_time.tie_streak + 1)
        @statistic_player_two_all_time.update_attributes(wins: @statistic_player_two_all_time.wins + @team_one_wins, losses: @statistic_player_two_all_time.losses + @team_one_losses, ties: @statistic_player_two_all_time.ties + @team_one_ties, goals_for: @statistic_player_two_all_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_all_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_two_all_time.tie_streak + 1)
        @statistic_player_three_all_time.update_attributes(wins: @statistic_player_three_all_time.wins + @team_two_wins, losses: @statistic_player_three_all_time.losses + @team_two_losses, ties: @statistic_player_three_all_time.ties + @team_two_ties, goals_for: @statistic_player_three_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_all_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_three_all_time.tie_streak + 1)
        @statistic_player_four_all_time.update_attributes(wins: @statistic_player_four_all_time.wins + @team_two_wins, losses: @statistic_player_four_all_time.losses + @team_two_losses, ties: @statistic_player_four_all_time.ties + @team_two_ties, goals_for: @statistic_player_four_all_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_all_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_four_all_time.tie_streak + 1)
     
        @statistic_player_one_last_time.update_attributes(wins: @statistic_player_one_last_time.wins + @team_one_wins, losses: @statistic_player_one_last_time.losses + @team_one_losses, ties: @statistic_player_one_last_time.ties + @team_one_ties, goals_for: @statistic_player_one_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_one_last_time.tie_streak + 1)
        @statistic_player_two_last_time.update_attributes(wins: @statistic_player_two_last_time.wins + @team_one_wins, losses: @statistic_player_two_last_time.losses + @team_one_losses, ties: @statistic_player_two_last_time.ties + @team_one_ties, goals_for: @statistic_player_two_last_time.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_time.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_two_last_time.tie_streak + 1)
        @statistic_player_three_last_time.update_attributes(wins: @statistic_player_three_last_time.wins + @team_two_wins, losses: @statistic_player_three_last_time.losses + @team_two_losses, ties: @statistic_player_three_last_time.ties + @team_two_ties, goals_for: @statistic_player_three_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_three_last_time.tie_streak + 1)
        @statistic_player_four_last_time.update_attributes(wins: @statistic_player_four_last_time.wins + @team_two_wins, losses: @statistic_player_four_last_time.losses + @team_two_losses, ties: @statistic_player_four_last_time.ties + @team_two_ties, goals_for: @statistic_player_four_last_time.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_time.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_four_last_time.tie_streak + 1)
     
        @statistic_player_one_last_season.update_attributes(wins: @statistic_player_one_last_season.wins + @team_one_wins, losses: @statistic_player_one_last_season.losses + @team_one_losses, ties: @statistic_player_one_last_season.ties + @team_one_ties, goals_for: @statistic_player_one_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_one_last_season.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_one_last_season.tie_streak + 1)
        @statistic_player_two_last_season.update_attributes(wins: @statistic_player_two_last_season.wins + @team_one_wins, losses: @statistic_player_two_last_season.losses + @team_one_losses, ties: @statistic_player_two_last_season.ties + @team_one_ties, goals_for: @statistic_player_two_last_season.goals_for + @team_one_goals_for, goals_against: @statistic_player_two_last_season.goals_against + @team_one_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_two_last_season.tie_streak + 1)
        @statistic_player_three_last_season.update_attributes(wins: @statistic_player_three_last_season.wins + @team_two_wins, losses: @statistic_player_three_last_season.losses + @team_two_losses, ties: @statistic_player_three_last_season.ties + @team_two_ties, goals_for: @statistic_player_three_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_three_last_season.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_three_last_season.tie_streak + 1)
        @statistic_player_four_last_season.update_attributes(wins: @statistic_player_four_last_season.wins + @team_two_wins, losses: @statistic_player_four_last_season.losses + @team_two_losses, ties: @statistic_player_four_last_season.ties + @team_two_ties, goals_for: @statistic_player_four_last_season.goals_for + @team_two_goals_for, goals_against: @statistic_player_four_last_season.goals_against + @team_two_goals_against, win_streak: 0, lose_streak: 0, tie_streak: @statistic_player_four_last_season.tie_streak + 1)
     
      end    
    respond_with @match, location: create_event(@match, @all_time_players_sorted, @last_season_players_sorted, @last_time_players_sorted)
    end
  end
  
  
  def create_event(match, all_time_players, last_season_players, last_time_players)
    @players = Player.all
    @last_time_players_ajax = []
    @players.each do |player|
      if player.statistic_last_times.any?
        if (player.statistic_last_times.last.created_at + 1.day) > StatisticLastTime.last.created_at
          @last_time_players_ajax.push({"player" => player, "player_stats" => player.statistic_last_times.last, "player_balance" => player.statistic_last_times.last.balance})
        end
      end
    end
    @last_time_players_sorted_ajax = @last_time_players_ajax.sort_by { |k| k["player_balance"] }.reverse
    @event = Event.new
    @event.update_attributes(:match_id => match.id)
    @event_message = Event.create_message(match)
    @event_table_changes = Event.table_changes(all_time_players, last_season_players, last_time_players)
    @event.update_attributes(:message => @event_message)
    @event.update_attributes(:table_changes => @event_table_changes)
    @event.save!
    respond_to do |format|
      format.js { render :action => "create_event" } and return 
    end
  end
  

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:home, :bet, :away, team_ids: [])
    end
end
