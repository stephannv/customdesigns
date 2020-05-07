module ApplicationHelper
  include Pagy::Frontend

  def errors_for(object, attribute)
    return unless object.try(:errors).try(:has_key?, attribute)

    content_tag(:p, object.errors[attribute].join(', '), class: 'help is-danger')
  end

  def flash_message
    return if flash.empty?

    if flash[:error].present? || flash[:alert].present?
      notification_class = 'notification is-danger'
      message = flash[:error] || flash[:alert]
    elsif flash[:success]
      notification_class = 'notification is-success'
      message = flash[:success]
    end

    content_tag(:div, class: notification_class) do
      content_tag(:button, class: 'delete')
      message
    end
  end

  def include_recaptcha_js
    return unless Rails.env.production?

    tag.script src: "https://www.google.com/recaptcha/api.js?render=#{Rails.application.credentials.recaptcha[:site_key]}"
  end

  def include_analytics_js
    return unless Rails.env.production?

    render 'layouts/analytics', analytics_id: Rails.application.credentials.analytics[:id]
  end

  def execute_recaptcha(action)
    return if !Rails.env.production? || current_admin.present?

    recaptcha_id = "recaptcha_token_#{SecureRandom.hex(10)}"
    site_key = Rails.application.credentials.recaptcha[:site_key]

    render 'layouts/recaptcha', recaptcha_id: recaptcha_id, site_key: site_key, action: action
  end
end
