describe Fastlane::Actions::CopywriterAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The copywriter plugin is working!")

      Fastlane::Actions::CopywriterAction.run(nil)
    end
  end
end
