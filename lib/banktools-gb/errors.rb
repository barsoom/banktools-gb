module Banktools
  module GB
    module Errors
      SORT_CODE_IS_TOO_SHORT                     = :sort_code_is_too_short
      SORT_CODE_IS_TOO_LONG                      = :sort_code_is_too_long
      SORT_CODE_CONTAINS_INVALID_CHARACTERS      = :sort_code_contains_invalid_characters

      ACCOUNT_NUMBER_IS_TOO_SHORT                = :account_number_is_too_short
      ACCOUNT_NUMBER_IS_TOO_LONG                 = :account_number_is_too_long
      ACCOUNT_NUMBER_CONTAINS_INVALID_CHARACTERS = :account_number_contains_invalid_characters
    end
  end
end
