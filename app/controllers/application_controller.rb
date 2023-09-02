class ApplicationController < ActionController::Base
  def index
    @arts = Art.all
  end
end
