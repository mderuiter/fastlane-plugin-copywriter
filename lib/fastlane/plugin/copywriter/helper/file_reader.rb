require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FileReader

      def self.read(input)        
        keys = self.getKeys(input)
        self.group(keys)
      end

      private

      def self.getKeys(file)
        File.readlines(file)
          .select { |line| line.start_with?("\"") }
          .map { |line|
            key = line.split("\" = \"")
            key = key[0][1..-1].chomp()
          }
      end

      def self.group(keys)
        dictionary = { nil => [] }
        keys.each do |key|
          section = key.split("_")[0] if key.include? "_"
          values = dictionary.fetch(section, [])
          dictionary[section] = values + [key]
        end

        return dictionary
      end

    end
  end
end
