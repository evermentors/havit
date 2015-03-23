#encoding=utf-8

module ApplicationHelper
  def datestring (date)
    date.strftime("%-m월%d일")
  end
end
