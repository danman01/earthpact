class Week < ActiveRecord::Base
  has_many :logs
  has_many :users, :through => :logs
  validates_uniqueness_of :start_day


  # updates the week totals based on log entry and returns the week
  def update_with_log(log)
    user = log.user.pact.penalty rescue nil
    week = self
    if user
      week.total_contributed += log.amount_used * user
      week.total_used += log.amount_used
      week.save
    end
    return week # return week
  end

  # returns or creates the current week
  def self.current_week
    # get existing week or create new one
    week = Week.where("start_day =?",Time.now.beginning_of_week).first_or_create
    if !week.total_used
      # initialize week
      week.total_used = 0
      week.total_contributed = 0
      week.save
    end
    # return the week
    return week
  end
  
end
