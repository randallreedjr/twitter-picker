class Tweet < ActiveRecord::Base
  belongs_to :campaign
  has_one :winner
end
