#encoding=utf-8

module ApplicationHelper
  def datestring (date=Time.current.to_date)
    date.strftime("%-m월 %-d일")
  end

  def weekdaystring (date=Time.current.to_date)
    # TODO: date.strftime("%a")와 i18n 활용
    case date.wday
      when 0
        "일요일"
      when 1
        "월요일"
      when 2
        "화요일"
      when 3
        "수요일"
      when 4
        "목요일"
      when 5
        "금요일"
      when 6
        "토요일"
    end
  end

  def seasonstring (date=season_start)
    date.strftime("%-Y년 %-m월 시즌")
  end

  def weekstring (date=Time.current.to_date)
    datestring(date.beginning_of_week) + '~' + datestring(date.beginning_of_week + 5.days)
  end

  def advanced_weekstring (date=last_weekly_goal.weeknum)
    "#{seasonstring date} #{relative_weeknum date}주차(#{weekstring date})"
  end
end
