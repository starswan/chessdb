# frozen_string_literal: true

module Tasks
  module Db
    module YamlLoad
      class Loader < YamlDb::Load
        class << self
          def load_dir(dir)
            names = []
            files = names.map { |h| "#{h}.yml" }

            dirname = Rails.root.join("db/#{dir}").to_s
            filenames = Dir.entries(dirname).reject { |d| %w[. ..].include?(d) }
            sized_files = filenames.sort_by { |h| File.stat("#{dirname}/#{h}").size }

            sized_files.sort_by { |h| files.include?(h) ? files.index(h) : files.size + 1 }.each do |filename|
              load("#{dirname}/#{filename}")
            end
          end

          def load(filename)
            handler = Tasks::Db::YamlLoad::ColumnHandler.new
            parser = Psych::Parser.new(handler)
            parser.parse File.new(filename, "r")
            records = {
              "columns" => handler.columns,
              "records" => Enumerator.new do |thing|
                handler = Tasks::Db::YamlLoad::RecordsHandler.new thing
                parser = Psych::Parser.new(handler)
                parser.parse File.new(filename, "r")
              end,
            }
            table_name = handler.table_name || filename.split("/").last.chomp(".yml")
            Rails.logger.info "Loading table #{table_name}"
            YamlDb::SerializationHelper::Load.load_table(table_name, records)
          end
        end
      end
    end
  end
end
