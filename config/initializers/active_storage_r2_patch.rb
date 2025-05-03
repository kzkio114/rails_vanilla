Rails.application.config.to_prepare do
  require "active_storage/service/s3_service"

  ActiveStorage::Service::S3Service.class_eval do
    def upload(key, io, checksum: nil, **options)
      instrument :upload, key: key, checksum: checksum do
        # 許可されたオプションのみ抽出
        upload_options = options.slice(:content_type, :content_disposition, :cache_control, :metadata)

        # checksumを渡さずにアップロード
        object_for(key).put(body: io, **upload_options)
      end
    end
  end
end
