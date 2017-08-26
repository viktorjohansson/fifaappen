class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  # GET /players
  # GET /players.json
  def index
    @players = Player.all
    @teams = Team.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])
    @player_achievement_hash_array = [[{"HasIt"=>nil, "type"=>"shame", "name"=>"BadBets", "description"=>"Förlora 3 dubbelmatcher på en kväll", "score"=>10, "img"=>"badbets.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"BadScorer", "description"=>"Under 10 mål gjorda på 15 matcher", "score"=>-10, "img"=>"badscorer.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"Bigbets!", "description"=>"Minst 15 spelade dubbelmatcher", "score"=>10, "img"=>"bigbets.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"BigWins", "description"=>"Vinn 3 matcher med minst 5 mål på en kväll", "score"=>10, "img"=>"bigwins.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"CleanSheets", "description"=>"Håll nollan 5 matcher i rad", "score"=>10, "img"=>"cleansheets.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"BigToffel", "description"=>"Lämna en spelkväll med mindre än 5 spelade matcher", "score"=>-10, "img"=>"deserter.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"HugeDoubleLose", "description"=>"Förlora en dubbelmatch med minst 5 i målskillnad", "score"=>-10, "img"=>"doublebiglose.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"DoubleWins", "description"=>"Vinn 3 dubbelmatcher på en kväll", "score"=>10, "img"=>"doubledwins.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GamingWeek", "description"=>"Spela 2 kvällar på en vecka", "score"=>10, "img"=>"gaminweek.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GOALS!!!", "description"=>"Gör minst 6 mål på en match", "score"=>10, "img"=>"goal.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoKeeper", "description"=>"Släpp in minst 6 mål", "score"=>-10, "img"=>"goalagainst.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GoldNight!", "description"=>"Vinn över 200:- på en kväll", "score"=>10, "img"=>"goldnight.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GoldStreak", "description"=>"Vinn över 100:- 3 kvällar på rad", "score"=>10, "img"=>"goldstreak.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"LoseStreak", "description"=>"Förlora 5 matcher i rad", "score"=>-10, "img"=>"losestreak.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"Married", "description"=>"Spela inga matcher på 90 dagar", "score"=>-10, "img"=>"married.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoCleanSheet!", "description"=>"Släpp in mål i 10 matcher på rad", "score"=>-10, "img"=>"nocleansheet.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoGoals", "description"=>"Inga mål gjorde på 5 matcher i rad", "score"=>-10, "img"=>"nogoals.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"OpenNet", "description"=>"Släpp in 25 mål på 10 matcher", "score"=>-10, "img"=>"opennet.png"}, 1], [{"HasIt"=>nil, "type"=>"shame", "name"=>"PoorMan", "description"=>"Ha en Balance-totalt under -500", "score"=>-10, "img"=>"poorman.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"ReliableScorer", "description"=>"Över 12 mål på 5 matcher", "score"=>10, "img"=>"reliablescorer.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"RichMan", "description"=>"Ha en Balance-totalt över 500", "score"=>10, "img"=>"richman.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"TopNotchScorer", "description"=>"Gör mål 10 matcher i rad", "score"=>10, "img"=>"Scoreeverymatch.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"SolidMonth", "description"=>"Minst 3 spelkvällar på en månad", "score"=>10, "img"=>"solidmonth.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"TrueWinner", "description"=>"Vinn mot minst 6 spelare i Systemet med minst 5 mål", "score"=>10, "img"=>"truewinner.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"WinStreak", "description"=>"Vinn 5 matcher i rad", "score"=>10, "img"=>"winstreak.png"}, 1], [{"HasIt"=>nil, "type"=>"fame", "name"=>"WinnerNight", "description"=>"Vinn minst 15 matcher på en kväll", "score"=>10, "img"=>"winnernight.png"}, 1]]
   
    @player.achievements.each do |achievement|
      @achievement_hash = achievement.type.singularize.classify.constantize.hash_me
      @player_achievement_hash_array.delete_if { |h| h[0]["name"] == @achievement_hash["name"]}
      @player_achievement_hash_array.push([@achievement_hash, 0])
    end
    
    @achievements = @player_achievement_hash_array.sort_by { |k| k[1] }
    
    @all_time_player = []
    @last_time_player = []
    @last_season_player = []
      if @player.statistic_all_times.any?
        @all_time_player.push({"player" => @player, "player_stats" => @player.statistic_all_times.last, "player_balance" => @player.statistic_all_times.last.balance})
      end
      if @player.statistic_last_times.any?
        @last_time_player.push({"player" => @player, "player_stats" => @player.statistic_last_times.last, "player_balance" => @player.statistic_last_times.last.balance})
      end
      if @player.statistic_last_seasons.any?
        @last_season_player.push({"player" => @player, "player_stats" => @player.statistic_last_seasons.last, "player_balance" => @player.statistic_last_seasons.last.balance})
      end

    
    
  end
  

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        @players = Player.all
        @players.each do |p|
          if p.id != @player.id
            @team = Team.create(name: p.name[0, 3] + @player.name[0, 3] + (p.id + @player.id).to_s, player_ids: [p.id, @player.id])
          else
          end
        end
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    @teams = @player.teams
    if @teams.exists?
      @teams.each do |t|
        t.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def achievement_check
    @player = Player.find(params[:player_id])
    if @player.matches.count > 0
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
    redirect_to :back
  end
  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    params.require(:player).permit(:name, :password, :password_confirmation, :mail)
  end
end
