require "rails_helper"

RSpec.describe Log, type: :model do
  it "has a valid factory" do
    expect(build(:log)).to be_valid
  end

  it { is_expected.to validate_presence_of(:message) }
end
