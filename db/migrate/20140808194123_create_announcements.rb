class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.integer :campaign_id
      t.string :text

      t.timestamps
    end
  end
end
