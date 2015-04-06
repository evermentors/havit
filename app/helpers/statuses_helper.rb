module StatusesHelper
  def status_at(date, user=current_user)
    Status.at(date, user).last
  end
end
