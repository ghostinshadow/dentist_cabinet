# encoding: utf-8

##
# Backup Generated: dentist_cabinet
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t dentist_cabinet [-c <path_to_configuration_file>]
#
Backup::Model.new(:dentist_cabinet, 'Description for dentist_cabinet') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = ENV['PG_DB_NAME']
    db.username           = ENV['PG_USERNAME']
    db.password           = ENV['PG_PASSWORD']
    db.host               = ENV['PG_HOST']
    db.port               = ENV['PG_PORT']
    db.skip_tables        = []
    db.only_tables        = []
    db.additional_options = []
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  # Available Regions:
  #
  #  - ap-northeast-1
  #  - ap-southeast-1
  #  - eu-west-1
  #  - us-east-1
  #  - us-west-1
  #
  store_with S3 do |s3|
    s3.access_key_id     = ENV['S3_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
    s3.region            = ENV['S3_REGION']
    s3.bucket            = ENV['S3_BUCKET_NAME']
    s3.path              = ENV['PATH_TO_BACKUPS']
    s3.keep              = 10
  end

  encrypt_with OpenSSL do |encryption|
    encryption.password = ENV['ENCRYPTION_PASSWORD']
    encryption.base64   = true
    encryption.salt     = true
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip
end
