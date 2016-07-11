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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
