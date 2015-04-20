#encoding=utf-8

module ApplicationHelper
  def current_character
    @current_character ||= Character.find(current_user.last_used_character)
  end

  def datestring (date=Date.current)
    date.strftime("%-m월 %-d일")
  end

  def weekdaystring (date=Date.current, option='long')
    # TODO: date.strftime("%a")와 i18n 활용
    case date.wday
      when 0
        wday = "일"
      when 1
        wday = "월"
      when 2
        wday = "화"
      when 3
        wday = "수"
      when 4
        wday = "목"
      when 5
        wday = "금"
      when 6
        wday = "토"
    end
    wday += "요일" if option == 'long'
    return wday
  end

  def seasonstring (date=season_start)
    date.strftime("%-Y년 %-m월 시즌")
  end

  def weekstring (date=Date.current)
    datestring(date.beginning_of_week) + '~' + datestring(date.beginning_of_week + 6.days)
  end

  def advanced_weekstring (date=last_weekly_goal.weeknum, season=true)
    seasonstr = seasonstring(date)
    weekstr = "#{relative_weeknum date}주차(#{weekstring date})"
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
    unless no_monthly_goal?
      if day_passed_since_last_retro <= 5
        if day_passed_since_last_retro == 5 and last_verified_at == Date.current
          return true
        elsif no_daily_goal?
          return true
        else
          return false
        end
      end
    end
    return true
  end
end
