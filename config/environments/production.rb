require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false

  # 本番はS3を使う場合
  config.active_storage.service = :amazon

  config.log_level = :info
  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false

  config.active_record.dump_schema_after_migration = false

  # 必要に応じて下記のSSL/メール/エラー通知などを追記
  # config.force_ssl = true
  # config.action_mailer.raise_delivery_errors = false
end