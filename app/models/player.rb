class Player < ActiveRecord::Base
  has_many :connections
  has_many :teams, :through => :connections
  has_many :participants
  has_many :rounds, :through => :participants
  has_many :achievements
  has_many :statistic_all_times
  has_many :statistic_last_times
  has_many :statistic_last_seasons
  

  validates :name, uniqueness: true
  has_secure_password



  def streak
    @streak = []
    @win_streak = []
    @lose_streak = []
    @draw_streak = []
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      @teamhome = false
      if m.home != m.away
        self.teams.each do |t|
            if m.teams[0] == t
              @teamhome = true
            end
            end
            if @teamhome
              if m.home > m.away
              @win_streak.push(1)
              @lose_streak = []
              @draw_streak = []
              else
                @win_streak = []
                @lose_streak.push(1)
                @draw_streak = []
              end
            else
              if m.away > m.home
                @win_streak.push(1)
                @lose_streak = []
                @draw_streak = []
              else
                @win_streak = []
                @lose_streak.push(1)
                @draw_streak = []
              end
            end
            else
            @draw_streak.push(1)
            @lose_streak = []
            @win_streak = []
        end
      end
    if @win_streak.length > @lose_streak.length + @draw_streak.length
      @streak.push("Won", @win_streak.inject(:+))
    else
      if @lose_streak.length > @win_streak.length + @draw_streak.length
        @streak.push("Lost", @lose_streak.inject(:+))
      else
        @streak.push("Tied", @draw_streak.inject(:+))
      end
    end
    return @streak
  end


  def award(achievement)
    achievements << achievement.new
  end



  def matches
    @matches = []
    self.teams.each do |t|
       t.matches.each do |m|
         @matches.push(m)
      end
    end
    return @matches
  end

  def sorted_matches
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
  end

  def goals_scored_record
    @goals_scored = [0]
    self.matches.each do |m|
      @teamhome = false
        self.teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
          end
          if @teamhome
             @goals_scored.push(m.home)
          else
            @goals_scored.push(m.away)
          end
    end
    return @goals_scored.max
  end

  def streak_record
      @win_streak = [0]
      @win_streak_record = [0]
      @player_games = []
      teams.each do |team|
        team.matches.each do |match|
          @player_games.push(match)
        end
      end
      @sorted_player_games = @player_games.sort_by &:created_at
      @sorted_player_games.each do |m|
        @teamhome = false
        if m.home != m.away
          self.teams.each do |t|
            if m.teams[0] == t
              @teamhome = true
            end
          end
          if @teamhome
            if m.home > m.away
              @win_streak.push(1)
            else
              @win_streak_record.push(@win_streak.length)
              @win_streak = [0]
            end
          else
            if m.away > m.home
              @win_streak.push(1)
            else
              @win_streak_record.push(@win_streak.length)
              @win_streak = [0]
            end
          end
        else
          @win_streak_record.push(@win_streak.length)
          @win_streak = [0]
        end
      end
      return @win_streak_record.max
    end

  def clean_sheet_record
    @clean_sheet_streak = [0]
    @clean_sheet_streak_record = [0]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      @teamhome = false
        self.teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
        if @teamhome
          if m.away == 0
            @clean_sheet_streak.push(1)
          else
            @clean_sheet_streak_record.push(@clean_sheet_streak.length)
            @clean_sheet_streak = [0]
          end
        else
          if m.home == 0
            @clean_sheet_streak.push(1)
          else
            @clean_sheet_streak_record.push(@clean_sheet_streak.length)
            @clean_sheet_streak = [0]
          end
        end
    end
    return @clean_sheet_streak_record.max
  end

  def score_in_five_games
    @score = [0]
    @score_record = [0]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @score.count == 5
        @score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @score.push(m.home)
        else
          @score.push(m.away)
      end
      @score_record.push(@score.inject(:+))
    end
    return @score_record.max
    end

  def score_streak
    @score = [0]
    @score_record = [0]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @score.count == 11
        @score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        if m.home > 0
          @score.push(1)
        else
          @score_record.push(@score.inject(:+))
          @score = [0]
        end
      else
        if m.away > 0
        @score.push(1)
        else
          @score_record.push(@score.inject(:+))
          @score = [0]
        end
      end
    end
    return @score_record.max
  end


  def balance_over_500
    @goal_difference = [0]
    @player_games = []
    @balance = []
    @return = false
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
         @goals = m.home - m.away
      else
        @goals = m.away - m.home
      end
      if @goals != 0
        if @goals > 0
          @cash = 1
          if @goals > 2
            @cash = @goals.fdiv(2).round(0)
          else
          end
        else
          @cash = -1
          if @goals < -2
            @cash = @goals / 2
          else
          end
        end
      else
        @cash = 0
      end
      if m.bet == 1
        if @cash > 0
          @cash += 1
        end
        if @cash < 0
          @cash -= 1
        end
      end
      @balance.push(@cash)
      if @balance.inject(:+) * 20 > 500
        @return = true
      end
    end
    return @return
  end

  def win_against_record
    @players_won_against = [0]
    @player_games = []
    self.matches.each do |m|
      @teamhome = false
      teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        if m.home - m.away > 4
          @players_won_against.push(m.teams[1].players.first.name, m.teams[1].players.last.name)
        end
      else
       if m.away - m.home > 4
         @players_won_against.push(m.teams[0].players.first.name, m.teams[1].players.last.name)
       end
      end
    end
    return @players_won_against.uniq.length
  end

  def huge_double_win
    @player_games = []
    @huge_win = false
    self.matches.each do |m|
      @teamhome = false
      teams.each do |t|
        if m.bet == 1
          if m.teams[0] == t
            @teamhome = true
          end
          if @teamhome
            if m.home - m.away > 4
              @huge_win = true
            end
          else
            if m.away - m.home > 4
              @huge_win = true
            end
          end
      end
      end
    end
    return @huge_win
  end


  def double_games_record
    @double_games_record = [0]
    self.matches.each do |m|
        if m.bet == 1
          @double_games_record.push(1)
        end
    end
    return @double_games_record.inject(:+)
  end


  def games_by_night
    @won_25 = false
    @player_games = []
    @wins = [0]
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.created_at > @last_created_at + 12.hours
        @wins = [0]
      end
      @last_created_at = m.created_at
      @teamhome = false
      teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        if m.home > m.away
          @wins.push(1)
        end
      else
        if m.away > m.home
          @wins.push(1)
        end
      end
      if @wins.inject(:+) > 24
        @won_25 = true
      end
    end
    return @won_25
  end

  def gold_night
      @balance_200 = false
      @player_games = []
      @goal_difference = [0]
      @player_games = []
      @balance = []
      @last_created_at = matches.first.created_at
      teams.each do |team|
        team.matches.each do |match|
          @player_games.push(match)
        end
      end
      @sorted_player_games = @player_games.sort_by &:created_at
      @sorted_player_games.each do |m|
        if m.created_at > @last_created_at + 12.hours
          if @balance.inject(:+) * 20 > 199
            @balance_200 = true
          end
          @balance = []
        end
        @last_created_at = m.created_at
        @teamhome = false
        self.teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
        if @teamhome
          @goals = m.home - m.away
        else
          @goals = m.away - m.home
        end
        if @goals != 0
          if @goals > 0
            @cash = 1
            if @goals > 2
              @cash = @goals.fdiv(2).round(0)
            else
            end
          else
            @cash = -1
            if @goals < -2
              @cash = @goals / 2
            else
            end
          end
        else
          @cash = 0
        end
        if m.bet == 1
          if @cash > 0
            @cash += 1
          end
          if @cash < 0
            @cash -= 1
          end
        end
        @balance.push(@cash)
        end
      return @balance_200
  end

  def game_nights_month_record
    @game_night = [0]
    @player_games = []
    @last_created_at = matches.first.created_at
    sorted_matches.each do |m|
      if m.created_at > @last_created_at + 12.hours
        @game_night.push(m.created_at.year.to_s + m.created_at.month.to_s)
      end
      @last_created_at = m.created_at
    end
    return @game_night.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }.sort_by(&:last).reverse.first[1]
  end


  def game_nights_week_record
    @week_night = [0]
    @last_created_at = matches.first.created_at
    sorted_matches.each do |m|
      if m.created_at > @last_created_at + 12.hours
        @week_night.push((m.created_at.strftime('%U').to_s))
      end
      @last_created_at = m.created_at
    end
    return @week_night.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }.sort_by(&:last).reverse.first[1]
  end

  def double_games_by_night
    @won_3_double = false
    @player_games = []
    @double_wins = [0]
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.bet == 1
        if m.created_at > @last_created_at + 12.hours
          @double_wins = [0]
        end
        @last_created_at = m.created_at
        @teamhome = false
        teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
          if @teamhome
            if m.home > m.away
              @double_wins.push(1)
            end
          else
            if m.away > m.home
              @double_wins.push(1)
            end
          end
          if @double_wins.inject(:+) > 2
            @won_3_double = true
          end
      end
    end
    return @won_3_double
  end

  def big_score_by_night
    @won_3_big = false
    @player_games = []
    @big_wins = [0]
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
        if m.created_at > @last_created_at + 12.hours
          @big_wins = [0]
        end
        @last_created_at = m.created_at
        @teamhome = false
        teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
        if @teamhome
          if m.home > m.away + 4
            @big_wins.push(1)
          end
        else
          if m.away > m.home + 4
            @big_wins.push(1)
          end
        end
        if @big_wins.inject(:+) > 2
          @won_3_big = true
        end
      end
    return @won_3_big
  end


  def gold_streak
    @balance_100_nights = []
    @player_games = []
    @goal_difference = [0]
    @player_games = []
    @balance = []
    @gold_streak = false
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.created_at > @last_created_at + 12.hours
        if @balance.inject(:+) * 20 > 99
          @balance_100_nights.push(1)
          if @balance_100_nights.length > 2
            @gold_streak = true
          end
        else
          @balance_100_nights = []
        end
        @balance = []

      end
      @last_created_at = m.created_at
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @goals = m.home - m.away
      else
        @goals = m.away - m.home
      end
      if @goals != 0
        if @goals > 0
          @cash = 1
          if @goals > 2
            @cash = @goals.fdiv(2).round(0)
          else
          end
        else
          @cash = -1
          if @goals < -2
            @cash = @goals / 2
          else
          end
        end
      else
        @cash = 0
      end
      if m.bet == 1
        if @cash > 0
          @cash += 1
        end
        if @cash < 0
          @cash -= 1
        end
      end
      @balance.push(@cash)
    end
    return @gold_streak
  end

  def no_score_streak
    @no_score = [0]
    @no_score_record = [10]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @no_score.count == 5
        @no_score_record.push(@no_score.inject(:+))
        @no_score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @no_score.push(m.home)
      else
        @no_score.push(m.away)
      end
    end
    return @no_score_record.min
  end

  def goals_against_record
    @goals_against = [0]
    self.matches.each do |m|
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @goals_against.push(m.away)
      else
        @goals_against.push(m.home)
      end
    end
    return @goals_against.max
  end



  def balance_under_500
    @goal_difference = [0]
    @player_games = []
    @balance = []
    @return = false
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @goals = m.home - m.away
      else
        @goals = m.away - m.home
      end
      if @goals != 0
        if @goals > 0
          @cash = 1
          if @goals > 2
            @cash = @goals.fdiv(2).round(0)
          else
          end
        else
          @cash = -1
          if @goals < -2
            @cash = @goals / 2
          else
          end
        end
      else
        @cash = 0
      end
      if m.bet == 1
        if @cash > 0
          @cash += 1
        end
        if @cash < 0
          @cash -= 1
        end
      end
      @balance.push(@cash)
      if @balance.inject(:+) * 20 < -499
        @return = true
      end
    end
    return @return
  end

  def days_since_last_game
    
    @player_games = []
    @over_90_days = false
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.created_at > @last_created_at + 90.days
        @over_90_days = true
      end
      @last_created_at = m.created_at

    end
    if @last_created_at + 90.days < Time.now
      @over_90_days = true
    end
    return @over_90_days
  end

  def lose_streak_record
    @lose_streak = [0]
    @lose_streak_record = [0]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      @teamhome = false
      if m.home != m.away
        self.teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
        if @teamhome
          if m.home > m.away
            @lose_streak_record.push(@lose_streak.length)
            @lose_streak = [0]
          else
            @lose_streak.push(1)
          end
        else
          if m.away > m.home
            @lose_streak_record.push(@lose_streak.length)
            @lose_streak = [0]
          else
            @lose_streak.push(1)
          end
        end
      else
        @lose_streak_record.push(@lose_streak.length)
        @lose_streak = [0]
      end
    end
    return @lose_streak_record.max
  end

  def charity_night
    @balance_200 = false
    @player_games = []
    @goal_difference = [0]
    @player_games = []
    @balance = []
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.created_at > @last_created_at + 12.hours
        if @balance.inject(:+) * 20 < -199
          @balance_200 = true
        end
        @balance = []
      end
      @last_created_at = m.created_at
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @goals = m.home - m.away
      else
        @goals = m.away - m.home
      end
      if @goals != 0
        if @goals > 0
          @cash = 1
          if @goals > 2
            @cash = @goals.fdiv(2).round(0)
          else
          end
        else
          @cash = -1
          if @goals < -2
            @cash = @goals / 2
          else
          end
        end
      else
        @cash = 0
      end
      if m.bet == 1
        if @cash > 0
          @cash += 1
        end
        if @cash < 0
          @cash -= 1
        end
      end
      @balance.push(@cash)
    end
    return @balance_200
  end

  def lost_double_games_by_night
    @lost_3_double = false
    @player_games = []
    @double_lose = [0]
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.bet == 1
        if m.created_at > @last_created_at + 12.hours
          @double_lose = [0]
        end
        @last_created_at = m.created_at
        @teamhome = false
        teams.each do |t|
          if m.teams[0] == t
            @teamhome = true
          end
        end
        if @teamhome
          if m.home < m.away
            @double_lose.push(1)
          end
        else
          if m.away < m.home
            @double_lose.push(1)
          end
        end
        if @double_lose.inject(:+) > 2
          @lost_3_double = true
        end
      end
    end
    return @lost_3_double
  end

  def huge_double_lose
    @player_games = []
    @huge_lose = false
    self.matches.each do |m|
      @teamhome = false
      teams.each do |t|
        if m.bet == 1
          if m.teams[0] == t
            @teamhome = true
          end
          if @teamhome
            if m.away - m.home > 4
              @huge_lose = true
            end
          else
            if m.home - m.away > 4
              @huge_lose = true
            end
          end
        end
      end
    end
    return @huge_lose
  end

  def games_per_night
    @games_per_night = []
    @games_per_night_record = []
    @player_games = []
    @last_created_at = matches.first.created_at
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if m.created_at > @last_created_at + 12.hours
        @games_per_night_record.push(@games_per_night.inject(:+))
        @games_per_night = []
      end
      @last_created_at = m.created_at
      @games_per_night.push(1)
    end
    return @games_per_night_record.min
  end

  def lowest_score_in_15_games
    @score = [0]
    @score_record = []
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    if @sorted_player_games.count < 15
      return 15
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @score.count == 15
        @score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @score.push(m.home)
      else
        @score.push(m.away)
      end
      @score_record.push(@score.inject(:+))
    end
    return @score_record.min
  end


  def against_score_in_10_games
    @score = [0]
    @score_record = []
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @score.count == 10
        @score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        @score.push(m.away)
      else
        @score.push(m.home)
      end
      @score_record.push(@score.inject(:+))
    end
    return @score_record.max
  end


  def against_score_streak
    @score = [0]
    @score_record = [0]
    @player_games = []
    teams.each do |team|
      team.matches.each do |match|
        @player_games.push(match)
      end
    end
    @sorted_player_games = @player_games.sort_by &:created_at
    @sorted_player_games.each do |m|
      if @score.count == 11
        @score.shift
      end
      @teamhome = false
      self.teams.each do |t|
        if m.teams[0] == t
          @teamhome = true
        end
      end
      if @teamhome
        if m.away > 0
          @score.push(1)
        else
          @score_record.push(@score.inject(:+))
          @score = [0]
        end
      else
        if m.home > 0
          @score.push(1)
        else
          @score_record.push(@score.inject(:+))
          @score = [0]
        end
      end
    end
    return @score_record.max
  end


end


