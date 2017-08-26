class Team < ActiveRecord::Base
  has_many :connections
  has_many :players, :through => :connections
  has_many :games
  has_many :matches, :through => :games

  validates :name, presence: true
  validates :name, uniqueness: true



  def streak
    @streak = []
    @win_streak = []
    @lose_streak = []
    @draw_streak = []
    @sorted_matches = self.matches.sort_by &:created_at
    @sorted_matches.each do |m|
      if m.home != m.away
        if m.teams[0] == self
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

  def last_day
    return Match.where("created_at" => ((Match.last.created_at - 12.hour)..Time.now.midnight)).joins(:teams).where("id" => self.id)
  end
end