# United Kingdom bank tools

[![Ruby CI](https://github.com/barsoom/banktools-gb/actions/workflows/ci.yml/badge.svg)](https://github.com/barsoom/banktools-gb/actions/workflows/ci.yml)

Ruby gem to validate United Kingdom sort codes and bank account numbers.

When in doubt, this library aims to err on the side of allowing too much.

If we got anything wrong, please file an issue or contribute a fix yourself.

## Usage

```ruby
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
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "banktools-gb"
```

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
