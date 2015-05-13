#encoding=utf-8

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

  def group_status (group)
    if joined_group?(group)
      'already-joined'
    elsif is_full?(group)
      'full-group'
    elsif group.password.present?
      'need-passcode'
    end
  end

  def notify_to_group (status, group=current_character.group)
    client ||= SendGrid::Client.new do |c|
      c.api_user = ENV['SENDGRID_USERNAME']
      c.api_key = ENV['SENDGRID_PASSWORD']
    end

    addresses = []
    group.characters.each do |cha|
      addresses << cha.user.email unless cha == current_character
    end

    addresses.each do |address|
      if no_daily_goal?(status.character, status.verified_at)
        goal_str = "<strong>#{datestring status.verified_at}에는 목표가 없었습니다.</strong>"
      else
        goal_str = "<strong>#{datestring status.verified_at} #{weekdaystring status.verified_at}의 목표:</strong> <span style='color: #ec5413; font-weight: normal;'>#{daily_goal(status.character, status.verified_at).description}</span>"
      end
      mail = SendGrid::Mail.new do |m|
        m.to = address
        m.from = 'evermentors@gmail.com'
        m.subject = "[Havit] #{current_user.name}님이 '#{current_character.group.name}' 그룹에서 #{datestring status.verified_at}의 실천 인증을 올렸습니다."
        m.html ="
        <p style='margin:0; font-size:15px;'>#{goal_str}</p>
        <hr style='width: 30px; display: inline-block;'>
        <p style='white-space: pre-line; margin:0;'>#{auto_link(status.description.gsub(/[<>]/, "<"=>'[', ">"=>']'), html: {target: '_blank'}) do |text| truncate(text, length: 30) end}</p>
        <hr style='width: 30px; display: inline-block;'>
        <p style='font-size: small; margin-top:0;'>
          <a href=#{group_url(current_character.group) + '?status-id='+status.id.to_s}>Havit에서 보기</a>
        </p>"
      end
      client.send(mail)
    end
  end
end

