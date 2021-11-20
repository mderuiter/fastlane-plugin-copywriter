require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class FileWriter

      def self.write(grouped_keys, output)  
        File.open(output, "w") do |file| 
          self.write_header(file)
          self.write_root_enum_header(file)
          self.write_groups(file, grouped_keys)
          self.write_root_enum_footer(file)
        end
      end

      private 

      def self.write_header(file)
        header = "./lib/fastlane/plugin/copywriter/templates/header.txt"
        File.open(header).readlines.each { |l| file.write(l) }
      end

      def self.write_root_enum_header(file)
        file.write("\nenum LocalizedString {\n")
      end

      def self.write_root_enum_footer(file)
        file.write("}\n")
      end

      def self.write_leaf_enum_header(file, name)
        file.write("\n\tenum #{name.capitalize} {\n")
      end

      def self.write_leaf_enum_footer(file)
        file.write("\t}\n")
      end

      def self.write_property(file, value, indent)
        key = value.split("_").map(&:capitalize).join
        key = key[0,1].downcase + key[1..-1]
        file.write("#{"\t" * indent}static var #{key}: String { NSLocalizedString(\"#{value}\", nil) }\n")
      end

      def self.write_groups(file, groups)
        groups.each { |group| self.write_group(file, group) }
      end

      def self.write_group(file, group)
        key, values = group
        number_of_tabs = key.nil? ? 1 : 2

        self.write_leaf_enum_header(file, key) unless key.nil?
        values.each { |value|  self.write_property(file, value, number_of_tabs) }
        self.write_leaf_enum_footer(file) unless key.nil?
      end
    end
  end
end
