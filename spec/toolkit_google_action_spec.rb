describe Fastlane::Actions::ToolkitGoogleAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The toolkit_google plugin is working!")

      Fastlane::Actions::ToolkitGoogleAction.run(nil)
    end
  end
end
