# -------------------------------------------------------------------------
#
# Droid
# Alias for the `gradle` action with Droidfile support
#
# -------------------------------------------------------------------------

module Fastlane

	module Actions

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
