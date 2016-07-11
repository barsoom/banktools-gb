require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class AccountNumberWithSortCode
      extend AttrExtras.mixin

      ACCOUNT_NUMBER_MIN_LENGTH = 6
      ACCOUNT_NUMBER_MAX_LENGTH = 10

      SORT_CODE_LENGTH = 6

      pattr_initialize [ :account_number, :sort_code ]

      def valid?
        errors.none?
      end

      def errors
        errors = []

        errors << Errors::ACCOUNT_NUMBER_IS_TOO_SHORT if compact_account_number.length < ACCOUNT_NUMBER_MIN_LENGTH
        errors << Errors::ACCOUNT_NUMBER_IS_TOO_LONG if compact_account_number.length > ACCOUNT_NUMBER_MAX_LENGTH
        errors << Errors::ACCOUNT_NUMBER_CONTAINS_INVALID_CHARACTERS if any_non_digits?(compact_account_number)

        errors << Errors::SORT_CODE_IS_TOO_SHORT if compact_sort_code.length < SORT_CODE_LENGTH
        errors << Errors::SORT_CODE_IS_TOO_LONG if compact_sort_code.length > SORT_CODE_LENGTH
        errors << Errors::SORT_CODE_CONTAINS_INVALID_CHARACTERS if any_non_digits?(compact_sort_code)

        errors
      end

      private

      def any_non_digits?(number)
        number.match(/\D/)
      end

      def compact_sort_code
        compact(sort_code)
      end

      def compact_account_number
        compact(account_number)
      end

      def compact(number)
        number.gsub(/[\s-]/, "")
      end
    end
  end
end
