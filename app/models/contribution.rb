class Contribution < ActiveRecord::Base
  belongs_to :user

  if Rails.env == "production"
    STRIPE_KEY = ENV["STRIPE_PUBLIC_KEY"]
    STRIPE_SECRET_KEY = ENV['STRIPE_API_KEY']
  else
    STRIPE_KEY = ENV["STRIPE_TEST_PUBLIC_KEY"]
    STRIPE_SECRET_KEY = ENV["STRIPE_TEST_API_KEY"]
  end
end
