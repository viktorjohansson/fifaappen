class Event < ActiveRecord::Base
  
  def self.create_message(match)
    @match = match
    @message_array = ["Jerka har nu ätit 23 bullens", "Nästa helg räknar Nygge med sexuellt umgänge", "Välkomna nästa helg till Bennies hundutställning", "Larry har tydligen köpt ny bil, någon sportbil...", "I förrgår såg jag Peter Nygren leta pantflaskor, undra varför?", "Det är något fel på algoritmen...", "Ska vi prova något annat spel, vad sägs om The Sims?", "Hästar är verkligen fina att titta på!", "Lastbilar!!!!!!", "Jerka, stäng munnen!", "FIFA ringde, dom undrar om spelaren Peter Nygren är en hamster?", "Jerka tycker vi borde ha FIFA-kvällar oftare, han gillar bullens", "Danne kunde inte komma idag, han är i big city!", "Det är snålt med dubbelmatcher ikväll, fegisar!", "Nu gick solen upp, nää det var Danne som öppnade munnen", "På 3 timmar hinner man springa ett maraton, eller få 1st avsugning", "Jerka vill spela nästa helg, nää bara skojar, han ska toffla", "Alle är en toffel"]
    @message = @message_array.sample
    @team_one = match.team_ids.first
    @team_two = match.team_ids.last
    @player_one = Team.find(@team_one).players.first
    @player_two = Team.find(@team_one).players.last
    @player_three = Team.find(@team_two).players.first
    @player_four = Team.find(@team_two).players.last
    @players_array = [@player_one, @player_two, @player_three, @player_four]
    @team_one_goals_for = match.home
    @team_one_goals_against = match.away
    @team_two_goals_for = match.away
    @team_two_goals_against = match.home
    @match_balance = 0
    @winning_team = 0
    @goal_difference = 0
    @winning_players = []
    @loosing_players = []
    
    # 20% chance for 0..4, for function and for method inside function
    @random_int_function = rand(5)
    @random_int_method = rand(5)
    @random_player = @players_array.sample
    
    if @match.home > @match.away
      @winning_team = @team_one
      @winning_players = [@player_one, @player_two] 
      @loosing_players = [@player_three, @player_four]
      @goal_difference = @match.home - @match.away
    end
    
    if @match.home < @match.away
      @winning_team = @team_two
      @winning_players = [@player_three, @player_four] 
      @loosing_players = [@player_one, @player_two]
      @goal_difference = @match.away - @match.home
    end
    
    if @goal_difference > 0
      @match_balance = (@goal_difference.fdiv(2).round(0) * 20)
    end
    
    if @match.bet == 1
      @match_balance += 20
    end
    
    # random info
    if @random_int_function == 0
      case @random_int_method
        when 0
          @message = @random_player.name.to_s + " har totalt vunnit " + @random_player.statistic_all_times.last.wins.to_s + " matcher"
        when 1
          @message = @random_player.name.to_s + " har totalt förlorat " + @random_player.statistic_all_times.last.losses.to_s + " matcher"
        when 2
          @message = @random_player.name.to_s + " har spelat lika " + @random_player.statistic_all_times.last.ties.to_s + " matcher"
        when 3
          @message = @random_player.name.to_s + " har gjort totalt " + @random_player.statistic_all_times.last.goals_for.to_s + " mål"
        when 4
          @message = @random_player.name.to_s + " har släppt in totalt " + @random_player.statistic_all_times.last.goals_against.to_s + " mål"
        else
          @message = ""
      end
    end
    
    # random info
    if @random_int_function == 1 && @winning_team != 0
      case @random_int_method
        when 0
          @message = "Systemet anser att det var " + @loosing_players.sample.name + " fel att dem förlorade"
        when 1
          @message = "Systemet anser att det var " + @winning_players.sample.name + " som såg till att dem vann"
        when 2
          @message = "Systemet anser att " + @loosing_players.sample.name + " borde gå hem nu"
        when 3
          @message = "Systemet anser att " + @winning_players.sample.name + " hade tur under denna match"
        when 4
          @message = "Systemet anser att " + @loosing_players.sample.name + " hade otur under denna match"
        else
          @message = ""
      end
    end
     
    # random info 
    if @random_int_function == 2
      case @random_int_method
        when 0
          @message = "Systemet undrar vad " + @random_player.name + " jobbar med?"
        when 1
          @message = "Systemet undrar om " + @random_player.name + " gillar daimkryss?"
        when 2
          @message = "Systemet undrar hur många bullens " + @random_player.name + " har ätit?"
        when 3
          @message = "Systemet undrar om sällskapet vill att " + @random_player.name + " ska åka hem?"
        when 4
          @message = "Systemet undrar om " + @random_player.name + " är nöjd med sin insats i matchen?"
        else
          @message = ""
      end
    end
    
    # peter-related
    if @winning_team != 0
      if @winning_players[0].name == "Peter" || @winning_players[1].name == "Peter"
        @message = "Ni förlorade mot Peter"
      end
    end
    
    # goal-related
    if @goal_difference > 2
      case @random_int_method
        when 0 
          @message = "Det här blev en dyr läxa för " + @loosing_players[0].name + " och " + @loosing_players[1].name
        when 1
          @message = "Pengar in för " + @winning_players[0].name + " och " + @winning_players[1].name
        when 2
          @message = @loosing_players[0].name + " och " + @loosing_players[1].name + " borde gå hem nu"
        when 3
          @message = "Pengar ut för " + @loosing_players[0].name + " och " + @loosing_players[1].name
        when 4
          @message = "Lätt vinst tycker " + @winning_players[0].name + " och " + @winning_players[1].name
        else 
          @message = ""
      end
    end
    
    #goal-related
    if @goal_difference > 4
      case @random_int_method
        when 0
          @message = @loosing_players[0].name + " och " + @loosing_players[1].name + " snart ikapp Larrys ekonomi"
        when 1
          @message = @winning_players[0].name + " och " + @winning_players[1].name + " dominerade totalt"
        when 2
          @message = @loosing_players[0].name + " och " + @loosing_players[1].name + " blev totalt slaktade"
        when 3
          @message = @loosing_players[0].name + " och " + @loosing_players[1].name + " borde aldrig mer komma på fifa-kväll!"
        when 4
          @message = @winning_players[0].name + " och " + @winning_players[1].name + " borde inte ens vara nöjda med tanke på motståndet"        
      end
    end
    
    # balance-related
    if @winning_team != 0
      @winning_players.each do |player|
        if player.statistic_last_times.last.balance > 100
          case @random_int_method
            when 0
              @message = player.name + " borde skänka en slant till larry efter idag"
            when 1 
              @message = player.name + " ligger nu " + player.statistic_last_times.last.balance.to_s + " idag"
            when 2
              @message = player.name + " har tur idag"
            when 3
              @message = player.name + " har fickorna fyllda med 20-lappar ikväll!"
            when 4
              @message = player.name + " får passa sig för att bli rånad på vägen hem"
            else 
              @message = ""
          end
        end
      end
    end
    
    #balance-related
    if @loosing_team != 0  
      @loosing_players.each do |player|
        if player.statistic_last_times.last.balance < -100
          case @random_int_method
            when 0 
              @message = player.name + " ligger nu " + player.statistic_last_times.last.balance.to_s + " idag"
            when 1
              @message = "Systemet skäms över " + player.name + " idag"
            when 2
              @message = player.name + ", Systemet undrar om du är nöjd med dig själv?"
            when 3
              @message = "Ingen vill spela med " + player.name + " idag"
            when 4
              @message = player.name + " är inte dina pengar slut snart?"
            else 
              @message = ""
          end
        end
      end
    end
    return @message
  end
  
  
  def self.table_changes(all_time_players, last_season_players, last_time_players)
    @message = "Inga förändringar i tabellen"
    @old_all_time_players = all_time_players
    @old_last_season_players = last_season_players
    @old_last_time_players = last_time_players
    @players = Player.all
    @all_time_players_unsorted = []
    @last_time_players_unsorted = []
    @last_season_players_unsorted = []
    @players.each do |player|
      if player.statistic_all_times.any?
        @all_time_players_unsorted.push({"player" => player, "player_balance" => player.statistic_all_times.last.balance})
      end
      if player.statistic_last_times.any?
        @last_time_players_unsorted.push({"player" => player, "player_balance" => player.statistic_last_times.last.balance})
      end
      if player.statistic_last_seasons.any?
        @last_season_players_unsorted.push({"player" => player, "player_balance" => player.statistic_last_seasons.last.balance})
      end
    end
    @all_time_players = @all_time_players_unsorted.sort_by { |k| k["player_balance"] }.reverse
    @last_time_players = @last_time_players_unsorted.sort_by { |k| k["player_balance"] }.reverse
    @last_season_players = @last_season_players_unsorted.sort_by { |k| k["player_balance"] }.reverse
    @all_time_players_index = []
    @old_all_time_players.each_with_index do |player, index|
      @all_time_players_index.push([player["player"].name, (index + 1)])
    end
    @all_time_players_changed_index = []
    @all_time_players_changed_index2 = []
    @all_time_players_new_index = []
    if @winning_team != 0 
    @all_time_players.each_with_index do |player, index|
      @players_new_index = (index + 1)
      @all_time_players_index.each do |oldplayer|
        if player["player"].name == oldplayer[0]
          @players_old_index = oldplayer[1]
          @player_name = oldplayer[0]
          if (@player_name == player["player"].name) && (@player_name == @winning_players[0].name)
            @players_past = []
            @players_past_count = oldplayer[1] - (index + 1)
            $i = 0
            while $i < @players_past_count.abs do
              if @players_past_count > 0
                @players_past.push(@all_time_players_index[(@players_old_index - ($i + 2))])
              end
              $i += 1
            end
          @all_time_players_changed_index.push(@player_name, @players_new_index, @players_past_count)
          end
          if (@player_name == player["player"].name) && (@player_name == @winning_players[1].name)
            @players_past = []
            @players_past_count = oldplayer[1] - (index + 1)
            $i = 0
            while $i < @players_past_count.abs do
              if @players_past_count > 0
                @players_past.push(@all_time_players_index[(@players_old_index - ($i + 2))])
              end
              $i += 1
            end
          @all_time_players_changed_index2.push(@player_name, @players_new_index, @players_past_count)
          end
        end
      end
    end
    @player1_past_array = []
    @player2_past_array = []
    if @all_time_players_changed_index[2] > 0
      @players_past_array = []
      $i = 0
      @extra_index = 0
      while $i < @all_time_players_changed_index[2] do
        if (@all_time_players[(@all_time_players_changed_index[1] + $i)]["player"].name) == @winning_players[0].name || (@all_time_players[(@all_time_players_changed_index[1] + $i)]["player"].name) == @winning_players[1].name
          @extra_index = 1
        else
          @player1_past_array.push(@all_time_players[(@all_time_players_changed_index[1] + $i)]["player"].name)
        end
        if @extra_index == 1 
          @player1_past_array.push(@all_time_players[(@all_time_players_changed_index[1] + @all_time_players_changed_index[2])]["player"].name)
        end
        $i += 1
      end
    end
    if @all_time_players_changed_index2[2] > 0
      @players_past_array = []
      $i = 0
      @extra_index = 0
      while $i < @all_time_players_changed_index2[2] do
        if (@all_time_players[(@all_time_players_changed_index2[1] + $i)]["player"].name) == @winning_players[0].name || (@all_time_players[(@all_time_players_changed_index2[1] + $i)]["player"].name) == @winning_players[1].name
          @extra_index = 1
        else
          @player2_past_array.push(@all_time_players[(@all_time_players_changed_index2[1] + $i)]["player"].name)
        end
        if @extra_index == 1 
          @player2_past_array.push(@all_time_players[(@all_time_players_changed_index2[1] + @all_time_players_changed_index2[2])]["player"].name)
        end
        $i += 1
      end
    end
    if @player1_past_array.count > 0 && @player2_past_array.count > 0
      return @all_time_players_changed_index[0].to_s + " gick om " + @player1_past_array.to_sentence(words_connector: ', ', two_words_connector: ' och ', last_word_connector: ' och ') + "<br>" + @all_time_players_changed_index2[0].to_s + " gick om " + @player2_past_array.to_sentence(words_connector: ', ', two_words_connector: ' och ', last_word_connector: ' och ')
    end
    if @player1_past_array.count > 0
      return @all_time_players_changed_index[0].to_s + " gick om " + @player1_past_array.to_sentence(words_connector: ', ', two_words_connector: ' och ', last_word_connector: ' och ')
    end
    if @player2_past_array.count > 0
      return @all_time_players_changed_index2[0].to_s + " gick om " + @player2_past_array.to_sentence(words_connector: ', ', two_words_connector: ' och ', last_word_connector: ' och ')
    end
    return @message
  end 
  end
  
end





  