# frozen_string_literal: true

module RewardSystem
  # Input command validator
  class CommandValidator
    def validate!
      raise 'NotImplementedError!'
    end

    def initialize(command, friend)
      @command = command
      @friend = friend
    end

    def customer_exists?
      raise Errors::CustomerExists, @command if @friend.active?
    end
  end
end
