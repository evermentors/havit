module StatusesHelper
  def status_at(date, cha=current_character)
    Status.at(date, cha).last
  end

  def first_verified_at
    Status.where(character: current_character).order(:verified_at).first.verified_at
  end

  def last_verified_at
    Status.where(character: current_character).order(:verified_at).last.verified_at
  end

  def status_photo (status)
    if status.photo?
      image_tag status.photo.url(:large), class: "#{'mobile' if browser.mobile?}"
    else
      content_tag(:span)
    end
  end

  def date_class(goal, day)
    str = ""
    if day == 0
      str += "active first-load "
    end
    if goal.statuses.at(day.days.ago.to_date).present?
      str += "verified"
    end
    return str
  end
end
