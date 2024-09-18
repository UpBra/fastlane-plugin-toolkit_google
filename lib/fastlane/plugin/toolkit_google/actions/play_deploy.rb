module Fastlane

	module Actions

		module SharedValues
			PLAY_DEPLOY_APP_DISPLAY_NAME = :PLAY_DEPLOY_APP_DISPLAY_NAME
			PLAY_DEPLOY_APP_GOOGLE_PLAY_URL = :PLAY_DEPLOY_APP_GOOGLE_PLAY_URL
		end

		class PlayDeployAction < Action

			def self.run(params)
				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for play_deploy',
					mask_keys: [:json_key]
				)

				available = Fastlane::Actions::SupplyAction.available_options.map(&:key)
				options = params.values.clone.keep_if { |k,v| available.include?(k) }
				options.transform_keys(&:to_sym)

				other_action.supply(options)

				name = ENV.fetch('SUPPLY_SETUP_NAME')
				name ||= params[:package_name]
				version_name = params[:version_name]
				version_code = params[:version_code]

				display_name = [name, version_name, "(#{version_code})"].join(' ')
				lane_context[SharedValues::PLAY_DEPLOY_APP_DISPLAY_NAME] = display_name

				identifier = params[:package_name]
				lane_context[SharedValues::PLAY_DEPLOY_APP_GOOGLE_PLAY_URL] = "https://play.google.com/store/apps/details?id=#{identifier}"
			end

			#####################################################
			# @!group Documentation
			#####################################################

			def self.description
				'Wrapper for the supply action'
			end

			def self.details
				"Calls `supply` and constructs app display name and google play url"
			end

			def self.available_options
				Fastlane::Actions::SupplyAction.available_options
			end

			def self.output
				Fastlane::Actions::SupplyAction.output
			end

			def self.return_value
				Fastlane::Actions::SupplyAction.return_value
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
