class ApplicationController < ActionController::Base
  include Clearance::Controller

  add_flash_types :success, :info, :error, :warning
  helper_method :current_creator

  def current_creator
    current_user.creator
  end
end
