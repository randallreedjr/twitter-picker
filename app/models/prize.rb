class Prize < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :winner
end
