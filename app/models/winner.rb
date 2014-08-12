class Winner < ActiveRecord::Base
  belongs_to :prize
  belongs_to :tweet
  #has_one :campaign, through: :prize
  def clear_prize
    self.destroy
  end

end
