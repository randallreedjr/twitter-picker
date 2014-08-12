# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweeter do
    uid 1
    screen_name "MyString"
    name "MyString"
    followers_count 1
    campaign_id 1
  end
end
