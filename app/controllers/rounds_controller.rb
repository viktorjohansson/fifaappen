class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @match = Match.new
    @rounds = Round.all
  end


  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @match = Match.new
    @round = Round.find(params[:id])
    @schedule = @round.schedule
    @players = @round.players
    @pre_round = @round.created_at - 16.hours
    @after_round = @round.created_at + 16.hours
    @last_time_players_ajax = []
    @players.each do |player|
      if player.statistic_last_times.any?
        player.statistic_last_times.each do |statistic|
          # matching statistic created in time between of pre_round and after_round
          if ((statistic.created_at > @pre_round) && (statistic.created_at < @after_round)) 
            @last_time_players_ajax.push({"player" => player, "player_stats" => player.statistic_last_times.last, "player_balance" => player.statistic_last_times.last.balance})
          end
        end
      end
    end
    @last_time_players_sorted_ajax = @last_time_players_ajax.sort_by { |k| k["player_balance"] }.reverse
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)
    @player_array = []
    @round.players.each do |player|
      @player_array.push(player.id)
    end
    @schedule = @player_array.shuffle
    @round.schedule = get_schedule(@schedule)
    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: '' }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy

    respond_to do |format|
      format.html { redirect_to new_round_path, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:name, player_ids: [], team_ids: [])
    end
end
