require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class AccountWithSortCode
      extend AttrExtras.mixin

      ACCOUNT_NUMBER_MIN_LENGTH = 6
      ACCOUNT_NUMBER_MAX_LENGTH = 10
      SORT_CODE_LENGTH = 6

      pattr_initialize [ :account_number, :sort_code ]

      def valid?
        UkAccountValidator::Validator.new(compact_account_number, compact_sort_code).valid?
      end

      def errors
        errors = []
        errors << :account_number_too_short if account_number_too_short?
        errors << :account_number_too_long if account_number_too_long?
        errors << :sort_code_with_wrong_length if sort_code_with_wrong_length?
        errors << :invalid_characters if any_non_digits?
        errors
      end

      private

      def sort_code_with_wrong_length?
        compact_sort_code.length != SORT_CODE_LENGTH
      end

      def account_number_too_short?
        compact_account_number.length < ACCOUNT_NUMBER_MIN_LENGTH
      end

      def account_number_too_long?
        compact_account_number.length > ACCOUNT_NUMBER_MAX_LENGTH
      end

      def any_non_digits?
        [ compact_sort_code, compact_account_number ].any? { |number| number.match(/\D/) }
      end

      def compact_sort_code
        sort_code.gsub(/[\s-]/, "")
      end

      def compact_account_number
        account_number.gsub(/[\s-]/, "")
      end
    end
  end
end
