# -------------------------------------------------------------------------
#
# Post Status
# Posts status messages to multiple chat clients (Teams and Slack)
#
# -------------------------------------------------------------------------

module Status

	Actions = Fastlane::Actions
	SharedValues = Actions::SharedValues

	def self.add_play_deploy_facts
		return unless name ||= Actions.lane_context.fetch(SharedValues::PLAY_DEPLOY_APP_DISPLAY_NAME)
		return unless value ||= Actions.lane_context.fetch(SharedValues::PLAY_DEPLOY_APP_GOOGLE_PLAY_URL)

		Status.add_fact(name, value)
	end
end