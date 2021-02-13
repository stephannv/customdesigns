class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pagy::Backend

  add_flash_types :success, :info, :error, :warning

  before_action :set_raven_context

  private

  helper_method :current_creator
  def current_creator
    current_user.try(:creator)
  end

  def validate_recaptcha!(token:, action:)
    unless Recaptcha.valid?(token: token, action: action)
      redirect_to root_url, error: 'Invalid request'
    end
  end

  def set_raven_context
    # Raven.user_context(id: current_user.try(:id) || "guest_#{session['session_id']}")
    # Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
