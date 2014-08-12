class Tweet < ActiveRecord::Base
  belongs_to :campaign
  has_one :winner
  has_one :prize, through: :winner
  belongs_to :tweeter

  def readable_entry_time
    entry_time.strftime('%b %-d, %Y %l:%M%P')
  end
end
