require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class Account
      extend AttrExtras.mixin

      # Officially, bank accounts in the UK can be between 6 and 10 numbers, but
      # the standard is 8, and any system that receives them will require them to
      # be zero-padded. Customers should be used to prepend zeroes, and it should not be an issue.
      # If this becomes an issue, lets consider handling auto-zeropadding, but it is both
      # less technical issues and easier to give feedback to the user if we enforce the 8 digit length rule.
      LENGTH = 8

      pattr_initialize :original_value

      def valid?
        errors.none?
      end

      def errors
        errors = []

        errors << Errors::ACCOUNT_TOO_SHORT if compacted_value.length < LENGTH
        errors << Errors::ACCOUNT_TOO_LONG if compacted_value.length > LENGTH
        errors << Errors::ACCOUNT_INVALID_CHARACTERS if any_non_digits?

        errors
      end

      def compacted_value
        original_value.to_s.gsub(/[\s-]/, "")
      end

      private

      def any_non_digits?
        compacted_value.match(/\D/)
      end
    end
  end
end
