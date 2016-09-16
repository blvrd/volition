FactoryGirl.define do
  factory :reflection do
    rating 1
    wrong "MyText"
    right "MyText"
    undone "MyText"
    user nil
  end
  factory :todo_list do
    user nil
  end
  factory :todo do
    content "MyString"
    complete false
    estimated_time_blocks 1
    user nil
    actual_time_blocks 1
  end
  factory :user do
    name "MyString"
    email "MyString"
    password_digest "MyString"
  end
end
