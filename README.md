# United Kingdom bank tools

[![Build Status](https://travis-ci.org/barsoom/banktools-gb.svg?branch=master)](https://travis-ci.org/barsoom/banktools-gb)

Ruby gem to validate United Kingdom sort codes and bank account numbers.

When in doubt, this library aims to err on the side of allowing too much.

If we got anything wrong, please file an issue or contribute a fix yourself.

## Usage

    # Sort code

    sort_code = BankTools::GB::SortCode.new("60-16-13")
    sort_code.valid?  # => true
    sort_code.errors  # => []

    bad_sort_code = BankTools::GB::SortCode.new("1X")
    bad_sort_code.valid?  # => false
    bad_sort_code.errors  # => [ :too_short, :invalid_characters ]

    # Account

    account = BankTools::GB::Account.new("31926819")
    account.valid?  # => true
    account.errors  # => []

    bad_account = BankTools::GB::Account.new("1")
    bad_account.valid?  # => false
    bad_account.errors  # => [ :too_short ]


    # Account and sort code (checksum check and others)
    # This relies on [our fork of the uk_account_validator gem](https://github.com/barsoom/uk_account_validator). If that gem is out of date, the checksum check may be also.

    account_and_sort_code = BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: 14248387, sort_code_original_value: 405161).valid?
    account_and_sort_code.valid?  # => true
    account_and_sort_code.errors  # => []

    account_and_sort_code = BankTools::GB::AccountNumberAndSortCode.new(account_number_original_value: 14248387, sort_code_original_value: "xx")
    account_and_sort_code.valid?  # => false
    account_and_sort_code.errors  # => [:sort_code_too_short, :sort_code_invalid_characters, :bad_checksum]

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

* [Our other BankTools](https://github.com/barsoom?q=banktools)
* [BanklineCsvImportFile](https://github.com/barsoom/bankline_csv_import_file)

## Credits

* [Hayden Ball](https://github.com/ball-hayden) for creating [UkAccountValidator](https://github.com/ball-hayden/uk_account_validator) that we base this gem on.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
