class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize
  protect_from_forgery with: :exception

  def balance(balance)
    @balance = []
    balance.each do |b|
      if b[0] != 0
        if b[0] > 0
          @cash = 1
          if b[0] > 2
            @cash = b[0].fdiv(2).round(0)
          else
          end
        else
          @cash = -1
          if b[0] < -2
            @cash = b[0] / 2
          else
          end
        end
      else
        @cash = 0
      end
      if b[1] == 1
        if @cash > 0
          @cash += 1
        end
        if @cash < 0
          @cash -= 1
        end
      end
      @balance.push(@cash)
    end
    return @balance
  end


  def authorize
    if Player.find_by_id(session[:player_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def get_schedule(array)
    case array.length
      when 4
        return [[array[0], array[1], array[2], array[3]],
                [array[1], array[3], array[0], array[2]],
                [array[0], array[3], array[1], array[2]],
                [array[2], array[3], array[0], array[1]],
                [array[0], array[2], array[1], array[3]],
                [array[1], array[2], array[0], array[3]],
                [array[0], array[1], array[2], array[3]],
                [array[1], array[3], array[0], array[2]],
                [array[0], array[3], array[1], array[2]],
                [array[2], array[3], array[0], array[1]],
                [array[0], array[2], array[1], array[3]],
                [array[1], array[2], array[0], array[3]],
                [array[0], array[1], array[2], array[3]],
                [array[1], array[3], array[0], array[2]],
                [array[0], array[3], array[1], array[2]]]
      when 5
        return [[array[0], array[1], array[3], array[4]],
                [array[1], array[4], array[0], array[2]],
                [array[0], array[3], array[2], array[4]],
                [array[3], array[4], array[1], array[2]],
                [array[0], array[1], array[2], array[3]],
                [array[1], array[3], array[0], array[4]],
                [array[0], array[3], array[2], array[4]],
                [array[1], array[4], array[2], array[3]],
                [array[1], array[3], array[0], array[2]],
                [array[1], array[2], array[0], array[4]],
                [array[0], array[1], array[3], array[4]],
                [array[1], array[4], array[0], array[2]],
                [array[0], array[3], array[2], array[4]],
                [array[3], array[4], array[1], array[2]],
                [array[0], array[1], array[2], array[3]]]
      when 6
        return [[array[0], array[1], array[2], array[3]],
                [array[0], array[2], array[4], array[5]],
                [array[3], array[5], array[1], array[4]],
                [array[1], array[2], array[0], array[5]],
                [array[2], array[4], array[0], array[3]],
                [array[3], array[4], array[2], array[5]],
                [array[1], array[5], array[0], array[4]],
                [array[3], array[5], array[1], array[2]],
                [array[0], array[2], array[3], array[4]],
                [array[4], array[5], array[1], array[3]],
                [array[2], array[5], array[0], array[1]],
                [array[0], array[4], array[2], array[3]],
                [array[1], array[5], array[3], array[4]],
                [array[0], array[1], array[2], array[4]],
                [array[1], array[3], array[0], array[5]]]
      when 7
        return [[array[0], array[1], array[5], array[6]],
                [array[4], array[5], array[2], array[3]],
                [array[1], array[4], array[0], array[6]],
                [array[0], array[3], array[2], array[4]],
                [array[2], array[6], array[1], array[5]],
                [array[3], array[5], array[4], array[6]],
                [array[1], array[3], array[0], array[2]],
                [array[2], array[5], array[3], array[4]],
                [array[1], array[2], array[0], array[6]],
                [array[3], array[6], array[0], array[4]],
                [array[2], array[3], array[1], array[5]],
                [array[0], array[5], array[1], array[6]],
                [array[0], array[2], array[3], array[4]],
                [array[1], array[4], array[5], array[6]],
                [array[2], array[6], array[0], array[3]]]
      when 8

        return [[array[0], array[1], array[2], array[3]],
                [array[4], array[5], array[6], array[7]],
                [array[2], array[4], array[3], array[5]],
                [array[1], array[7], array[0], array[6]],
                [array[0], array[2], array[4], array[6]],
                [array[1], array[3], array[5], array[7]],
                [array[2], array[5], array[0], array[7]],
                [array[3], array[6], array[1], array[4]],
                [array[1], array[5], array[0], array[3]],
                [array[4], array[7], array[2], array[6]],
                [array[0], array[5], array[1], array[4]],
                [array[6], array[7], array[2], array[3]],
                [array[3], array[5], array[0], array[2]],
                [array[1], array[6], array[4], array[7]],
                [array[0], array[4], array[3], array[7]]]
      when 9

        return [[array[0], array[1], array[2], array[3]],
                [array[4], array[5], array[6], array[7]],
                [array[0], array[8], array[3], array[4]],
                [array[1], array[2], array[5], array[6]],
                [array[3], array[8], array[0], array[7]],
                [array[2], array[8], array[1], array[4]],
                [array[5], array[7], array[0], array[6]],
                [array[3], array[7], array[1], array[5]],
                [array[2], array[4], array[6], array[8]],
                [array[0], array[3], array[5], array[8]],
                [array[1], array[6], array[2], array[7]],
                [array[3], array[4], array[1], array[2]],
                [array[0], array[5], array[1], array[8]],
                [array[2], array[6], array[4], array[7]],
                [array[3], array[5], array[0], array[8]]]
      when 10

        return [[array[0], array[1], array[2], array[3]],
                [array[4], array[5], array[6], array[7]],
                [array[8], array[9], array[0], array[3]],
                [array[2], array[4], array[1], array[6]],
                [array[7], array[8], array[5], array[9]],
                [array[0], array[6], array[3], array[4]],
                [array[2], array[5], array[1], array[8]],
                [array[3], array[7], array[0], array[9]],
                [array[1], array[2], array[4], array[6]],
                [array[7], array[9], array[5], array[8]],
                [array[0], array[4], array[2], array[8]],
                [array[6], array[9], array[1], array[3]],
                [array[5], array[7], array[0], array[2]],
                [array[3], array[8], array[1], array[4]],
                [array[5], array[6], array[7], array[9]]]
      else
        puts 'error'

    end

  end

  def last_day_check(match)
    @matchdate = match.created_at
    if @matchdate > Match.last.created_at - 16.hours
      @matchdate = match
    else
      @matchdate = false
    end
    return @matchdate
  end

end
