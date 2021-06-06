# frozen_string_literal: true

module RewardSystem
  module Errors
    # top level class for user related exceptions
    class UserError < StandardError
      def initialize(user)
        @user = user
      end
    end

    # User without invitation
    class CustomerNotInvited < UserError
      def message
        "Customer #{@user} is not invited by anyone"
      end
    end

    # User not found
    class CustomerNotFound < UserError
      def message
        "Customer #{@user} is not existing in the system. "\
        "Someone should recommend #{@user} before accept or rejection"
      end
    end

    # User not found
    class CustomerExists < UserError
      def message
        "Customer #{@user} is already existing in the system. "\
        'You canot update an active customer'
      end
    end

    # File not found
    class FileNotFound < StandardError
      def message
        'File is missing'
      end
    end
  end
end
