# -------------------------------------------------------------------------
#
# Droid
# Alias for the `gradle` action with Droidfile support
#
# -------------------------------------------------------------------------

require 'fastlane/actions/gradle'

module Fastlane

	module Actions

		GradleAction = Fastlane::Actions::GradleAction unless Fastlane::Actions.const_defined?(:GradleAction)

		class DroidAction < GradleAction

			def self.run(params)
				params.load_configuration_file("Droidfile")

				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for droid',
					mask_keys: [:properties]
				)

				super(params)
			end

			#####################################################
			# @!group Documentation
			#####################################################

			def self.authors
				['UpBra']
			end
		end
	end
end
