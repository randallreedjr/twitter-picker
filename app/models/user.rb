class User < ActiveRecord::Base

  has_many :campaigns
  has_many :tweets, through: :campaigns

  def self.create_from_omniauth(auth_hash)
    self.create(provider: auth_hash[:provider],
                uid: auth_hash[:uid],
                name: auth_hash[:info][:name],
                screen_name: auth_hash[:info][:nickname],
                image_url: auth_hash[:info][:image].sub("_normal","_bigger"),
                followers_count: auth_hash[:extra][:raw_info][:followers_count],
                token: auth_hash[:credentials][:token],
                secret: auth_hash[:credentials][:secret],
                admin: false)
  end

  def admin?
    self.admin
  end
end
