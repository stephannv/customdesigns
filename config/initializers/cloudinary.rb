require 'cloudinary'

if Rails.env.production?
  Cloudinary.config(
    cloud_name: Rails.application.credentials.cloudinary[:cloud_name],
    api_key: Rails.application.credentials.cloudinary[:api_key],
    api_secret: Rails.application.credentials.cloudinary[:api_secret]
  )
end
