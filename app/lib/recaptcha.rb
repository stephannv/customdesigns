class Recaptcha
  def self.valid?(token:, action:)
    return true unless Rails.env.production?

    secret_key = Rails.application.credentials.recaptcha[:secret_key]

    response = HTTParty.get("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    body = response.parsed_response
    body['success'] && body['score'] > 0.5 && body['action'] == action
  end
end
