require "spec_helper"

describe BankTools::GB::Account, "#valid?" do
  it "returns true with no errors" do
    expect(BankTools::GB::Account.new("31926819").valid?).to be true
  end

  it "returns false with errors" do
    expect(BankTools::GB::Account.new("1").valid?).to be false
  end

  it "ignores whitespace" do
    expect(BankTools::GB::Account.new("3192 6819").valid?).to be true
  end

  it "ignores dashes" do
    expect(BankTools::GB::Account.new("319-26819").valid?).to be true
  end
end

describe BankTools::GB::Account, "#errors" do
  let(:error_types) { BankTools::GB::Errors }

  it "returns an empty array when valid" do
    expect(BankTools::GB::Account.new("12345678").errors).to be_empty
    expect(BankTools::GB::Account.new("123 45-678").errors).to be_empty
  end

  it "includes ACCOUNT_TOO_SHORT if the account number is below 8 digits" do
    expect(BankTools::GB::Account.new("0031929").errors).to include(error_types::ACCOUNT_TOO_SHORT)
  end

  it "includes ACCOUNT_TOO_LONG if the account number is above 8 digits" do
    expect(BankTools::GB::Account.new("123456789").errors).to include(error_types::ACCOUNT_TOO_LONG)
  end

  it "includes ACCOUNT_INVALID_CHARACTERS if the account number have any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::Account.new("1234567x").errors).to include(error_types::ACCOUNT_INVALID_CHARACTERS)
  end
end
