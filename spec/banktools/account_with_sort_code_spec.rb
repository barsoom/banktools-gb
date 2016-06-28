require "spec_helper"

describe BankTools::GB::AccountWithSortCode, "#valid?" do
  it "returns true with no errors" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31926819", sort_code: "601613").valid?).to be true
  end

  it "returns false with errors" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "1", sort_code: "").valid?).to be false
  end

  it "ignores whitespace" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31926819", sort_code: "601613").valid?).to be true
  end

  it "ignores dashes" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31926819", sort_code: "60-16-13").valid?).to be true
  end
end

describe BankTools::GB::AccountWithSortCode, "#errors" do
  Errors ||= Banktools::GB::Errors

  it "returns an empty array when valid" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31926819", sort_code: "60-16-13").errors).to be_empty
  end

  it "includes ACCOUNT_NUMBER_TOO_SHORT if the account number is below 6 digits" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31929", sort_code: "60-16-13").errors).to include(Errors::ACCOUNT_NUMBER_TOO_SHORT)
  end

  it "includes ACCOUNT_NUMBER_TOO_LONG if the account number is above 10 digits" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "319290000000", sort_code: "60-16-13").errors).to include(Errors::ACCOUNT_NUMBER_TOO_LONG)
  end

  it "includes SORT_CODE_WITH_WRONG_LENGTH if the sort code doesn't include 6 digits" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31929000", sort_code: "60-16-1").errors).to include(Errors::SORT_CODE_WITH_WRONG_LENGTH)
    expect(BankTools::GB::AccountWithSortCode.new(account_number: "31929000", sort_code: "60-16-11-11").errors).to include(Errors::SORT_CODE_WITH_WRONG_LENGTH)
  end

  it "includes INVALID_CHARACTERS if the account number or sort code have any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::AccountWithSortCode.new(account_number: ".31929000z", sort_code: "60-16-13").errors).to include(Errors::INVALID_CHARACTERS)
  end
end
