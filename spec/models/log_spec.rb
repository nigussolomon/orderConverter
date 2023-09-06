require 'rails_helper'

RSpec.describe Log, type: :model do
  it "has a valid factory" do
    expect(build(:log)).to be_valid
  end

  it "is invalid without a message" do
    expect(build(:log, message: nil)).to_not be_valid
  end
end
