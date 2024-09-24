module Fastlane

	module Actions

		module SharedValues
			PLAY_DEPLOY_APP_DISPLAY_NAME = :PLAY_DEPLOY_APP_DISPLAY_NAME
			PLAY_DEPLOY_APP_GOOGLE_PLAY_URL = :PLAY_DEPLOY_APP_GOOGLE_PLAY_URL
		end

		class PlayDeployAction < SupplyAction

			def self.run(params)
				super(params)

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

			def self.authors
				['UpBra']
			end

			def self.is_supported?(_)
				true
			end
		end
	end
end
