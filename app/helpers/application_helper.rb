#encoding=utf-8

module ApplicationHelper
  def datestring (date=Date.current)
    date.strftime("%-m월 %-d일")
  end

  def weekdaystring (date=Date.current, option='long')
    if option == 'short'
      l date, format: "%a"
    else
      l date, format: "%A"
    end
  end

  def seasonstring (date=season_start)
    date.strftime("%-y년 %-m월 시즌")
  end

  def seasonstring_detail (date=season_start)
    date.strftime("%-Y년 %-m월 %-d일") + '~' + season_start(date.next_month).strftime("%-Y년 %-m월 %-d일")
  end

  def weekstring (date=Date.current)
    datestring(date.beginning_of_week) + '~' + datestring(date.beginning_of_week + 6.days)
  end

  def weekstring_short (date=last_weekly_goal.weeknum)
    "#{date.month}월 #{relative_weeknum date}주차"
  end

  def advanced_weekstring (date=last_weekly_goal.weeknum, season=true)
    seasonstr = seasonstring(date)
    weekstr = " #{relative_weeknum date}주차(#{weekstring date})"
    if season
      seasonstr + weekstr
    else
      weekstr
    end
  end

  def advanced_weekstring_short (date=last_weekly_goal.weeknum)
    "#{seasonstring date} #{relative_weeknum date}주차"
  end

  def new_status_form_hidden?
    # TODO: recover after retrospect is complete
    # unless no_monthly_goal?
    #   if day_passed_since_last_retro <= 5
    #     if day_passed_since_last_retro == 5 and last_verified_at == Date.current
    #       return true
    #     elsif no_weekly_goal? or no_daily_goal?
    #       return true
    #     else
    #       return false
    #     end
    #   end
    # end
    # return true
    return (no_monthly_goal? or no_weekly_goal? or no_daily_goal?)
  end

  def old_goal? (option)
    if option == 'season'
      compare = last_monthly_goal.season
      against = season_start
    elsif option == 'week'
      compare = last_weekly_goal.weeknum
      against = Date.current.beginning_of_week
    else
      compare = last_daily_goal.goal_date
      against = Date.current
    end

    if compare < against
      return 'old'
    else
      return ''
    end
  end

  def korean_postposition(str)
    if (str[-1].unpack('U*').first - 0xAC00) % 28 != 0
      '이'
    else
      '가'
    end
  end
end
