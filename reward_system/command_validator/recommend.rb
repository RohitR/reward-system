# frozen_string_literal: true

module RewardSystem
  # Recommend specific validations
  class Recommend < CommandValidator
    def initialize(command, friend, customer)
      super(command, friend)
      @customer = customer
    end

    def validate!
      raise Errors::CustomerRecommendsItself, @command if @friend == @customer

      customer_exists?
      raise Errors::CustomerNameBlank, @command if blank_name?
      return if @customer.absolute_root? || @customer.active?

      raise Errors::CustomerInactive, @command
    end

    private

    def blank_name?
      @friend.name.empty? || @customer.name.empty?
    end
  end
end
