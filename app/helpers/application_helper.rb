module ApplicationHelper



  def players
    @players = Player.all
  end
  def teams
    @teams = Team.all
  end
  def matches
    @matches = Match.all
  end

  def home
    @home = Team.find(@team_one).name
  end

  def away
    @away = Team.find(@team_two).name
  end
  
  def home_players
    @home_players = []
    Team.find(@team_one).players.each do |player|
      @home_players.push(player.name)
    end
    return @home_players
  end

  def away_players
    @away_players = []
    Team.find(@team_two).players.each do |player|
      @away_players.push(player.name)
    end
    return @away_players
  end
  
  def random_team
    @playing_teams = ["Argentina", "Belgien", "Brasilien", "Colombia", "England", "Frankrike", "Italien", "Nederländerna", "Portugal", "Spanien", "Tyskland", "Sverige", "CSKA Moskva", "Atlético Madrid", "FC Barcelona", "Real Madrid", "Sevilla FC", "FC Bayern", "FC Schalke", "Liverpool", "Manchester City", "Manchester United", "Bor Dortmund", "Spurs", "Arsenal", "Chelsea", "PSG", "Juventus", "Napoli", "Roma"]
    return @playing_teams.sample
  end

  def sessions
    if session[:player_id]
      @label= 'Logout'
      @path = link_to @label, logout_path, method: :delete, class: 'button alert radius expand'
    else
      @label= 'Login'
      @path = link_to @label, login_path, class: 'button success radius expand'
    end
      end
    end

