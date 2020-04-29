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

  def bookmark_button(creator, custom_design, classes: '')
    if creator.bookmarked?(custom_design)
      request_method = :delete
      icon_class = 'fas'
    else
      request_method = :post
      icon_class = 'far'
    end

    render 'custom_designs/bookmark_button',
      custom_design: custom_design,
      request_method: request_method,
      classes: classes,
      icon_class: icon_class
  end

  def heart_button(creator, custom_design, classes: '')
    if creator.loved?(custom_design)
      request_method = :delete
      icon_class = 'fas'
    else
      request_method = :post
      icon_class = 'far'
    end

    render 'custom_designs/heart_button',
      custom_design: custom_design,
      request_method: request_method,
      classes: classes,
      icon_class: icon_class
  end

  def include_recaptcha_js
    return unless Rails.env.production?

    tag.script src: "https://www.google.com/recaptcha/api.js?render=#{Rails.application.credentials.recaptcha[:site_key]}"
  end

  def execute_recaptcha(action)
    return unless Rails.env.production?

    recaptcha_id = "recaptcha_token_#{SecureRandom.hex(10)}"
    site_key = Rails.application.credentials.recaptcha[:site_key]

    render 'layouts/recaptcha', recaptcha_id: recaptcha_id, site_key: site_key, action: action
  end
end
