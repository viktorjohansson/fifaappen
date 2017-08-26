class Match < ActiveRecord::Base
  has_many :games
  has_many :teams, :through => :games
  has_many :participants
  has_many :rounds, :through => :participants
  has_many :events

  validates :home, :away, presence: true

  def wins(team)
      if teams[0] == team
        if home > away
          @wins = 1
        else
          @wins = 0
        end
      else
        if away > home
          @wins = 1
        else
          @wins = 0
        end
      end
  end

  def losses(team)
      if teams[0] == team
        if home >= away
          @losses = 0
        else
          @losses = 1
        end
      else
        if away >= home
          @losses = 0
        else
          @losses = 1
        end
      end
  end

  def ties(team)
    if home == away
      @ties = 1
    else
      @ties = 0
    end
  end

  def goals_for(team)
    if teams[0] == team
      @goals_for = home
    else
      @goals_for = away
    end
  end

  def goals_against(team)
    if teams[0] == team
      @goals_against = away
    else
      @goal_against = home
    end
  end

  def goal_difference(team)
      if teams[0] == team
        @goal_difference = home - away
      else
        @goal_difference = away - home
      end
  end

  def highscore_goals_for(team)
    if teams[0] == team
      @highscore_goals_for = home
    else
      @highscore_goals_for = away
    end
  end

  def last_gameday
    
  end


end
