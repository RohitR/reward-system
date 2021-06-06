# frozen_string_literal: true

module RewardSystem
  # Represents the connection beteween customers.
  # Considering only accepted invites for building tree structure.
  class Invite
    attr_reader :customer_id, :friend_id, :status, :id, :invited_at

    def self.create(customer_id:, friend_id:, status:, invited_at:)
      invite = new(customer_id, friend_id, status, invited_at)
      REPO.add_invite(invite)
      invite
    end

    def self.update!(friend:, status:)
      invite = REPO.invites.find { |inv| inv.friend_id == friend.id }
      raise Errors::CustomerNotInvited, friend.name unless invite

      invite.update_status(status)
    end

    def self.accepted
      # Scope for accepted invites

      REPO.invites.select { |invite| invite.status == 'accepts' }
    end

    private_class_method :new

    def initialize(customer_id, friend_id, status, invited_at)
      @customer_id = customer_id
      @friend_id = friend_id
      @status = status
      @id = SecureRandom.uuid
      @invited_at = invited_at
    end

    def update_status(status)
      @status = status
    end
  end
end
