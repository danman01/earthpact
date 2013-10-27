class PagesController < ApplicationController

  def home
    @pact = Pact.new
    @weeks = Week.all
    if current_user
      @total_plastic_used = current_user.total_plastic_used
    end
  end
end
