require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class AccountNumberAndSortCode
      extend AttrExtras.mixin

      pattr_initialize [ :account_number_original_value, :sort_code_original_value ]

      def valid?
        errors.none?
      end

      def errors
        errors = []

        errors << account_number.errors
        errors << sort_code.errors
        errors << Errors::BAD_CHECKSUM unless valid_account_number_and_sort_code?

        errors.flatten
      end

      private

      def account_number
        Account.new(account_number_original_value)
      end

      def sort_code
        SortCode.new(sort_code_original_value)
      end

      def valid_account_number_and_sort_code?
        UkAccountValidator::Validator.new(account_number.compacted_value, sort_code.compacted_value).valid?
      end
    end
  end
end
