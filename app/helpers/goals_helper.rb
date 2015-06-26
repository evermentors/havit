#encoding=utf-8

module GoalsHelper
  def goal_percentage (goal)
    numerator = (Date.current - goal.created_at.to_date).to_i
    denominator = (goal.end_date - goal.created_at.to_date).to_i
    (numerator * 100 / denominator).to_f
  end

  def goal_period (goal)
    goal.created_at.strftime("%-y년 %-m월 %-d일") + ' ~ ' + goal.end_date.strftime("%-y년 %-m월 %-d일")
  end

  def colorclass_of_day (day, goal, verified_statuses)
    goal_start_day = goal.created_at.to_date
    goal_end_day = goal.end_date

    case
      when day < goal_start_day
        colorclass = 'before-start'
      when day > Date.current
        colorclass = 'future'
      when verified_statuses.include?(day)
        colorclass = 'verified'
      else
        colorclass = ''
    end

    if day == Date.current
      colorclass += ' today'
    elsif day == goal_start_day
      colorclass += ' start-day'
    elsif day == goal_end_day
      colorclass += ' end-day'
    end

    return colorclass
  end

  def calculate_rect (date, daynum, origin, radius, width, height)
    total_dates = (date.end_of_month - date.beginning_of_month).to_i + 1
    degree = daynum * 360 / total_dates
    radian = degree * Math::PI / 180
    position_x = Math.sin(radian) * radius + origin[0]
    position_y = - Math.cos(radian) * radius + origin[1]
    rect_center_x = position_x + width/2
    rect_center_y = position_y + height/2
    rotate = "rotate(#{degree}, #{rect_center_x}, #{rect_center_y})"
    return [position_x, position_y, rotate]
  end
end
