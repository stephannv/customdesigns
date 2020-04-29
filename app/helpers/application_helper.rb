module ApplicationHelper
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
end
