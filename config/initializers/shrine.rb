require 'shrine'
require 'shrine/storage/file_system'
# require 'shrine/storage/s3'

# s3 = Shrine::Storage::S3.new(
#   public: true,
#   bucket: Rails.application.credentials.s3[:bucket],
#   endpoint: Rails.application.credentials.s3[:endpoint],
#   region: Rails.application.credentials.s3[:region],
#   access_key_id: Rails.application.credentials.s3[:access_key_id],
#   secret_access_key: Rails.application.credentials.s3[:secret_access_key],
# )

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads'),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :derivatives
Shrine.plugin :restore_cached_data
