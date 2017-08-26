class AchievementsController < ApplicationController
  before_action :set_achievement, only: [:show, :edit, :update, :destroy]

  # GET /achievements
  # GET /achievements.json
  def index
    @achievements = Achievement.all
    @achievement_array = [[{"HasIt"=>nil, "type"=>"shame", "name"=>"BadBets", "description"=>"Förlora 3 dubbelmatcher på en kväll", "score"=>10, "img"=>"badbets.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"BadScorer", "description"=>"Under 10 mål gjorda på 15 matcher", "score"=>-10, "img"=>"badscorer.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"Bigbets!", "description"=>"Minst 15 spelade dubbelmatcher", "score"=>10, "img"=>"bigbets.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"BigWins", "description"=>"Vinn 3 matcher med minst 5 mål på en kväll", "score"=>10, "img"=>"bigwins.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"CleanSheets", "description"=>"Håll nollan 5 matcher i rad", "score"=>10, "img"=>"cleansheets.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"BigToffel", "description"=>"Lämna en spelkväll med mindre än 5 spelade matcher", "score"=>-10, "img"=>"deserter.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"HugeDoubleLose", "description"=>"Förlora en dubbelmatch med minst 5 i målskillnad", "score"=>-10, "img"=>"doublebiglose.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"DoubleWins", "description"=>"Vinn 3 dubbelmatcher på en kväll", "score"=>10, "img"=>"doubledwins.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GamingWeek", "description"=>"Spela 2 kvällar på en vecka", "score"=>10, "img"=>"gaminweek.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GOALS!!!", "description"=>"Gör minst 6 mål på en match", "score"=>10, "img"=>"goal.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoKeeper", "description"=>"Släpp in minst 6 mål", "score"=>-10, "img"=>"goalagainst.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GoldNight!", "description"=>"Vinn över 200:- på en kväll", "score"=>10, "img"=>"goldnight.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"GoldStreak", "description"=>"Vinn över 100:- 3 kvällar på rad", "score"=>10, "img"=>"goldstreak.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"LoseStreak", "description"=>"Förlora 5 matcher i rad", "score"=>-10, "img"=>"losestreak.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"Married", "description"=>"Spela inga matcher på 90 dagar", "score"=>-10, "img"=>"married.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoCleanSheet!", "description"=>"Släpp in mål i 10 matcher på rad", "score"=>-10, "img"=>"nocleansheet.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"NoGoals", "description"=>"Inga mål gjorde på 5 matcher i rad", "score"=>-10, "img"=>"nogoals.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"OpenNet", "description"=>"Släpp in 25 mål på 10 matcher", "score"=>-10, "img"=>"opennet.png"}, []], [{"HasIt"=>nil, "type"=>"shame", "name"=>"PoorMan", "description"=>"Ha en Balance-totalt under -500", "score"=>-10, "img"=>"poorman.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"ReliableScorer", "description"=>"Över 12 mål på 5 matcher", "score"=>10, "img"=>"reliablescorer.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"RichMan", "description"=>"Ha en Balance-totalt över 500", "score"=>10, "img"=>"richman.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"TopNotchScorer", "description"=>"Gör mål 10 matcher i rad", "score"=>10, "img"=>"Scoreeverymatch.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"SolidMonth", "description"=>"Minst 3 spelkvällar på en månad", "score"=>10, "img"=>"solidmonth.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"TrueWinner", "description"=>"Vinn mot minst 6 spelare i Systemet med minst 5 mål", "score"=>10, "img"=>"truewinner.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"WinStreak", "description"=>"Vinn 5 matcher i rad", "score"=>10, "img"=>"winstreak.png"}, []], [{"HasIt"=>nil, "type"=>"fame", "name"=>"WinnerNight", "description"=>"Vinn minst 15 matcher på en kväll", "score"=>10, "img"=>"winnernight.png"}, []]]
    @achievements.each do |gainedAchievement|
      @achievement_array.each do |achievement|
        # converting achievement.type to the displayed achievement name
        @gainedAchievement =  gainedAchievement.type.singularize.classify.constantize.hash_me
        if achievement[0]["name"] == @gainedAchievement["name"]
          # finding the loop index for the achievement array, [1] for pushing player into the second array inside achievement array
          if gainedAchievement.player != nil
            @achievement_array[@achievement_array.index(achievement)][1].push(gainedAchievement.player.name)
          else
          end
        end
      end
    end
  end
  
  # GET /achievements/1
  # GET /achievements/1.json
  def show
  end

  # GET /achievements/new
  def new
    @achievement = Achievement.new
  end

  # GET /achievements/1/edit
  def edit
  end

  # POST /achievements
  # POST /achievements.json
  def create
    @achievement = Achievement.new(achievement_params)

    respond_to do |format|
      if @achievement.save
        format.html { redirect_to @achievement, notice: 'Achievement was successfully created.' }
        format.json { render :show, status: :created, location: @achievement }
      else
        format.html { render :new }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /achievements/1
  # PATCH/PUT /achievements/1.json
  def update
    respond_to do |format|
      if @achievement.update(achievement_params)
        format.html { redirect_to @achievement, notice: 'Achievement was successfully updated.' }
        format.json { render :show, status: :ok, location: @achievement }
      else
        format.html { render :edit }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievements/1
  # DELETE /achievements/1.json
  def destroy
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to achievements_url, notice: 'Achievement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_achievement
      @achievement = Achievement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def achievement_params
      params.require(:achievement).permit(:player_id, :type)
    end
end
