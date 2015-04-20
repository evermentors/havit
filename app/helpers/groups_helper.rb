module GroupsHelper
  def groups_of_user (user=current_user)
    groups = []
    user.characters.each do |cha|
      groups << cha.group
    end
    return groups
  end
end
