# -------------------------------------------------------------------------
#
# play_next_build_number
# Alias for the `google_play_track_version_codes` action with extras
#
# -------------------------------------------------------------------------

require 'fastlane/actions/google_play_track_version_codes'

module Fastlane

	module Actions

		module SharedValues
			PLAY_NEXT_BUILD_NUMBER = :PLAY_NEXT_BUILD_NUMBER
			PLAY_NEXT_BUILD_NUMBER_ALL = :PLAY_NEXT_BUILD_NUMBER_ALL
		end

		class PlayNextBuildNumberAction < GooglePlayTrackVersionCodesAction

			def self.run(params)
				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for play_next_build_number',
					mask_keys: [:json_key]
				)

				tracks = ['internal']
				tracks << params[:track] if params[:track]
				tracks << 'produciton' unless tracks.include?('production')

				begin
					version_codes = [0]

					tracks.each do |t|
						params[:track] = t
						version_codes += super(params)
					end
				rescue StandardError => e
					UI.error(e)
				end

				lane_context[SharedValues::PLAY_NEXT_BUILD_NUMBER_ALL] = version_codes

				version_code = version_codes.max.next
				lane_context[SharedValues::PLAY_NEXT_BUILD_NUMBER] = version_code.to_s
			end

			#####################################################
			# @!group Documentation
			#####################################################

			def self.description
				'Returns the next build number by querying internal and production tracks and incrementing the highest by 1'
			end

			def self.output
				[
					['PLAY_NEXT_BUILD_NUMBER', self.return_value],
					['PLAY_NEXT_BUILD_NUMBER_ALL', 'All build numbers queried from tracks']
				]
			end

			def self.return_value
				'The next build number.'
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
