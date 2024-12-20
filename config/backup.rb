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

CHESSDB_TABLES = %w[
  ar_internal_metadata
  schema_migrations
  games
  moves
  openings
  players
].freeze


Backup::Model.new(:db_backup, 'Backup chessdb database') do

  database_yml = File.expand_path('../../config/database.yml',  __FILE__)

  require 'yaml'
  config = YAML.load_file(database_yml).fetch(ENV.fetch('RAILS_ENV', 'development'))

  ##
  # MySQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = config["database"]
    db.username           = config["username"]
    db.password           = config["password"]
    db.host               = config["host"]
    db.port               = config["port"]
    db.socket             = config["socket"]
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    db.skip_tables        = []
    db.only_tables        = CHESSDB_TABLES

    #db.skip_tables        = ["skip", "these", "tables"]
    #db.only_tables        = ["only", "these" "tables"]
    db.additional_options = ["--no-owner", "--no-privileges", "--format=plain", "--quote-all-identifiers"]
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
