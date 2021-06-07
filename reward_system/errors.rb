# frozen_string_literal: true

module RewardSystem
  module Errors
    # top level class for customer related exceptions
    class FileParserError < StandardError
      def initialize(command)
        @command = command
      end

      def message
        "'#{@command}' Not a valid command. "
      end
    end

    # customer without invitation
    class CustomerNotInvited < FileParserError
      def message
        "Customer #{@user} is not invited by anyone"
      end
    end

    # customer not found
    class CustomerNotFound < FileParserError
      def message
        super + 'Someone should recommend before accept or rejection'
      end
    end

    # Customer name is blank
    class CustomerNameBlank < FileParserError
      def message
        super + 'Customer name is blank'
      end
    end

    # customer not found
    class CustomerExists < FileParserError
      def message
        super + 'You canot update an active customer'
      end
    end

    # customer recommends itself
    class CustomerRecommendsItself < FileParserError
      def message
        super + 'Customer Recommends itself.'
      end
    end

    # customer should be root or invitation accepted to recommend others.
    class CustomerInactive < FileParserError
      def message
        super + 'An inactive customer can not recommend anyone. '\
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
