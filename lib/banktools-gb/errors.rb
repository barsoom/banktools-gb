module Banktools
  module GB
    module Errors
      ACCOUNT_NUMBER_IS_TOO_SHORT             = :account_number_is_too_short
      ACCOUNT_NUMBER_IS_TOO_LONG              = :account_number_is_too_long
      SORT_CODE_WITH_WRONG_LENGTH             = :sort_code_with_wrong_length
      SORT_CODE_WITH_INVALID_CHARACTERS       = :sort_code_with_invalid_characters
      ACCOUNT_NUMBER_WITH_INVALID_CHARACTERS  = :account_number_with_invalid_characters
      ACCOUNT_NUMBER_DOES_NOT_MATCH_SORT_CODE = :account_number_does_not_match_sort_code
    end
  end
end
