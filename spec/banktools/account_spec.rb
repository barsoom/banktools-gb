require "spec_helper"

describe Banktools::GB::Account, "#valid?" do
  it "is true with no errors" do
    expect(Banktools::GB::Account.new("60-16-13 31926819")).to be_valid
  end

  it "is false with errors" do
    expect(Banktools::GB::Account.new("1")).not_to be_valid
  end
end

describe Banktools::GB::Account, "#errors" do
  it "is empty when valid" do
    expect(Banktools::GB::Account.new("60-16-13 31926819").errors).to be_empty
  end
end
