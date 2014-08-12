# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prize do
    campaign_id 1
    winner_id 1
    name "MyString"
    number 1
  end
end
