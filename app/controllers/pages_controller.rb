class PagesController < ApplicationController

  def home
    @pact = Pact.new
  end
end
