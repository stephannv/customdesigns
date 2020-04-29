class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pagy::Backend

  add_flash_types :success, :info, :error, :warning
  helper_method :current_creator

  def current_creator
    current_user.creator
  end

  def validate_recaptcha!(token:, action:)
    unless Recaptcha.valid?(token: token, action: action)
      redirect_to root_url, error: 'Invalid request'
    end
  end
end
