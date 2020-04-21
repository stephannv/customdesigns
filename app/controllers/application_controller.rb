class ApplicationController < ActionController::Base
  include Clearance::Controller

  def current_creator
    current_user.creator
  end
end
