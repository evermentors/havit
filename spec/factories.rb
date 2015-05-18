FactoryGirl.define do
  factory :admin, class: User do
    name "evermentors"
    email "evermentors@gmail.com"
    password "ever8253"
    last_used_character 0
  end

  factory :group do
    name "Universe"
    creator 1
  end  
end
