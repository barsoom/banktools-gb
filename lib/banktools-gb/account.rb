module Banktools
  module GB
    class Account
      pattr_initialize :account_number_with_sort_code

      def valid?
        UkAccountValidator::Validator.new(account_number, sort_code).valid?
      end

      def errors
        []
      end

      private

      def account_number
        account_number_with_sort_code.split(" ").last
      end

      def sort_code
        account_number_with_sort_code.split(" ").first
      end
    end
  end
end
