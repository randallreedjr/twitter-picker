class Tweeter < ActiveRecord::Base
  belongs_to :campaign
  has_many :tweets
end
