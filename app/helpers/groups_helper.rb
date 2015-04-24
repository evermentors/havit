module GroupsHelper
  def groups_of_user (user=current_user)
    groups = []
    user.characters.each do |cha|
      groups << cha.group
    end
    return groups
  end

  def is_full? (group)
    group.member_limit > 0 and group.characters.count >= group.member_limit
  end

  def joined_group? (group, user=current_user)
    not Character.in_group(user, group).blank?
  end
end
