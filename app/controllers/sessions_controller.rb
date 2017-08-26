class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    player = Player.find(1)
    if player and player.authenticate(params[:password])
      session[:player_id] = player.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid username or password"
    end
  end

  def destroy
    session[:player_id] = nil
    redirect_to statistics_url, notice: "Logged out"
  end
end
