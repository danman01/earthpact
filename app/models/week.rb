class Week < ActiveRecord::Base
  has_many :logs
  has_many :users, :through => :logs
end
