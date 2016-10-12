require 'jsonpath'

module Embulk
  module Filter

    class ExpandJsonArray < FilterPlugin
      Plugin.register_filter("expand_json_array", self)

      def self.transaction(config, in_schema, &control)
        # configuration code:
        task = {
          "json_column_name" => config.param("json_column_name", :string),
          "root" => config.param("root", :string),
          "expanded_column_name" => config.param("expanded_column_name", :string)
        }

        task['parse_target_column'] = in_schema.find{|c| c.name == task['json_column_name']}

        columns = [
          Column.new(nil, task["expanded_column_name"], :string),
        ]

        out_columns = in_schema + columns

        yield(task, out_columns)
      end

      def init
        # initialization code:
        @json_column_name = task["json_column_name"]
        @root = task["root"]
        @expanded_column_name = task["expanded_column_name"]

        @parse_target_column = task['parse_target_column']

        @json_path = JsonPath.new(@root)
      end

      def close
      end

      def add(page)
        # filtering code:
        page.each do |record|
          expanded_columns = @json_path.on(record[@parse_target_column['index']]).flatten

          expanded_columns.each do |ec|
            page_builder.add(record + [ec])
          end
        end
      end

      def finish
        page_builder.finish
      end
    end

  end
end
