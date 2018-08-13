require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class SortCode
      extend AttrExtras.mixin

      LENGTH = 6

      pattr_initialize :original_value

      def valid?
        errors.none?
      end

      def errors
        errors = []

        errors << Errors::SORT_CODE_TOO_SHORT if compacted_value.length < LENGTH
        errors << Errors::SORT_CODE_TOO_LONG if compacted_value.length > LENGTH
        errors << Errors::SORT_CODE_INVALID_CHARACTERS if any_non_digits?

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
