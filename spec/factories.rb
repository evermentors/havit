# encoding=utf-8
# This will guess the User class
FactoryGirl.define do
  factory :admin, class: User do
    name "evermentors"
    email "evermentors@gmail.com"
    password "test4321"
    last_used_character 1
  end

  factory :group do
    name "Universe"
    creator 1
  end

  factory :admin_character, class: Character do
    association :group, factory: :group
    notify true
    order 1
    is_admin 1
    user_id 1
  end

  factory :user, class: User do
    name "kucho"
    email "jku856@gmail.com"
    password "test4321"
    last_used_character 1
  end

  factory :user_group, class: Group do
    name "Evermentors"
    creator 2
  end

  factory :user_character, class: Character do
    association :group, factory: :user_group
    notify true
    order 2
    is_admin 0
    user_id 1
  end
end
