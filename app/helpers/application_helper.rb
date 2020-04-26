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
end
