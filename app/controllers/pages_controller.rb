class PagesController < ApplicationController

  def home
    @pact = Pact.new
    @weeks = Week.all
  end
end
