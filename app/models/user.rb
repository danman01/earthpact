class User < ActiveRecord::Base
  has_many :services
  has_one :usage_history
end
