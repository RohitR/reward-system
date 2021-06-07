# frozen_string_literal: true

module RewardSystem
  # Respond specific validations
  class Respond < CommandValidator
    def validate!
      raise Errors::CustomerNotFound, @command unless @friend
      raise Errors::CustomerExists, @command if @friend.active?
    end
  end
end
