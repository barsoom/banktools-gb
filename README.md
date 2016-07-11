# United Kingdom bank tools

[![Build Status](https://travis-ci.org/barsoom/banktools-gb.svg?branch=master)](https://travis-ci.org/barsoom/banktools-gb)

Ruby gem to validate United Kingdom bank account numbers.

If we got anything wrong, please file an issue or contribute a fix yourself.

## Usage

    account = BankTools::GB::AccountNumberWithSortCode.new(account_number: "31926819", sort_code: "60-16-13")
    account.valid?  # => true
    account.errors  # => []

    bad_account = BankTools::GB::AccountNumberWithSortCode.new(account_number: "1", sort_code: "")
    bad_account.valid?  # => false
    bad_account.errors  # => [:account_number_is_too_short]

    # Error codes

    BankTools::GB::Errors::ACCOUNT_NUMBER_IS_TOO_SHORT              # => :account_number_is_too_short
    BankTools::GB::Errors::ACCOUNT_NUMBER_IS_TOO_LONG               # => :account_number_is_too_long
    BankTools::GB::Errors::SORT_CODE_WITH_WRONG_LENGTH              # => :sort_code_with_wrong_length
    BankTools::GB::Errors::ACCOUNT_NUMBER_WITH_INVALID_CHARACTERS   # => :account_number_with_invalid_characters
    BankTools::GB::Errors::SORT_CODE_WITH_INVALID_CHARACTERS        # => :sort_code_with_invalid_characters

## Installation

Add this line to your application's Gemfile:

    gem "banktools-gb"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install banktools-gb

## Tests

    bundle
    rspec  # or: rake

## Also see

* [BankTools::SE (Swedish)](https://github.com/barsoom/banktools-se)
* [BankTools::DE (German)](https://github.com/barsoom/banktools-de)
* [BankTools::DK (German)](https://github.com/barsoom/banktools-dk)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/banktools-gb.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
