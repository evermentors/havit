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
      if browser.mobile?
        image_tag status.photo.url(:medium), class: 'mobile'
      else
        if Net::HTTP.get_response(URI.parse(status.photo.url(:large))).code.to_i > 400
          image_tag status.photo
        else
          image_tag status.photo.url(:large)
        end
      end
    else
      content_tag(:span)
    end
  end
end
