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
        errors << :account_number_is_too_short if account_number_is_too_short?
        errors << :account_number_is_too_long if account_number_is_too_long?
        errors << :sort_code_with_wrong_length if sort_code_with_wrong_length?
        errors << :sort_code_with_invalid_characters if any_non_digits?(compact_sort_code)
        errors << :account_number_with_invalid_characters if any_non_digits?(compact_account_number)
        errors
      end

      private

      def sort_code_with_wrong_length?
        compact_sort_code.length != SORT_CODE_LENGTH
      end

      def account_number_is_too_short?
        compact_account_number.length < ACCOUNT_NUMBER_MIN_LENGTH
      end

      def account_number_is_too_long?
        compact_account_number.length > ACCOUNT_NUMBER_MAX_LENGTH
      end

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
