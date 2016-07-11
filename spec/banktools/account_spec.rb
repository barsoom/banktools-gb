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
    expect(BankTools::GB::Account.new("123456").errors).to be_empty
    expect(BankTools::GB::Account.new("123 45-6").errors).to be_empty
  end

  it "includes TOO_SHORT if the account number is below 6 digits" do
    expect(BankTools::GB::Account.new("31929").errors).to include(error_types::TOO_SHORT)
  end

  it "includes TOO_LONG if the account number is above 10 digits" do
    expect(BankTools::GB::Account.new("12345678901").errors).to include(error_types::TOO_LONG)
  end

  it "includes INVALID_CHARACTERS if the account number have any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::Account.new("12345678x").errors).to include(error_types::INVALID_CHARACTERS)
  end
end
