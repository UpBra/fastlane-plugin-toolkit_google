require 'fastlane_core/ui/ui'

module Fastlane

	UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

	module Helper

		class ToolkitGoogleHelper

			def self.show_message
				UI.message("Hello from the toolkit_google plugin helper!")
			end

			def self.update_env_file(key, value, file_path = '.env')
				# Read the existing .env file
				env_content = File.read(file_path)

				# Update or add the key-value pair
				if env_content.include?("#{key}")
					env_content.gsub!(/#{key}.*/, "#{key}=#{value}")
				else
					env_content << "\n#{key}=#{value}\n"
				end

				# Write the updated content back to the .env file
				File.open(file_path, 'w') { |file| file.write(env_content) }
			end
		end
	end
end
