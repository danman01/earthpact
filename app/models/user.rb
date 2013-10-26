class User < ActiveRecord::Base
  has_many :services
  has_many :logs
  has_many :weeks, :through => :logs
  has_one :pact
  has_many :contributions

  # returns image url of the last authenticated service with an image
  def profile_image
    if !services.empty?
      service_to_use = services.where("image IS NOT NULL").last
      service_to_use.image
    end
  end

end
