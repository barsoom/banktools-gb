require "spec_helper"

describe BankTools::GB::SortCode, "#valid?" do
  it "returns true with no errors" do
    expect(BankTools::GB::SortCode.new("601613").valid?).to be true
  end

  it "returns false with errors" do
    expect(BankTools::GB::SortCode.new("").valid?).to be false
  end

  it "ignores whitespace" do
    expect(BankTools::GB::SortCode.new("60 16 13").valid?).to be true
  end

  it "ignores dashes" do
    expect(BankTools::GB::SortCode.new("60-16-13").valid?).to be true
  end
end

describe BankTools::GB::SortCode, "#errors" do
  let(:error_types) { BankTools::GB::Errors }

  it "returns an empty array when valid" do
    expect(BankTools::GB::SortCode.new("601613").errors).to be_empty
  end

  it "includes SORT_CODE_TOO_SHORT if the sort code is below 6 digits" do
    expect(BankTools::GB::SortCode.new("60-16-1").errors).to include(error_types::SORT_CODE_TOO_SHORT)
  end

  it "includes SORT_CODE_TOO_LONG if the sort code is above 6 digits" do
    expect(BankTools::GB::SortCode.new("60-16-11-1").errors).to include(error_types::SORT_CODE_TOO_LONG)
  end

  it "includes SORT_CODE_INVALID_CHARACTERS if the sort code has any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::SortCode.new("60-16-13x").errors).to include(error_types::SORT_CODE_INVALID_CHARACTERS)
  end
end
