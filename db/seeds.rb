#encoding=utf-8
if User.find_by_email('evermentors@gmail.com').blank?
  ActiveRecord::Base.skip_callbacks = true
  havit_admin = User.create name: '에버멘토', email: 'evermentors@gmail.com', password: 'ever8253', last_used_character: 1
  ActiveRecord::Base.skip_callbacks = false
else
  havit_admin = User.find_by_email('evermentors@gmail.com')
end

if Group.find_by_name('Universe').blank?
  universe = Group.create name: 'Universe', creator: havit_admin.id
else
  universe = Group.find_by_name('Universe')
end

User.find_each do |user|
  if Character.find_by(user_id: user.id).blank?
    character = Character.create! order: 1, group_id: universe.id, user_id: user.id
    user.last_used_character = character.id
  end
end
