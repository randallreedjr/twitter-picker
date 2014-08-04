# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    text "MyString"
    screen_name "MyString"
    entry_time "2014-08-04 15:10:58"
    followers_count 1
    status_id 1
  end
end
