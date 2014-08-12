class Tweet < ActiveRecord::Base
  belongs_to :campaign
  has_one :winner
  has_one :prize, through: :winner
end
