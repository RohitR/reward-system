# frozen_string_literal: true

module RewardSystem
  # Repository for invites and customer data
  class Repository
    include Singleton
    attr_reader :invites, :customers

    def initialize
      flush_all
    end

    def add_customer(customer)
      @customers << customer
    end

    def add_invite(invite)
      @invites << invite
    end

    def flush_all
      @invites = []
      @customers = []
    end
  end
end
