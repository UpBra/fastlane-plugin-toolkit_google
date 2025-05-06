# -------------------------------------------------------------------------
#
# update_gradle_properties
# Updates Key/Values in gradle.properties file
#
# -------------------------------------------------------------------------

module Fastlane

	module Actions

		class UpdateGradlePropertiesAction < Action

			module Key
				FILE = :file
				KEY = :key
				VALUE = :value
			end

			def self.run(params)
				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for update_gradle_properties',
					mask_keys: []
				)

				file ||= params[Key::FILE]
				key ||= params[Key::KEY]
				value ||= params[Key::VALUE]

				Helper::ToolkitGoogleHelper.update_env_file(key, value, file)

				UI.success("Updated #{key} to #{value} in #{file}")
			end

			#####################################################
			# @!group Documentation
			#####################################################

			def self.description
				'Updates key/values in gradle.properties files'
			end

			def self.available_options
				[
					FastlaneCore::ConfigItem.new(
						key: Key::FILE,
						env_name: 'UPDATE_GRADLE_PROPERTIES_FILE',
						description: 'Path to gradle.properties file',
						default_value: "gradle.properties",
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: Key::KEY,
						env_name: 'UPDATE_GRADLE_PROPERTIES_KEY',
						description: 'The key',
						type: String
					),
					FastlaneCore::ConfigItem.new(
						key: Key::VALUE,
						env_name: 'UPDATE_GRADLE_PROPERTIES_VALUE',
						description: 'The new value',
						type: String
					)
				]
			end

			def self.output
				[]
			end

			def self.authors
				["UpBra"]
			end

			def self.is_supported?(platform)
				platform == :android
			end
		end
	end
end
