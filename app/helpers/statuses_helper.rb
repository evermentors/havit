module StatusesHelper
  def status_at(date, user=current_user)
    Status.at(date, user).last
  end

  def first_verified_at
    Status.where(user: current_user).order(:verified_at).first.verified_at
  end

  def last_verified_at
    Status.where(user: current_user).order(:verified_at).last.verified_at
  end
end
