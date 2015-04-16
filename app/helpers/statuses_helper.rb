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
end
