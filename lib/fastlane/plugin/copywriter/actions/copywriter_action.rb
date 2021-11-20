require 'fastlane/action'
require_relative '../helper/file_reader'
require_relative '../helper/file_writer'

module Fastlane
  module Actions
    class CopywriterAction < Action

      def self.run(params)
        grouped_keys = Helper::FileReader.read(params[:input])
        Helper::FileWriter.write(grouped_keys, params[:output])
      end

      def self.description
        "Generate typesafe enum for localizedStrings"
      end

      def self.authors
        ["Milan de Ruiter"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :input,
            description: "path to input .strings file",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :output,
            description: "path to output .swift file",
            optional: false,
            type: String
          )
        ]
      end
    end
  end
end
