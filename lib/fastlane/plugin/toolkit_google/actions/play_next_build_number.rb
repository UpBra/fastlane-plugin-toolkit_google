module Fastlane

	module Actions

		module SharedValues
			PLAY_NEXT_BUILD_NUMBER = :PLAY_NEXT_BUILD_NUMBER
			PLAY_NEXT_BUILD_NUMBER_ALL = :PLAY_NEXT_BUILD_NUMBER_ALL
		end

		class PlayNextBuildNumberAction < Action

			def self.run(params)
				FastlaneCore::PrintTable.print_values(
					config: params,
					title: 'Summary for play_next_build_number',
					mask_keys: [:json_key]
				)

				available = Fastlane::Actions::GooglePlayTrackVersionCodesAction.available_options.map(&:key)
				options = params.values.clone.keep_if { |k,v| available.include?(k) }
				options.transform_keys(&:to_sym)

				tracks = []
				tracks << params[:track] if params[:track]
				tracks << 'internal' unless tracks.include?('internal')
				tracks << 'produciton' unless tracks.include?('production')

				begin
					version_codes = [0]

					tracks.each do |t|
						options[:track] = t
						version_codes += other_action.google_play_track_version_codes(options)
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

			def self.available_options
				Fastlane::Actions::GooglePlayTrackVersionCodesAction.available_options
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
