class Winner < ActiveRecord::Base
  has_one :prize
  belongs_to :tweet
  #has_one :campaign, through: :prize
  def clear_prize
    self.prize.winner_id = nil
    self.prize.save
    self.destroy
  end

end
