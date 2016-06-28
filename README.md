# United Kingdom banktools

Ruby gem to validate and normalize United Kingdom bank account numbers.

If we got anything wrong, please file an issue or contribute a fix yourself.

## Usage

    account = BankTools::GB::Account.new("60-16-13 31926819")
    account.valid?  # => true
    account.errors  # => []

    bad_account = BankTools::DK::Account.new("1")
    bad_account.valid?  # => false
    bad_account.errors  # => [:too_short]

    # Error codes

    BankTools::GB::Errors::TOO_SHORT                # => :too_short
    BankTools::GB::Errors::TOO_LONG                 # => :too_long
    BankTools::GB::Errors::INVALID_CHARACTERS       # => :invalid_characters

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

## Credits

* [Hayden Ball](https://github.com/ball-hayden) for creating [UkAccountValidator](https://github.com/ball-hayden/uk_account_validator) that we base this gem on.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/banktools-gb.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
