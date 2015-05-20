module SimpleCalendar
  class MonthCalendar < Calendar
    def season_start (date=Date.current)
      season_start = date.beginning_of_month
      wnum_today = date.strftime("%W").to_i
      wnum_beginning = season_start.strftime("%W").to_i

      if season_start.wday != 1 and wnum_today - wnum_beginning == 0
        season_start = season_start.prev_month
      end

      season_start += 1 until season_start.wday == 1
      return season_start
    end

    def date_range
      @date_range ||= season_start().beginning_of_week..season_start(Date.current.next_month).yesterday
    end
  end
end
