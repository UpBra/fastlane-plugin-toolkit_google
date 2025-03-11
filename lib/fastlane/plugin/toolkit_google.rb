require 'fastlane/plugin/toolkit_google/version'

module Fastlane

	module ToolkitGoogle

		def self.all_classes
			Dir[File.expand_path('**/{actions,helper,source}/*.rb', File.dirname(__FILE__))]
		end
	end
end

Fastlane::ToolkitGoogle.all_classes.each do |current|
	require current
end
