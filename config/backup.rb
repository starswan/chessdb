#
# $Id$
#
# encoding: utf-8
##
# Backup Generated: backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup [-c <path_to_configuration_file>]
#
THE_RAILS_ENV    = ENV['RAILS_ENV'] || 'development'

Backup::Model.new(:db_backup, 'Backup chessdb database') do

  database_yml = File.expand_path('../../config/database.yml',  __FILE__)

  require 'yaml'
  config = YAML.load_file(database_yml)

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = config[THE_RAILS_ENV]["database"]
    db.username           = config[THE_RAILS_ENV]["username"]
    db.password           = config[THE_RAILS_ENV]["password"]
    db.host               = config[THE_RAILS_ENV]["host"]
    db.port               = config[THE_RAILS_ENV]["port"]
    db.socket             = config[THE_RAILS_ENV]["socket"]
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    db.skip_tables        = []
    #db.skip_tables        = ["skip", "these", "tables"]
    #db.only_tables        = ["only", "these" "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.mysqldump_utility = "/opt/local/bin/mysqldump"
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    #local.path       = "db/db_backup"
    local.path       = "db"
    local.keep       = 5
  end

  ##
  # Gzip [Compressor]
  #
  #compress_with Gzip

end
