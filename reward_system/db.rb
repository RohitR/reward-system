# frozen_string_literal: true

module RewardSystem
  # Loads data into memory.
  # Populates data into customers and invites
  class Db
    def self.prepare(file)
      new(file: file).prepare
    end

    private_class_method :new

    def prepare
      commands.each do |command|
        if command['action'] == 'recommends'
          build_invite(command)
        else
          friend = Customer.find_by_name(command['customer'])
          raise Errors::CustomerNotFound, command['customer'] unless friend
          raise Errors::CustomerExists, friend.name if friend.active?

          Invite.update!(friend: friend, status: command['action'])
        end
      end
    end

    attr_reader :file

    def commands
      FileParser.build(file).sort_by do |command|
        command['datetime']
      end
    end

    def initialize(file:)
      @file = file
    end

    def build_invite(command)
      customer = Customer.find_or_create(name: command['customer'])
      friend = Customer.find_or_create(name: command['friend'].strip)
      raise Errors::CustomerExists, friend.name if friend.active?

      Invite.create(
        customer_id: customer.id,
        friend_id: friend.id,
        status: :pending,
        invited_at: command['datetime']
      )
    end
  end
end
