require "spec_helper"

describe BankTools::GB::AccountNumberWithSortCode, "#valid?" do
  it "returns true with no errors" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "31926819", sort_code: "601613").valid?).to be true
  end

  it "returns false with errors" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "1", sort_code: "").valid?).to be false
  end

  it "ignores whitespace" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "3192 6819", sort_code: "60 16 13").valid?).to be true
  end

  it "ignores dashes" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "319-26819", sort_code: "60-16-13").valid?).to be true
  end
end

describe BankTools::GB::AccountNumberWithSortCode, "#errors" do
  Errors ||= Banktools::GB::Errors

  it "returns an empty array when valid" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "31926819", sort_code: "60-16-13").errors).to be_empty
  end

  it "includes ACCOUNT_NUMBER_TOO_SHORT if the account number is below 6 digits" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "31929", sort_code: "60-16-13").errors).to include(Errors::ACCOUNT_NUMBER_TOO_SHORT)
  end

  it "includes ACCOUNT_NUMBER_TOO_LONG if the account number is above 10 digits" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "12345678901", sort_code: "60-16-13").errors).to include(Errors::ACCOUNT_NUMBER_TOO_LONG)
  end

  it "includes SORT_CODE_WITH_WRONG_LENGTH if the sort code doesn't include 6 digits" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "31929000", sort_code: "60-16-1").errors).to include(Errors::SORT_CODE_WITH_WRONG_LENGTH)
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "31929000", sort_code: "60-16-11-1").errors).to include(Errors::SORT_CODE_WITH_WRONG_LENGTH)
  end

  it "includes SORT_CODE_INVALID_CHARACTERS if the sort code have any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "", sort_code: "€60!-16-13ö").errors).to include(Errors::SORT_CODE_INVALID_CHARACTERS)
  end

  it "includes ACCOUNT_NUMBER_INVALID_CHARACTERS if the account number have any characters besides digits, whitespace and dashes" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "123.456ö78", sort_code: "").errors).to include(Errors::ACCOUNT_NUMBER_INVALID_CHARACTERS)
  end

  it "includes ACCOUNT_NUMBER_DOES_NOT_MATCH_SORT_CODE if the account number and the sort code does not match" do
    expect(BankTools::GB::AccountNumberWithSortCode.new(account_number: "92620772", sort_code: "56-00-29").errors).to include(Errors::ACCOUNT_NUMBER_DOES_NOT_MATCH_SORT_CODE)
  end
end
