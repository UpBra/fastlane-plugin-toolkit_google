module Fastlane

	module Actions

		class PlaySetupAction < Action

			def self.run(params)
				FastlaneRequire.install_gem_if_needed(gem_name: 'fastlane-plugin-app_info', require_gem: true)

				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for play_setup',
					mask_keys: [:json_key]
				)

				files = params[:file]
				file = files.first

				unless file
					UI.important("No files found. Skipping...")
					return
				end

				info = ::AppInfo.parse(file)

				ENV['SUPPLY_SETUP_NAME'] = info.name
				ENV['SUPPLY_PACKAGE_NAME'] = info.bundle_id
				ENV['SUPPLY_VERSION_NAME'] = info.release_version
				ENV['SUPPLY_VERSION_CODE'] = info.build_version
			end

			#####################################################
			# @!group Documentation
			#####################################################

			def self.description
				'Setup environment variables used by `supply` by inspecting an application file'
			end

			def self.available_options
				[
					FastlaneCore::ConfigItem.new(
						key: :file,
						env_name: 'PLAY_SETUP_FILE',
						description: 'File (apk or aab) to use for setup',
						type: Array,
						default_value: lane_context[SharedValues::GRADLE_AAB_OUTPUT_PATH]
					)
				]
			end

			def self.output
				[]
			end

			def self.authors
				['UpBra']
			end

			def self.is_supported?(_)
				true
			end
		end
	end
end
