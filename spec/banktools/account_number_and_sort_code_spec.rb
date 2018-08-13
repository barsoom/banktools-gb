require "spec_helper"

describe BankTools::GB::AccountNumberAndSortCode, "#valid?" do
  it "returns true with no errors" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "31926819", sort_code_original_value: "601613").valid?).to be true
  end

  it "returns false with errors" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "1", sort_code_original_value: "").valid?).to be false
  end

  it "ignores whitespace" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "3192 6819", sort_code_original_value: "60 16 13").valid?).to be true
  end

  it "ignores dashes" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "319-26819", sort_code_original_value: "60-16-13").valid?).to be true
  end
end

describe BankTools::GB::AccountNumberAndSortCode, "#errors" do
  Errors ||= BankTools::GB::Errors

  it "returns an empty array when valid" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "31926819", sort_code_original_value: "60-16-13").errors).to be_empty
  end

  it "includes ACCOUNT_TOO_SHORT if the account number is below 6 digits" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "31929", sort_code_original_value: "60-16-13").errors).to include(Errors::ACCOUNT_TOO_SHORT)
  end

  it "includes SORT_CODE_TOO_LONG if the sort code is above 6 digits" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "31929000", sort_code_original_value: "60-16-13-1").errors).to include(Errors::SORT_CODE_TOO_LONG)
  end

  it "includes BAD_CHECKSUM if the account number and the sort code does not match" do
    expect(BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: "92620772", sort_code_original_value: "56-00-29").errors).to include(Errors::BAD_CHECKSUM)
  end
end
