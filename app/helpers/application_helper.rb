#encoding=utf-8

module ApplicationHelper
  def datestring (date)
    date.strftime("%-m월 %-d일")
  end
  def seasonstring (date=season_start)
    date.strftime("%-Y년 %-m월 시즌")
  end
  def weekstring (date=Time.current.to_date)
    datestring(date.beginning_of_week) + '~' + datestring(date.beginning_of_week + 5.days)
  end
end
