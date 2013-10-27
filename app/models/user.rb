class User < ActiveRecord::Base
  has_many :services
  has_many :logs
  has_many :weeks, :through => :logs
  has_one :pact
  has_many :contributions #payments

  # returns image url of the last authenticated service with an image
  def profile_image
    if !services.empty?
      service_to_use = services.where("image IS NOT NULL").last
      service_to_use.image
    end
  end

  # save stripe customer id
  def save_stripe_customer_id(customer_id)
    self.stripe_customer_id = customer_id
    self.save
  end

  def get_stripe_customer_id
    self.stripe_customer_id
  end

  # gets total plastic used by user all time
  def total_plastic_used

    total = 0
    self.logs.each do |log|
      total += log.amount_used
    end
    total
  end

  def self.who_made_pact
    users = []
    Pact.all.collect {|pact| users << pact.user}
    return users
  end

end
